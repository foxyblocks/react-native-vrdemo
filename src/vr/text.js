import React from 'react';
import PropTypes from 'prop-types';
import { requireNativeComponent } from 'react-native';
import { ShapeProps } from './lib/prop_types';
import withGroup from './with_group';

const Text = withGroup(({ value, children, ...rest }) => {
  const passedProps = {
    ...rest,
    value: value || React.Children.toArray(children).join('') || '',
  };

  return <TextNative {...passedProps} />;
});

Text.propTypes = {
  ...ShapeProps,
  value: PropTypes.string,
  fontSize: PropTypes.number,
  truncation: PropTypes.oneOf(['none', 'start', 'middle', 'end']),
  alignment: PropTypes.oneOf(['left', 'right', 'center', 'justified', 'natural']),
  children: PropTypes.oneOfType([PropTypes.string, PropTypes.arrayOf(PropTypes.string)]),
};

const TextNative = requireNativeComponent('VRTextView', Text);

export default Text;
