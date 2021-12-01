import { Metadata, status } from '@grpc/grpc-js';
import { marbles } from 'rxjs-marbles';
import { callErrorFromStatus } from '@grpc/grpc-js/build/src/call';
import { withRetryable } from './with-retryable';

const createError = (code: status) =>
  callErrorFromStatus({
    code,
    details: status[code] || 'unknown',
    metadata: new Metadata(),
  });

describe('withRetryable', () => {
  test(
    `retries when ${status[status.UNAVAILABLE]!} is thrown`,
    marbles((m) => {
      const source$ = m.cold('ab#', undefined, createError(status.UNAVAILABLE));
      const expected =       'ababab#' // prettier-ignore

      const destination = withRetryable(() => source$, undefined, {
        maxRetries: 2,
      });

      m.expect(destination).toBeObservable(expected);
    })
  );
});
