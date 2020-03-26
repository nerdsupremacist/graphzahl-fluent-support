
import Foundation
import NIO
import GraphZahl
import Fluent
import Runtime
import GraphQL
import ContextKit

struct QueryConnectionContext {
    let count: Int
    let range: Range<Int>
}

class QueryConnection<Node: Model & OutputResolvable & ConcreteResolvable>: ContextBasedConnection {
    static var concreteTypeName: String {
        return "\(Node.concreteTypeName)Connection"
    }

    let query: QueryBuilder<Node>

    init(query: QueryBuilder<Node>) {
        self.query = query
    }

    func context(first: Int?, after: String?, last: Int?, before: String?, eventLoop: EventLoopGroup) -> EventLoopFuture<QueryConnectionContext> {
        let count = query.count()
        var start = eventLoop.future(0)
        var end = count

        if let after = after {
            fatalError()
        }

        if let before = before {
            fatalError()
        }

        if let first = first {
            end = start.and(end).map { start, end in
                min(start + first, end)
            }
        }

        if let last = last {
            start = start.and(end).map { start, end in
                max(start, end - last)
            }
        }

        let range = start.and(end).map { $0..<$1 }
        return count.and(range).map { Context(count: $0, range: $1) }
    }

    func edges(context: QueryConnectionContext, eventLoop: EventLoopGroup) -> EventLoopFuture<[StandardEdge<Node>?]?> {
        return query
            .range(context.range)
            .all()
            .map { values in
                values.map { StandardEdge(node: $0, cursor: "TODO") }
            }
    }

    func pageInfo(context: QueryConnectionContext, eventLoop: EventLoopGroup) -> EventLoopFuture<PageInfo> {
        let info = PageInfo(hasNextPage: context.range.upperBound < context.count,
                            hasPreviousPage: context.range.lowerBound > 0,
                            startCursor: nil,
                            endCursor: nil)

        return eventLoop.future(info)
    }

    func totalCount(context: QueryConnectionContext, eventLoop: EventLoopGroup) -> EventLoopFuture<Int> {
        return eventLoop.future(context.count)
    }

}
