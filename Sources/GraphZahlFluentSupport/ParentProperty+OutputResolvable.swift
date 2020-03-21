
import Foundation
import Fluent
import GraphZahl
import GraphQL
import ContextKit

extension ParentProperty: Resolvable where To: Resolvable { }

extension ParentProperty: OutputResolvable where To: OutputResolvable {

    public static var additionalArguments: [String : InputResolvable.Type] {
        return To.additionalArguments
    }

    public static func resolve(using context: inout Resolution.Context) throws -> GraphQLOutputType {
        return try context.resolve(type: To.self)
    }

    public func resolve(source: Any,
                        arguments: [String : Map],
                        context: MutableContext,
                        eventLoop: EventLoopGroup) throws -> EventLoopFuture<Any?> {

        return get(on: context[.database])
            .flatMapThrowing { try $0.resolve(source: source, arguments: arguments, context: context, eventLoop: eventLoop) }
            .flatMap { $0 }
    }

}
