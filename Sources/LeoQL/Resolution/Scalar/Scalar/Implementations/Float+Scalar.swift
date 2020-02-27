
import Foundation
import GraphQL

extension Float: Scalar {

    public init(scalar: ScalarValue) throws {
        self = Float(try scalar.float())
    }

    public func encodeScalar() throws -> ScalarValue {
        return .number(Number(self))
    }

    public static func resolve(using context: inout Resolution.Context) throws -> GraphQLOutputType {
        context.append(output: GraphQLFloat)
        return GraphQLNonNull(GraphQLFloat)
    }

    public static func resolve(using context: inout Resolution.Context) throws -> GraphQLInputType {
        context.append(input: GraphQLFloat)
        return GraphQLNonNull(GraphQLFloat)
    }

}