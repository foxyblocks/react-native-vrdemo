import React from 'react';
import PropTypes from 'prop-types';
import { requireNativeComponent } from 'react-native';
import { ShapeProps } from './lib/prop_types';
import withGroup from './with_group';

const Floor = withGroup(props => <FloorNative {...props} />);

Floor.propTypes = {
  ...ShapeProps,
  reflectivity: PropTypes.number,
};

const FloorNative = requireNativeComponent('VRFloorView', Floor);

export default Floor;
