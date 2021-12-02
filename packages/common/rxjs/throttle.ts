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

/**
 * Provides a way to throttle emissions by only allowing a single emission through in the given window. A pseudo-buffer is maintained that schedules subsequent emissions within the window
 * up to the bufferSize. If `errorOnOverflow` is set, reaching the bufferSize within the window will throw an error, otherwise it behaves like a standard throttle and will drop the emissions
 *
 *
 * ```typescript
 * const onePerSecond$ = range(0, 10).pipe(throttle({ windowSize: 1000 })) // yields one emission every second
 *
 * const overflow$ = range(0, 10).pipe(throttle({ windowSize: 1000, bufferSize: 5, errorOnOverflow: true }))
 * ```
 *
 * @param config.windowSize The window in which to allow a single emission to pass through
 * @param config.bufferSize The amount of emissions allowed to be scheduled within the window time set
 * @param config.errorOnOverflow will raise an error if more emissions than the allowed bufferSize are received within the windowSize
 * @param scheduler
 * @returns
 */
export function throttle<T>(
  { windowSize, bufferSize, errorOnOverflow }: ThrottleConfig,
  scheduler: SchedulerLike = asyncScheduler
) {
  return (source$: Observable<T>) => {
    return new Observable((observer) => {
      let done = false;
      let buffered = 0;
      let lastEmissionTime: number | undefined;
      const group = new Subscription();

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
        const scheduled = scheduler.schedule(() => {
          buffered -= 1;
          emit(value);
        }, lastEmissionTime + windowSize * buffered - scheduler.now());

        group.add(scheduled);
      };

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
