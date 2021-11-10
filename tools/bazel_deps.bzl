# Third-party dependencies fetched by Bazel
# Unlike WORKSPACE, the content of this file is unordered.
# We keep them separate to make the WORKSPACE file more maintainable.

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# buildifier: disable=function-docstring
def fetch_dependencies():
    http_archive(
        name = "build_bazel_rules_nodejs",
        sha256 = "3aa6296f453ddc784e1377e0811a59e1e6807da364f44b27856e34f5042043fe",
        urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/4.4.2/rules_nodejs-4.4.2.tar.gz"],
    )

    http_archive(
        name = "io_bazel_rules_docker",
        sha256 = "92779d3445e7bdc79b961030b996cb0c91820ade7ffa7edca69273f404b085d5",
        strip_prefix = "rules_docker-0.20.0",
        urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.20.0/rules_docker-v0.20.0.tar.gz"],
    )

    http_archive(
        name = "rules_proto",
        sha256 = "66bfdf8782796239d3875d37e7de19b1d94301e8972b3cbd2446b332429b4df1",
        strip_prefix = "rules_proto-4.0.0",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_proto/archive/refs/tags/4.0.0.tar.gz",
            "https://github.com/bazelbuild/rules_proto/archive/refs/tags/4.0.0.tar.gz",
        ],
    )

    # Commit: df8f82e4fb806e07362aa37f7eb23b2e18cca5ae
    # Date: 2021-10-29 16:18:29 +0000 UTC
    # URL: https://github.com/stackb/rules_proto/commit/df8f82e4fb806e07362aa37f7eb23b2e18cca5ae
    #
    # Update README; use canonical labels
    # Size: 877766 (878 kB)
    http_archive(
        name = "build_stack_rules_proto",
        sha256 = "e707173400a15982ccc1147ea58ef81f65d414e5c33b45b505110b53d4d23a76",
        strip_prefix = "rules_proto-df8f82e4fb806e07362aa37f7eb23b2e18cca5ae",
        urls = ["https://github.com/stackb/rules_proto/archive/df8f82e4fb806e07362aa37f7eb23b2e18cca5ae.tar.gz"],
    )

    skylib_version = "1.0.3"
    http_archive(
        name = "bazel_skylib",
        sha256 = "1c531376ac7e5a180e0237938a2536de0c54d93f5c278634818e0efc952dd56c",
        type = "tar.gz",
        url = "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/{}/bazel-skylib-{}.tar.gz".format(skylib_version, skylib_version),
    )

    rules_scala_version = "e7a948ad1948058a7a5ddfbd9d1629d6db839933"
    http_archive(
        name = "io_bazel_rules_scala",
        sha256 = "76e1abb8a54f61ada974e6e9af689c59fd9f0518b49be6be7a631ce9fa45f236",
        strip_prefix = "rules_scala-%s" % rules_scala_version,
        type = "zip",
        url = "https://github.com/bazelbuild/rules_scala/archive/%s.zip" % rules_scala_version,
    )
