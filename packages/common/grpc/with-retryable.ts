import { status, ServiceError } from '@grpc/grpc-js';
import {
  delayWhen,
  defer,
  Observable,
  of,
  retryWhen,
  throwError,
  timer,
  concatMap,
} from 'rxjs';

const DEFAULT_RETRY_CODES: Set<status> = new Set([
  status.ABORTED,
  status.CANCELLED,
  status.RESOURCE_EXHAUSTED,
  status.UNAVAILABLE,
]);

export interface RetryableConfig {
  minBackoff?: number;
  maxRetries?: number;
}

export function withRetryable<T>(
  call: (...args: any[]) => Observable<T>,
  retryCodes: Set<status> = DEFAULT_RETRY_CODES,
  config?: RetryableConfig
): Observable<T> {
  const minBackoff = config?.minBackoff || 1000;
  const maxRetries = config?.maxRetries || Infinity;

  let attempts = 0;

  return defer(call).pipe(
    retryWhen((error$) =>
      error$.pipe(
        concatMap((err: unknown) => {
          if (Object.prototype.hasOwnProperty.call(err, 'code')) {
            const serviceError = err as ServiceError;
            attempts += 1;

            if (retryCodes.has(serviceError.code) && attempts <= maxRetries) {
              return of(serviceError).pipe(delayWhen(() => timer(minBackoff)));
            }

            return throwError(() => err);
          }
          return throwError(() => err);
        })
      )
    )
  );
}
