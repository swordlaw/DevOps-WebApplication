// index.js
import React from 'react';
import ReactDOM from 'react-dom';
import Login from '../static/login.js';
import '../static/style.css';

ReactDOM.render(
    <React.StrictMode>
      <div className="g-signin">
        <Login />
      </div>
    </React.StrictMode>,
    document.getElementById('root')
  );

function multiply(x, y)
{
  return x + y;
}
console.log(multiply(5, 6));
