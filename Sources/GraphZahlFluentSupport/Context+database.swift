
import Foundation
import GraphZahl
import Fluent
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
    if let object = object as? Database {
        return object
    }

    let mirror = Mirror(reflecting: object)

    for child in mirror.children {
        guard let database = findDatabase(in: child.value) else { continue }
        return database
    }

    return nil
}
