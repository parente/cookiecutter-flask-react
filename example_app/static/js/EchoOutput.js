import React from 'react';
import PropTypes from 'prop-types';

/**
 * Alert component to render echo from the server.
 *
 * @param {String} value
 */
const EchoOutput = ({value}) => (
  <div className="alert alert-primary" hidden={value ? false : true}>
    <span className="badge badge-light">Server says:</span> {value}
  </div>
);

EchoOutput.propTypes = {
  value: PropTypes.string.isRequired,
};

export default EchoOutput;