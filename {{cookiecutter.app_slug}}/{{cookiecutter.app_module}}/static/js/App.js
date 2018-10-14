import React from 'react';
import EchoInput from './EchoInput';
import EchoOutput from './EchoOutput';
import PropTypes from 'prop-types';

import './App.css';

/**
 * Simple client-server echo application.
 */
class App extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      echoInput: '',
      echoOutput: ''
    }
  }

  /**
   * Stores the current text input state.
   *
   * @param {String} event Text input change event
   */
  handleEchoInput(event) {
    this.setState({echoInput: event.target.value});
  }

  /**
   * Gets the echo of the input value from the server.
   *
   * @param {String} event Form submit event
   */
  handleEchoOutput(event) {
    event.preventDefault();

    this.setState({echoInput: ''});

    fetch(this.props.echoUrl+encodeURI(this.state.echoInput))
      .then((response) => {
        if(response.status !== 200) {
          console.error('Failed to fetch echo:', response);
          this.setState({echoOutput: ''});
          return;
        }
        response.json().then((data) => {
          console.debug('data:', data);
          this.setState({echoOutput: data.value});
        });
      })
      .catch((error) => {
        console.error('Exception fetching echo:', error);
        this.setState({echoOutput: ''});
      });
  }

  render() {
    return (
      <div className="App container">
        <h1 className="display-4">Echo Example</h1>
        <EchoInput value={this.state.echoInput}
          onSubmit={this.handleEchoOutput.bind(this)}
          onChange={this.handleEchoInput.bind(this)} />
        <EchoOutput value={this.state.echoOutput} />
      </div>
    )
  }
}

App.propTypes = {
  homeUrl: PropTypes.string.isRequired,
  echoUrl: PropTypes.string.isRequired,
};

export default App;