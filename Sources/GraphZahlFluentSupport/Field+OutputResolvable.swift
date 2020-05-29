
import Foundation
import Fluent
import GraphZahl
import GraphQL
import ContextKit

extension FieldProperty: Resolvable where Value: Resolvable { }

extension FieldProperty: OutputResolvable where Value: OutputResolvable { }

extension FieldProperty: DelegatedOutputResolvable where Value: OutputResolvable {

    public func resolve(source: Any, arguments: [String : Map], context: MutableContext, eventLoop: EventLoopGroup) throws -> some OutputResolvable {
        return wrappedValue
    }

}
