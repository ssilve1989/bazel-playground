# Bazel workspace created by @bazel/create 4.4.2

# Declares that this directory is the root of a Bazel workspace.
# See https://docs.bazel.build/versions/main/build-ref.html#workspace
workspace(
    # How this workspace would be referenced with absolute labels from another workspace
    name = "playground",
    # Map the @npm bazel workspace to the node_modules directory.
    # This lets Bazel use the same node_modules as other local tooling.
    managed_directories = {"@npm": ["node_modules"]},
)

load("//tools:bazel_deps.bzl", "fetch_dependencies")

fetch_dependencies()

# Docker Setup
load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

# NodeJS Setup
load("@build_bazel_rules_nodejs//:index.bzl", "node_repositories", "yarn_install")
load("@io_bazel_rules_docker//nodejs:image.bzl", _nodejs_image_repos = "repositories")

node_repositories(
    use_nvmrc = "//:.nvmrc",
)

yarn_install(
    name = "npm",
    frozen_lockfile = True,
    package_json = "//:package.json",
    yarn_lock = "//:yarn.lock",
)

_nodejs_image_repos()

# Scala Setup
# Stores Scala version and other configuration
# 2.12 is a default version, other versions can be use by passing them explicitly:
# scala_config(scala_version = "2.11.12")
load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")

scala_config(scala_version = "2.13.6")

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()

load("@rules_proto_grpc//:repositories.bzl", "rules_proto_grpc_repos", "rules_proto_grpc_toolchains")

rules_proto_grpc_toolchains()

rules_proto_grpc_repos()

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")

rules_proto_dependencies()

rules_proto_toolchains()

# Scala Proto setup
load("@rules_proto_grpc//scala:repositories.bzl", RULES_PROTO_GRPC_SCALA_MAVEN_ARTIFACTS = "MAVEN_ARTIFACTS", rules_proto_grpc_scala_repos = "scala_repos")

rules_proto_grpc_scala_repos()

load("@io_grpc_grpc_java//:repositories.bzl", "grpc_java_repositories")

grpc_java_repositories()

load("@rules_jvm_external//:defs.bzl", "maven_install")
load("//tools:scala/dependencies.bzl", "MAVEN_ARTIFACTS")

maven_install(
    name = "rules_proto_grpc_scala_maven",
    artifacts = RULES_PROTO_GRPC_SCALA_MAVEN_ARTIFACTS,
    repositories = [
        "https://repo1.maven.org/maven2",
    ],
)

maven_install(
    name = "maven",
    artifacts = MAVEN_ARTIFACTS,
    repositories = [
        "https://repo1.maven.org/maven2",
    ],
)
