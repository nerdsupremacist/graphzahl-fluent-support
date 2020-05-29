
import Foundation
import Fluent
import GraphZahl
import GraphQL
import ContextKit

extension ChildrenProperty: Resolvable where To: Resolvable { }

extension ChildrenProperty: OutputResolvable where To: OutputResolvable & ConcreteResolvable {

    public static var additionalArguments: [String : InputResolvable.Type] {
        return QueryBuilder<To>.additionalArguments
    }

    public static func reference(using context: inout Resolution.Context) throws -> GraphQLOutputType {
        return try context.reference(for: Value.self)
    }

    public static func resolve(using context: inout Resolution.Context) throws -> GraphQLOutputType {
        return try context.resolve(type: QueryBuilder<To>.self)
    }

    public func resolve(source: Any,
                        arguments: [String : Map],
                        context: MutableContext,
                        eventLoop: EventLoopGroup) throws -> EventLoopFuture<Any?> {

        return try query(on: context.database()).resolve(source: source, arguments: arguments, context: context, eventLoop: eventLoop)
    }

}
