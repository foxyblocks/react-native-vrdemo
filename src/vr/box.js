import React from 'react';
import PropTypes from 'prop-types';
import { requireNativeComponent } from 'react-native';
import { ShapeProps } from './lib/prop_types';
import withGroup from './with_group';

const Box = withGroup(props => <BoxNative {...props} />);

Box.propTypes = {
  ...ShapeProps,
  width: PropTypes.number,
  height: PropTypes.number,
  length: PropTypes.number,
  borderRadius: PropTypes.number,
};

Box.defaultProps = {
  width: 1,
  height: 1,
  length: 1,
  borderRadius: 0,
};

const BoxNative = requireNativeComponent('VRBoxView', Box);

export default Box;
