import { Controller } from "@nestjs/common";
import { GrpcMethod } from "@nestjs/microservices";
import echo from "@examples/echo/js_pb";
import { AppService } from "./app.service";
import { map } from "rxjs";

@Controller()
class AppController {
  constructor(private readonly service: AppService) {}

  @GrpcMethod("EchoService")
  echo(request: echo.packages.examples.echo.EchoRequest) {
    return echo.packages.examples.echo.EchoResponse.fromObject(
      this.service.handleRequest(request.message)
    );
  }

  @GrpcMethod("EchoService")
  streamEcho(request: echo.packages.examples.echo.StreamEchoRequest) {
    return this.service
      .handleStreamRequest(request.pattern)
      .pipe(
        map((message) =>
          echo.packages.examples.echo.StreamEchoResponse.fromObject(message)
        )
      );
  }
}

export { AppController };
