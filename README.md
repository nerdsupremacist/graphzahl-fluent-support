![](logo.png)


# GraphZahl Fluent Support
A set of extensions that allow to use [Fluent](https://github.com/vapor/fluent) APIs and Types with [GraphZahl](https://github.com/nerdsupremacist/GraphZahl)

## About GraphZahl

GraphZahl is a Framework to implement Declarative, Type-Safe GraphQL Server APIs with Magic 🎩.

Learn more about GraphZahl: [here](https://github.com/nerdsupremacist/GraphZahl)

## Installation
### Swift Package Manager

You can install graphzahl-fluent-support via [Swift Package Manager](https://swift.org/package-manager/) by adding the following line to your `Package.swift`:

```swift
import PackageDescription

let package = Package(
    [...]
    dependencies: [
        .package(url: "https://github.com/nerdsupremacist/graphzahl-fluent-support.git", majorVersion: XYZ)
    ]
)
```

## Usage


To use Fluent Types and Models in your API, you can use [graphzahl-fluent-support](https://github.com/nerdsupremacist/graphzahl-fluent-support):

```swift
enum API: GraphQLSchema {
    typealias ViewerContext = Database

    class Query: QueryType {
        let database: Database

        // QueryBuilders are supported with additional paging API
        func todos() -> QueryBuilder<Todo> {
            return Todo.query(on: database)
        }

        required init(viewerContext database: Database) {
            self.database = database
        }
    }
    
    ...
}
```

It adds support for:

- QueryBuilder<T>
- @Parent
- @Children
- @Siblings
- @Field
- @ID
  
  ## Known Issues

- Relation Fields depend on some query builder having run before, or they will crash otherwise. This is not ideal and should be solved
- Paging for queries is not implemented yet

## Contributions
Contributions are welcome and encouraged!

## License
graphzahl-fluent-support is available under the MIT license. See the LICENSE file for more info.

This project is being done under the supervision of the Chair for Applied Software Enginnering at the Technical University of Munich. The chair has everlasting rights to use and maintain this tool.
