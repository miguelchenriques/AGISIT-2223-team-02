import React from 'react';
import { useState, useEffect } from 'react';
import axios from 'axios';
import balancers from '../../microservices_balancers.json'

const List = () => {

    const [list, setListValues] = useState([]);

    console.log(list)

    const refs = list.reduce((acc, value) => {
        acc[value.id] = React.createRef();
        return acc;
    }, {});

    const handleClick  = () => {
        axios.get(`http://${balancers.adder}:80/history`).then(response => setListValues(response.data));

        console.log(list)
    }

    useEffect(() => {
        handleClick();
    }, []);

    return (
        <div className='list-wrapper'>
            <h3>History</h3>
            <ul className='list'>
                {list.map(item => (
                    <li
                        key={item.id}
                        ref={refs[item.id]}
                        style={{ height: '35px', width: '200px', border: '1px solid black', fontSize: '16px', textAlign: 'center' }}
                    >
                        <p>{item.num1} {item.operation} {item.num2} = {item.result}</p>
                    </li>
                ))}
            </ul>
            <button type="button" className='refresh' onClick={handleClick}>Refresh</button>
        </div>
    );
};

export default List;