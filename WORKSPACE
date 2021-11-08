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
