import Big from 'big.js';

export default function operate(numberOne, numberTwo, operation) {
  const one = Big(numberOne);
  const two = Big(numberTwo);
  if (operation === '+') {
    //call adder
    return one.plus(two).toString();
  }
  if (operation === '-') {
    //call adder
    return one.minus(two).toString();
  }
  if (operation === 'x') {
    //call multiplier
    return one.times(two).toString();
  }
  if (operation === '÷') {
    try {
      //call multiplier
      return one.div(two).toString();
    } catch (err) {
      return "Can't divide by 0.";
    }
  }
  throw Error(`Unknown operation '${operation}'`);
}
