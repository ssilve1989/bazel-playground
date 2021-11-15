"""Scala build rules"""

load("//tools:scala/dependencies.bzl", "scala_dep")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")
load("//tools:scala/akka.bzl", "akka_proto_compile")
load("//tools:scala/scalapb.bzl", "scala_proto_compile")

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
    scala_dep("@maven//:com_thesamet_scalapb_lenses"),
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

    # Generates the PowerAPIs
    akka_proto_compile(
        name = akka_grpc_target,
        protos = protos,
    )

    # Generates the scalapb protos (message protos, etc)
    scala_proto_compile(
        name = scalapb_proto_target,
        options = {
            "*": [
                "grpc",
                "flat_package",
                "no_lenses",
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
        deps = GRPC_ARTIFACTS + ["@rules_proto_grpc_scala_maven//:com_google_protobuf_protobuf_java"],
        **kwargs
    )
