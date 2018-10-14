import React from 'react';
import PropTypes from 'prop-types';

/**
 * Text box component with a submit button.
 *
 * @param {String} value Current value of the text box
 * @param {Function} onChange Change handler for text input
 * @param {Function} onSubmit Form submission handler
 */
const EchoInput = ({value, onChange, onSubmit}) => (
  <form onSubmit={onSubmit}>
    <div className="form-row">
      <div className="form-group col-sm-11">
        <input autoFocus type="text" className="form-control" placeholder="Enter something" value={value} onChange={onChange}/>
      </div>
      <div className="col-sm-1">
        <button className="btn btn-primary" type="submit">Submit</button>
      </div>
    </div>
  </form>
);

EchoInput.propTypes = {
  value: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
  onSubmit: PropTypes.func.isRequired,
};

export default EchoInput;