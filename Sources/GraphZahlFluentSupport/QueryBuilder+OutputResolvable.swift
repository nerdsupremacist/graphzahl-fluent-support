
import Foundation
import GraphQL
import GraphZahl
import Fluent
import Runtime
import ContextKit

extension QueryBuilder: Resolvable where Model: Resolvable { }

extension QueryBuilder: OutputResolvable where Model: OutputResolvable & ConcreteResolvable { }

extension QueryBuilder: DelegatedOutputResolvable where Model: OutputResolvable & ConcreteResolvable {

    // Indirection added to include the database in the context, just in case it's not part of the viewer context
    public func resolve(source: Any, arguments: [String : Map], context: MutableContext, eventLoop: EventLoopGroup) throws -> some OutputResolvable {
        print("Instantiating connection")
        fflush(stdout)

        context.push {
            .database ~> database
        }

        return QueryConnection(query: self)
    }

}
