import { main } from './main';

describe('helloworld', () => {
  it('invokes the function', () => {
    const fn = jest.fn(main).mockImplementation(() => 'hello world');
    const result = fn();
    expect(result).toEqual('hello world');
  });
});
