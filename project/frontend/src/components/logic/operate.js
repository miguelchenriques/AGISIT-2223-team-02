import Big from 'big.js';
import axios from 'axios';
import balancers from '../../microservices_balancers.json'

export default function operate(numberOne, numberTwo, operation) {
  const multiplier_url = `http://${balancers.multiplier}:80/`
  const adder_url = `http://${balancers.adder}:80/`
  const one = Big(numberOne);
  const two = Big(numberTwo);
  let result = ''
  if (operation === '+') {
    axios.get(adder_url +'sum?a='+one+"&b="+two)
        .then(response => result = response.data);
    return result.toString();
  }
  if (operation === '-') {
    axios.get(adder_url +'sub?a='+one+"&b="+two)
        .then(response => result = response.data);
    return result.toString();
  }
  if (operation === 'x') {
    axios.get(multiplier_url + 'multiplier?num1='+one+"&num2="+two)
        .then(response => result = response.data);
    return result.toString();
  }
  if (operation === '÷') {
    try {
      axios.get(multiplier_url + 'divisor?num1='+one+"&num2="+two)
        .then(response => result = response.data);
      return result.toString();
    } catch (err) {
      return "Error";
    }
  }
  throw Error(`Unknown operation '${operation}'`);
}
