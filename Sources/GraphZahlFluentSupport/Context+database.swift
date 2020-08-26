
import Foundation
import GraphZahl
import Fluent
import Vapor
import ContextKit

extension MutableContext {

    func database() throws -> Database {
        if let database = self[.database] { return database }
        let anyViewerContext = self.anyViewerContext

        guard let database = findDatabase(in: anyViewerContext) else {
            throw GraphZahlFluentError.couldNotResolveDatabase(viewerContext: anyViewerContext, context: self)
        }

        push {
            .database ~> database
        }

        return database
    }

}

private func findDatabase(in object: Any) -> Database? {
    var queue = [object]
    while let next = queue.popLast() {
        if let database = database(in: next, queue: &queue) {
            return database
        }
    }
    return nil
}

private func database(in object: Any, queue: inout [Any]) -> Database? {
    if let object = object as? Database {
        return object
    }

    if let object = object as? Application {
        return object.db
    }

    if let object = object as? Request {
        return object.db
    }

    if object is EventLoopGroup {
        return nil
    }

    let mirror = Mirror(reflecting: object)
    queue = mirror.children.map { $0.value } + queue
    return nil
}
