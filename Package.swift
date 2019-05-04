// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "NoteAPI",
    products: [
        .library(name: "NoteAPI", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0"),
        .package(url: "https://github.com/OpenKitten/MeowVapor.git", from: "2.0.1"),
        .package(url: "https://github.com/skelpo/APIErrorMiddleware.git", from: "0.3.5")
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentSQLite", "Vapor", "Leaf","MeowVapor","APIErrorMiddleware"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

