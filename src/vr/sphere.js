import React from 'react';
import PropTypes from 'prop-types';
import { requireNativeComponent } from 'react-native';
import { ShapeProps } from './lib/prop_types';
import withGroup from './with_group';

const Sphere = withGroup(props => <SphereNative {...props} />);

Sphere.propTypes = {
  ...ShapeProps,
  radius: PropTypes.number,
};

Sphere.defaultProps = {
  radius: 1,
};

const SphereNative = requireNativeComponent('VRSphereView', Sphere);

export default Sphere;
