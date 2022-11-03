import Big from 'big.js';
import axios from 'axios';

export default function operate(numberOne, numberTwo, operation) {
  const one = Big(numberOne);
  const two = Big(numberTwo);
  let result = ''
  if (operation === '+') {
    axios.get('http://ip:port/sum?a='+one+"&b="+two)
        .then(response => result = response.data);
    return result.toString();
  }
  if (operation === '-') {
    axios.get('http://ip:port/subtraction?a='+one+"&b="+two)
        .then(response => result = response.data);
    return result.toString();
  }
  if (operation === 'x') {
    axios.get('http://ip:port/multiplier?num1='+one+"&num2="+two)
        .then(response => result = response.data);
    return result.toString();
  }
  if (operation === '÷') {
    try {
      axios.get('http://ip:port/divisor?num1='+one+"&num2="+two)
        .then(response => result = response.data);
      return result.toString();
    } catch (err) {
      return "Error";
    }
  }
  throw Error(`Unknown operation '${operation}'`);
}
