// swift-tools-version:5.2
import PackageDescription


let package = Package(
    name: "S3",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "S3", targets: ["S3"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/apple/swift-nio.git", .upToNextMajor(from: "2.13.1")),
        .package(url: "https://github.com/apple/swift-crypto.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/swift-server/async-http-client.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/Einstore/HTTPMediaTypes.git", from: "0.0.1"),
        .package(name: "WebError", url: "https://github.com/Einstore/WebErrorKit.git", from: "0.0.1"),
        .package(url: "https://github.com/LiveUI/XMLCoding.git", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "S3Signer",
            dependencies: [
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "HTTPMediaTypes", package: "HTTPMediaTypes"),
                .product(name: "WebErrorKit", package: "WebError"),
                .product(name: "NIOHTTP1", package: "swift-nio"),
            ]
        ),
        .target(
            name: "S3Kit",
            dependencies: [
                .target(name: "S3Signer"),
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "XMLCoding", package: "XMLCoding"),
                .product(name: "HTTPMediaTypes", package: "HTTPMediaTypes")
            ]
        ),
        .target(
            name: "S3",
            dependencies: [
                .target(name: "S3Kit"),
                .product(name: "Vapor", package: "vapor")
            ]
        ),

        .testTarget(name: "S3Tests", dependencies: [
            .target(name: "S3Kit")
            ]
        )
    ]
)
