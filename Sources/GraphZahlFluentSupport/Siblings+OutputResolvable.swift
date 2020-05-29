
import Foundation
import Fluent
import GraphZahl
import GraphQL
import ContextKit

extension SiblingsProperty: Resolvable where To: Resolvable { }

extension SiblingsProperty: OutputResolvable where To: OutputResolvable & ConcreteResolvable { }

extension SiblingsProperty: DelegatedOutputResolvable where To: OutputResolvable & ConcreteResolvable {

    public func resolve(source: Any, arguments: [String : Map], context: MutableContext, eventLoop: EventLoopGroup) throws -> some OutputResolvable {
        return query(on: try context.database())
    }

}
