
import Foundation
import NIO
import GraphZahl
import Fluent
import Runtime
import GraphQL
import ContextKit

struct QueryConnection<Node: Model & OutputResolvable & ConcreteResolvable> {
    static var concreteTypeName: String {
        return "\(Node.concreteTypeName)Connection"
    }

    let query: QueryBuilder<Node>

    init(query: QueryBuilder<Node>) {
        self.query = query
    }
}

extension QueryConnection: IndexedConnection {

    var identifier: some Hashable {
        return query.query.description
    }

    func totalCount(eventLoop: EventLoopGroup) -> EventLoopFuture<Int> {
        return query.count()
    }

    func nodes(offset: Int, size: Int, eventLoop: EventLoopGroup) -> EventLoopFuture<[Node?]?> {
        return query.range(lower: offset, upper: offset + size).all().map { $0 }
    }

}
