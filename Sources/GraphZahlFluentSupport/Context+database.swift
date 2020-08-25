
import Foundation
import GraphZahl
import Fluent
import Vapor
import ContextKit

extension MutableContext {

    func database() throws -> Database {
        if let database = self[.database] { return database }
        let anyViewerContext = self.anyViewerContext

        guard let database = findDatabase(in: anyViewerContext, typesSeen: []) else {
            throw GraphZahlFluentError.couldNotResolveDatabase(viewerContext: anyViewerContext, context: self)
        }

        push {
            .database ~> database
        }

        return database
    }

}

private func findDatabase(in object: Any, typesSeen: Set<Int>) -> Database? {
    if let object = object as? Database {
        return object
    }

    if let object = object as? Application {
        return object.db
    }

    if let object = object as? Request {
        return object.db
    }

    let mirror = Mirror(reflecting: object)
    let castedType = unsafeBitCast(mirror.subjectType, to: Int.self)

    guard !typesSeen.contains(castedType) else { return nil }

    for child in mirror.children {
        guard let database = findDatabase(in: child.value, typesSeen: typesSeen.union([castedType])) else { continue }
        return database
    }

    return nil
}
