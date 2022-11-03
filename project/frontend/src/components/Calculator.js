import React, { useState } from 'react';
import DisplayScreen from './Screen';
import NumericKeys from './Numbers';
import OperatorKeys from './Operators';
import calculate from './logic/calculate';
import List from './history/History';

const Calculator = () => {
  const [state, setState] = useState({
    obj: {
      total: null,
      next: null,
      operation: null,
    },
  });

  const handleClick = (event) => {
    const { obj } = state;
    setState({ obj: calculate(obj, event.target.textContent) });
  };
  const { obj } = state;
  const { total, next, operation } = obj;
  return (
    <div className='wrapper'>
      <div className="calc-container">
        <DisplayScreen next={next} total={total} operation={operation} />
        <OperatorKeys handleClick={handleClick} />
        <NumericKeys handleClick={handleClick} />
      </div>
      <div>
        <List />
      </div>
    </div>
  );
};
export default Calculator;
