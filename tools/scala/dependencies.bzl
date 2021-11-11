"""scala dependencies """

SCALA_VERSION = "2.13"
AKKA_HTTP_VERSION = "10.1.12"
AKKA_VERSION = "2.6.10"
GRPC_VERSION = "1.30.2"

SCALA_DEPS = [
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
    "com.lightbend.akka.grpc:akka-grpc-runtime_%s:1.0.1" % SCALA_VERSION,
    "com.lightbend.akka.grpc:akka-grpc-codegen_%s:1.0.0" % SCALA_VERSION,
    "io.grpc:grpc-api:%s" % GRPC_VERSION,
    "io.grpc:grpc-context:%s" % GRPC_VERSION,
    "io.grpc:grpc-core:%s" % GRPC_VERSION,
    "io.grpc:grpc-netty:%s" % GRPC_VERSION,
    "io.grpc:grpc-protobuf:%s" % GRPC_VERSION,
    "io.grpc:grpc-stub:%s" % GRPC_VERSION,
]

def scala_dep(dep):
    return dep + "_2_13"
