import { configure } from 'rxjs-marbles';
import { BufferOverflowException } from './exceptions/buffer-overflow';
import { throttle } from './throttle';

const reframeable = configure({ run: false });

describe('throttle emissions at one per second', () => {
  test(
    'with unbounded buffer',
    reframeable.marbles((m) => {
      // set each frame size to 1000ms with maximum 10000ms runtime
      m.reframe(1000, 10000);

      const source$ = m.cold('(abcdefg|)');
      const expected =       'abcdef(g|)'; // prettier-ignore
      const destination$ = source$.pipe(
        throttle({ windowSize: 1000 }, m.scheduler)
      );

      m.expect(destination$).toBeObservable(expected);
    })
  );

  test(
    'with a maximum buffer size of 5 losing all other emissions',
    reframeable.marbles((m) => {
      m.reframe(1000, 10000);
      const source$ = m.cold('(abcdefghijklmnopqrstuvwxyz|)');
      const expected =       'abcde(f                    |)' // prettier-ignore

      const destination$ = source$.pipe(
        throttle({ windowSize: 1000, bufferSize: 5 }, m.scheduler)
      );

      m.expect(destination$).toBeObservable(expected);
    })
  );

  test(
    'throws an error when bounded buffer is reached',
    reframeable.marbles((m) => {
      m.reframe(1000, 10000);
      const source$ =  m.cold('(abcdefghi|)'); // prettier-ignore
      const expected = m.cold('(a#)        ', undefined, new BufferOverflowException()); // prettier-ignore
      // With all emissions provided synchronously, the buffer immediately fills up after the first emission and throws an error
      // within the first buffer window

      const destination$ = source$.pipe(
        throttle(
          { windowSize: 1000, bufferSize: 5, errorOnOverflow: true },
          m.scheduler
        )
      );

      m.expect(destination$).toBeObservable(expected);
    })
  );
});
