"""Akka protobuf compilation rule to generate the Akka Power Apis"""

load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoPluginInfo",
    "proto_compile_attrs",
    "proto_compile_impl",
)

akka_proto_compile = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("//tools:akka_plugin"),
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = [str(Label("@rules_proto_grpc//protobuf:toolchain_type"))],
)
