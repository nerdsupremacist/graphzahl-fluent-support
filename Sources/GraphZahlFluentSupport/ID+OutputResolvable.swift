
import Foundation
import Fluent
import GraphZahl
import GraphQL
import ContextKit

extension IDProperty: Resolvable where Value: Resolvable { }

extension IDProperty: OutputResolvable where Value: OutputResolvable { }

extension IDProperty: DelegatedOutputResolvable where Value: OutputResolvable {

    public func resolve(source: Any, arguments: [String : Map], context: MutableContext, eventLoop: EventLoopGroup) throws -> some OutputResolvable {
        return wrappedValue
    }

}
