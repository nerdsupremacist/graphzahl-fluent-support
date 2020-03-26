
import Foundation
import GraphQL
import GraphZahl
import Fluent
import Runtime
import ContextKit

extension QueryBuilder: Resolvable where Model: Resolvable { }

extension QueryBuilder: OutputResolvable where Model: OutputResolvable & ConcreteResolvable {

    public static var additionalArguments: [String : InputResolvable.Type] {
        return QueryConnection<Model>.additionalArguments
    }

    public static func resolve(using context: inout Resolution.Context) throws -> GraphQLOutputType {
        return try context.resolve(type: QueryConnection<Model>.self)
    }

    public func resolve(source: Any,
                        arguments: [String : Map],
                        context: MutableContext,
                        eventLoop: EventLoopGroup) throws -> EventLoopFuture<Any?> {

        context.push {
            .database ~> database
        }

        return try QueryConnection(query: self).resolve(source: source, arguments: arguments, context: context, eventLoop: eventLoop)
    }
    
}
