import Big from 'big.js';
import axios from 'axios';
import balancers from '../../microservices_balancers.json'

export default async function operate(numberOne, numberTwo, operation) {
  const multiplier_url = `http://${balancers.multiplier}:80/`
  const adder_url = `http://${balancers.adder}:80/`
  const one = Big(numberOne);
  const two = Big(numberTwo);
  if (operation === '+') {
    return (await axios.get(adder_url +'sum?a='+one+"&b="+two)).data.toString();
  }
  if (operation === '-') {
    return (await axios.get(adder_url +'sub?a='+one+"&b="+two)).data.toString();
  }
  if (operation === 'x') {
    return (await axios.get(multiplier_url + 'multiplier?num1='+one+"&num2="+two)).data.result.toString();
  }
  if (operation === '÷') {
    return (await axios.get(multiplier_url + 'divisor?num1='+one+"&num2="+two)).data.result.toString();
  }
  throw Error(`Unknown operation '${operation}'`);
}
