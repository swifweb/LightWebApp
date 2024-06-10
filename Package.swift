// swift-tools-version: 5.10

import PackageDescription
import CompilerPluginSupport

let embeddedSwiftSettings: [SwiftSetting] = [
    .enableExperimentalFeature("Embedded"),
    .interoperabilityMode(.Cxx),
    .unsafeFlags([
        "-wmo", "-disable-cmo",
        "-Xfrontend", "-gnone",
        "-Xfrontend", "-disable-stack-protector"
    ])
]

let embeddedCSettings: [CSetting] = [
    .unsafeFlags(["-fdeclspec"])
]

let linkerSettings: [LinkerSetting] = [
    .unsafeFlags([
        "-Xclang-linker", "-nostdlib",
        "-Xlinker", "--no-entry"
    ])
]

let libcSettings: [CSetting] = [
    .define("LACKS_TIME_H"),
    .define("LACKS_SYS_TYPES_H"),
    .define("LACKS_STDLIB_H"),
    .define("LACKS_STRING_H"),
    .define("LACKS_SYS_MMAN_H"),
    .define("LACKS_FCNTL_H"),
    .define("NO_MALLOC_STATS", to: "1"),
    .define("__wasilibc_unmodified_upstream"),
]

let package = Package(
    name: "LightWebApp",
    dependencies: [
        .package(url: "https://github.com/swifweb/String16", branch: "0.1.0"),
        .package(url: "https://github.com/swifweb/JavaScriptKit", branch: "embedded")
    ],
    targets: [
        .executableTarget(
            name: "LightWebApp",
            dependencies: [
                .product(name: "String16", package: "String16"),
                .product(name: "JavaScriptKitEmbedded", package: "JavaScriptKit")
            ],
            cSettings: embeddedCSettings,
            swiftSettings: embeddedSwiftSettings,
            linkerSettings: linkerSettings
        )
    ]
)
