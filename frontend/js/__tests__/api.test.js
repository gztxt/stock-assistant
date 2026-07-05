import { health } from '../api.js';

test('health is exported as a function', () => {
  expect(typeof health).toBe('function');
});
