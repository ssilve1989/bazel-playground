"""scala dependencies """

AKKA_GRPC_VERSION = "2.1.1"
AKKA_HTTP_VERSION = "10.2.7"
AKKA_VERSION = "2.6.17"
GRPC_VERSION = "1.41.0"
SCALA_VERSION = "2.13"
SCALAPB_VERSION = "0.11.6"

MAVEN_ARTIFACTS = [
    "com.typesafe.akka:akka-http_%s:%s" % (SCALA_VERSION, AKKA_HTTP_VERSION),
    "com.typesafe.akka:akka-actor-testkit-typed_%s:%s" % (SCALA_VERSION, AKKA_VERSION),
    "com.typesafe.akka:akka-actor-typed_%s:%s" % (SCALA_VERSION, AKKA_VERSION),
    "com.typesafe.akka:akka-actor_%s:%s" % (SCALA_VERSION, AKKA_VERSION),
    "com.typesafe.akka:akka-discovery_%s:%s" % (SCALA_VERSION, AKKA_VERSION),
    "com.typesafe.akka:akka-http-caching_%s:%s" % (SCALA_VERSION, AKKA_HTTP_VERSION),
    "com.typesafe.akka:akka-http-core_%s:%s" % (SCALA_VERSION, AKKA_HTTP_VERSION),
    "com.typesafe.akka:akka-http-spray-json_%s:%s" % (SCALA_VERSION, AKKA_HTTP_VERSION),
    "com.typesafe.akka:akka-http_%s:%s" % (SCALA_VERSION, AKKA_HTTP_VERSION),
    "com.typesafe.akka:akka-slf4j_%s:%s" % (SCALA_VERSION, AKKA_VERSION),
    "com.typesafe.akka:akka-stream-testkit_%s:%s" % (SCALA_VERSION, AKKA_VERSION),
    "com.typesafe.akka:akka-stream-typed_%s:%s" % (SCALA_VERSION, AKKA_VERSION),
    "com.typesafe.akka:akka-stream_%s:%s" % (SCALA_VERSION, AKKA_VERSION),
    "com.typesafe.akka:akka-testkit_%s:%s" % (SCALA_VERSION, AKKA_VERSION),
    "com.typesafe.akka:akka-http-testkit_%s:%s" % (SCALA_VERSION, AKKA_HTTP_VERSION),
    "com.lightbend.akka.grpc:akka-grpc-runtime_%s:%s" % (SCALA_VERSION, AKKA_GRPC_VERSION),
    "com.lightbend.akka.grpc:akka-grpc-codegen_%s:%s" % (SCALA_VERSION, "1.1.1"),  # akka-grpc-codegen for scala 2.13 is only supported at version 1.1.1, not the version 2.x line
    "io.grpc:grpc-api:%s" % GRPC_VERSION,
    "io.grpc:grpc-context:%s" % GRPC_VERSION,
    "io.grpc:grpc-core:%s" % GRPC_VERSION,
    "io.grpc:grpc-netty:%s" % GRPC_VERSION,
    "io.grpc:grpc-protobuf:%s" % GRPC_VERSION,
    "io.grpc:grpc-stub:%s" % GRPC_VERSION,
    "com.thesamet.scalapb:scalapb-runtime-grpc_%s:%s" % (SCALA_VERSION, SCALAPB_VERSION),
    "com.thesamet.scalapb:scalapb-runtime_%s:%s" % (SCALA_VERSION, SCALAPB_VERSION),
]

def scala_dep(dep):
    return dep + "_2_13"
