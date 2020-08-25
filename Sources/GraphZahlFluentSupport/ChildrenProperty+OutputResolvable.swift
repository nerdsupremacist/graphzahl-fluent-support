
import Foundation
import Fluent
import GraphZahl
import GraphQL
import ContextKit

extension ChildrenProperty: Resolvable where To: Resolvable { }

extension ChildrenProperty: OutputResolvable where To: OutputResolvable & ConcreteResolvable { }

extension ChildrenProperty: DelegatedOutputResolvable where To: OutputResolvable & ConcreteResolvable {

    public func resolve(source: Any, arguments: [String : Map], context: MutableContext, eventLoop: EventLoopGroup) throws -> some OutputResolvable {
        print("Running Query for Children<\(From.self), \(To.self)>")
        fflush(stdout)
        return try query(on: context.database())
    }

}
