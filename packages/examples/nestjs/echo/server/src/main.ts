import { NestFactory } from "@nestjs/core";
import path from "path";
import { GrpcOptions, Transport } from "@nestjs/microservices";
import { AppModule } from "./app.module";
import { Logger } from "@nestjs/common";

async function bootstrap() {
  const logger = new Logger("Nest");
  const { HOSTNAME = "localhost", PORT = 8080 } = process.env;
  const url = `${HOSTNAME}:${PORT}`;
  const app = await NestFactory.createMicroservice<GrpcOptions>(AppModule, {
    options: {
      loader: {
        includeDirs: ["."],
      },
      package: "packages.examples.echo",
      protoPath: path.resolve(
        "packages",
        "examples",
        "echo",
        "echo_service.proto"
      ),
      url,
    },
    transport: Transport.GRPC,
  });
  await app.listen();

  logger.log(`gRPC server listenting at: ${url}`);
}

void bootstrap();
