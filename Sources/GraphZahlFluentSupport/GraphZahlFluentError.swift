
import Foundation
import ContextKit

public enum GraphZahlFluentError: Error {
    case couldNotResolveDatabase(viewerContext: Any, context: MutableContext)
}
