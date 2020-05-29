
import Foundation
import Fluent
import GraphZahl
import GraphQL
import ContextKit

extension ParentProperty: Resolvable where To: Resolvable { }

extension ParentProperty: OutputResolvable where To: OutputResolvable { }

extension ParentProperty: DelegatedOutputResolvable where To: OutputResolvable {

    public func resolve(source: Any, arguments: [String : Map], context: MutableContext, eventLoop: EventLoopGroup) throws -> some OutputResolvable {
        return get(on: try context.database())
    }

}
