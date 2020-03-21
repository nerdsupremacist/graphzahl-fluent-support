
import Foundation
import Fluent
import ContextKit

extension Context.Key where T == Database {
    static let database = Context.Key<Database>()
}
