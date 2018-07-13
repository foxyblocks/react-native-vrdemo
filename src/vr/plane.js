import React from 'react';
import PropTypes from 'prop-types';
import { requireNativeComponent } from 'react-native';
import { ShapeProps } from './lib/prop_types';
import withGroup from './with_group';

const Plane = withGroup(props => <PlaneNative {...props} />);

Plane.propTypes = {
  ...ShapeProps,
  width: PropTypes.number,
  height: PropTypes.number,
};

Plane.defaultProps = {
  width: 1,
  height: 1,
};

const PlaneNative = requireNativeComponent('VRPlaneView', Plane);

export default Plane;
