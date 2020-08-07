
import Foundation
import Fluent
import GraphZahl
import GraphQL
import ContextKit

extension OptionalParentProperty: Resolvable where To: Resolvable { }

extension OptionalParentProperty: OutputResolvable where To: OutputResolvable { }

extension OptionalParentProperty: DelegatedOutputResolvable where To: OutputResolvable {

    public func resolve(source: Any, arguments: [String : Map], context: MutableContext, eventLoop: EventLoopGroup) throws -> some OutputResolvable {
        return get(on: try context.database())
    }

}
