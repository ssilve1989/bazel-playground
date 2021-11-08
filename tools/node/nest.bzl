"""Help Macro to facilitate creating Nest application targets"""
load("//tools:node/ts_project.bzl", "ts_project")
load("@build_bazel_rules_nodejs//:index.bzl", "nodejs_binary")
load("@io_bazel_rules_docker//nodejs:image.bzl", "nodejs_image")

NEST_DATA = [
    "@npm//@nestjs/core",
    "@npm//@nestjs/common",
]

def nest_app(name, srcs, entry_point, **kwargs):
    deps = kwargs.pop("deps", [])

    ts_project(
        name = "source",
        srcs = srcs,
        deps = deps + NEST_DATA,
        **kwargs
    )

    nodejs_binary(
        name = name,
        data = [
            ":source",
        ],
        # link_workspace_root is broken as of rule_nodejs v4
        args = [
            "--bazel_patch_module_resolver",
        ],
        entry_point = entry_point,
        **kwargs
    )

    nodejs_image(
      name = "image",
      binary = name,
      args = ["--bazel_patch_module_resolver"]
    )
