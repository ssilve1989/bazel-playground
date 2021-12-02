/**
 * based on https://github.com/bkon/rx-op-lossless-throttle
 */
import { asyncScheduler, Observable, SchedulerLike, Subscription } from 'rxjs';
import { BufferOverflowException } from './exceptions/buffer-overflow';

export interface ThrottleConfig {
  bufferSize?: number;
  errorOnOverflow?: boolean;
  windowSize: number;
}

export function throttle<T>(
  { windowSize, bufferSize, errorOnOverflow }: ThrottleConfig,
  scheduler: SchedulerLike = asyncScheduler
) {
  return (source$: Observable<T>) => {
    return new Observable((observer) => {
      let done = false;
      let buffered = 0;
      let lastEmissionTime: number | undefined;

      const emit = (value: T) => {
        observer.next(value);
        lastEmissionTime = scheduler.now();

        if (done && buffered === 0) {
          observer.complete();
        }
      };

      const handleNext = (value: T) => {
        // If there has been no emission yet, just emit
        if (lastEmissionTime == null) {
          return emit(value);
        }

        // If we are within the emission window also emit
        const delta = scheduler.now() - lastEmissionTime;
        if (delta > windowSize) {
          return emit(value);
        }

        // If we are not in the emission window and we have exceeded the buffer size
        // exit or throw error
        if (bufferSize != null && buffered >= bufferSize) {
          if (errorOnOverflow)
            return observer.error(new BufferOverflowException());
          return;
        }

        // accumulate the buffer
        buffered += 1;
        scheduler.schedule(() => {
          buffered -= 1;
          emit(value);
        }, lastEmissionTime + windowSize * buffered - scheduler.now());
      };

      const group = new Subscription();

      group.add(
        source$.subscribe({
          next: handleNext,
          error: (e) => observer.error(e),
          complete: () => {
            done = true;
            if (buffered === 0) {
              observer.complete();
            }
          },
        })
      );

      return () => group.unsubscribe();
    });
  };
}
