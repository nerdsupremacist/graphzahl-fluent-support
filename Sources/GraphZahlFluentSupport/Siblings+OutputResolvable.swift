
import Foundation
import Fluent
import GraphZahl
import GraphQL
import ContextKit

extension SiblingsProperty: Resolvable where To: Resolvable { }

extension SiblingsProperty: OutputResolvable where To: OutputResolvable & ConcreteResolvable {

    public static var additionalArguments: [String : InputResolvable.Type] {
        return To.additionalArguments
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
