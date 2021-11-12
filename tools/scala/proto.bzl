"""Scala build rules"""

load("//tools:scala/dependencies.bzl", "scala_dep")
load("@rules_proto_grpc//scala:defs.bzl", "scala_proto_compile")
load("@rules_proto_grpc//scala:scala_proto_library.bzl", "PROTO_DEPS")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")
load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoPluginInfo",
    "proto_compile_attrs",
    "proto_compile_impl",
)

GRPC_ARTIFACTS = [
    scala_dep("@maven//:com_typesafe_akka_akka_http"),
    scala_dep("@maven//:com_typesafe_akka_akka_http_core"),
    scala_dep("@maven//:com_typesafe_akka_akka_actor"),
    scala_dep("@maven//:com_typesafe_akka_akka_stream"),
    scala_dep("@maven//:com_lightbend_akka_grpc_akka_grpc_runtime"),
    "@maven//:io_grpc_grpc_api",
    "@maven//:io_grpc_grpc_core",
    "@maven//:io_grpc_grpc_stub",
    "@maven//:io_grpc_grpc_protobuf",
    "@maven//:io_grpc_grpc_netty",
    "@maven//:io_grpc_grpc_context",
    scala_dep("@maven//:com_thesamet_scalapb_scalapb_runtime"),
    scala_dep("@maven//:com_thesamet_scalapb_scalapb_runtime_grpc"),
]

def scala_grpc_library(name, protos, **kwargs):
    """Generates an Akka gRPC Power Api Library
    Args:
      name: the name of the final scala_library target
      protos: a List of labels that provide ProtoInfo like a proto_library target
      **kwargs: additional args
    """
    akka_grpc_target = name + "_akka_grpc"
    scalapb_proto_target = name + "_scalapb"

    akka_proto_compile(
        name = akka_grpc_target,
        protos = protos,
    )

    scala_proto_compile(
        name = scalapb_proto_target,
        options = {
            "*": [
                "grpc",
                "flat_package",
            ],
        },
        protos = protos,
    )

    scala_library(
        name = name,
        srcs = [
            ":" + scalapb_proto_target,
            ":" + akka_grpc_target,
        ],
        deps = PROTO_DEPS + GRPC_ARTIFACTS,
        **kwargs
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
