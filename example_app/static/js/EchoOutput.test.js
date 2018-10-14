import React from 'react';
import { shallow } from 'enzyme';
import EchoOutput from './EchoOutput';

describe('EchoOutput', () => {
  it('should render an initial value', () => {
      const wrapper = shallow(<EchoOutput value="test-value" />);
      expect(wrapper).toMatchSnapshot();
  });

  it('should be hidden when there is a blank value', () => {
      const wrapper = shallow(<EchoOutput value="" />);
      expect(wrapper).toMatchSnapshot();
  });
});