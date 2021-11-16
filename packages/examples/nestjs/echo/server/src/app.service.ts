import { Injectable } from "@nestjs/common";
import { Subject, filter, map } from "rxjs";

@Injectable()
class AppService {
  private readonly stream$ = new Subject<string>();

  public handleRequest(message: string) {
    setImmediate(() => this.stream$.next(message));
    return { message, timestamp: Date.now() };
  }

  public handleStreamRequest(pattern?: string) {
    return this.stream$.pipe(
      filter((message: string) => {
        return pattern ? new RegExp(pattern).test(message) : true;
      }),
      map((message) => ({ message, timestamp: Date.now() }))
    );
  }
}

export { AppService };
