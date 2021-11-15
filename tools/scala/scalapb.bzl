"""ScalaPB Compilation Rule

The ScalaPB runtime pulled in from rules_proto_grpc is tied to Scala 2.12
We want to use Scala 2.13 so we make our own rule to compile the proto files
that reference a plugin we configured to use ScalaPB with Scala 2.13
"""

load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoPluginInfo",
    "proto_compile_attrs",
    "proto_compile_impl",
)

scala_proto_compile = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("//tools:scalapb_plugin"),
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = [str(Label("@rules_proto_grpc//protobuf:toolchain_type"))],
)
