import React from 'react';
import * as ReactDOM from 'react-dom';
import App from './js/App';

import '../../node_modules/bootstrap/dist/css/bootstrap.min.css';

/** Initialize the main application page */
window.initApp = ({homeUrl, echoUrl}) => {
  ReactDOM.render(
    <App homeUrl={homeUrl}
      echoUrl={echoUrl} />,
    document.getElementById('root'));
}
