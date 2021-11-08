import { Injectable, Logger, OnApplicationBootstrap } from "@nestjs/common";

@Injectable()
class AppService implements OnApplicationBootstrap {
  private readonly logger = new Logger(AppService.name);

  onApplicationBootstrap() {
    this.logger.log("hello world");
  }
}

export { AppService };
