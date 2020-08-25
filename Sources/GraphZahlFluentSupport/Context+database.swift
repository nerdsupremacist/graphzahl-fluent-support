
import Foundation
import GraphZahl
import Fluent
import Vapor
import ContextKit

extension MutableContext {

    func database() throws -> Database {
        if let database = self[.database] {
            print("Found DB")
            fflush(stdout)
            return database
        }
        let anyViewerContext = self.anyViewerContext

        guard let database = findDatabase(in: anyViewerContext, typesSeen: []) else {
            print("Failed to find DB")
            fflush(stdout)
            throw GraphZahlFluentError.couldNotResolveDatabase(viewerContext: anyViewerContext, context: self)
        }

        print("Found DB")
        fflush(stdout)

        push {
            .database ~> database
        }

        return database
    }

}

private func findDatabase(in object: Any, typesSeen: Set<Int>) -> Database? {
    print("Looking for db in \(object)")
    fflush(stdout)

    if let object = object as? Database {
        return object
    }

    if let object = object as? Application {
        return object.db
    }

    if let object = object as? Request {
        return object.db
    }

    print("Looking for db via mirror")
    fflush(stdout)

    let mirror = Mirror(reflecting: object)
    print("Received mirror!")
    fflush(stdout)

    let castedType = unsafeBitCast(mirror.subjectType, to: Int.self)

    guard !typesSeen.contains(castedType) else { return nil }

    for child in mirror.children {
        guard let database = findDatabase(in: child.value, typesSeen: typesSeen.union([castedType])) else { continue }
        return database
    }

    return nil
}
