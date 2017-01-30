import React, { PropTypes } from 'react';
import Pointer from './pointer.js';
import { requireNativeComponent, ColorPropType, View } from 'react-native';

// ------------------------------------------------------------------------------------------
// PropTypes
// ------------------------------------------------------------------------------------------
const Vector3Zero = {x: 0, y: 0, z: 0};

const Vector3Type = PropTypes.shape({
  x: PropTypes.number,
  y: PropTypes.number,
  z: PropTypes.number,
});

const NodeProps = {
  position: Vector3Type,
  rotation: Vector3Type,
};

const NodeDefaults = {
  position: Vector3Zero,
  rotation: Vector3Zero,
};

const ShapeProps = {
  color: ColorPropType,
};
// ------------------------------------------------------------------------------------------

export const VRView = props => (
  <View style={{ flex: 1 }}>
    <VRViewNative {...props} />
    <Pointer />
  </View>
);
VRView.propTypes = { };

export const Group = ({ position, rotation, ...rest }) => {
  const passedProps = {
    // rename position to nodePosition to avoid name conflict
    // we also merge in a zero for any missing axis.
    // allowing the consumer to only specify the axes that are non-zero
    nodePosition: { ...Vector3Zero, ...position },
    rotation: { ...Vector3Zero, ...rotation },
    ...rest,
  };

  return <NodeNative {...passedProps} />;
};

Group.propTypes = {
  ...NodeProps,
};

Group.defaultProps = {
  ...NodeDefaults,
};


const withGroup = (Wrapped) => {
  function Grouped({ position, rotation, ...rest }) {
    return (
      <Group position={position} rotation={rotation}>
        <Wrapped {...rest} />
      </Group>
    );
  }

  Grouped.propTypes = NodeProps;

  return Grouped;
};

export const Hud = props => <HudNative {...props} />;
Hud.propTypes = {
  ...NodeProps,
};

Hud.defaultProps = {
};

export const Sphere = withGroup(props => <SphereNative {...props} />);
Sphere.propTypes = {
  ...NodeProps,
  ...ShapeProps,
  radius: PropTypes.number,
};

Sphere.defaultProps = {
  radius: 1,
};

export const Plane = withGroup(props => <PlaneNative {...props} />);

Plane.propTypes = {
  ...NodeProps,
  ...ShapeProps,
  width: PropTypes.number,
  height: PropTypes.number,
};

Plane.defaultProps = {
  width: 1,
  height: 1,
};

export const Floor = withGroup(props => <FloorNative {...props} />);

Floor.propTypes = {
  ...NodeProps,
  ...ShapeProps,
  reflectivity: PropTypes.number,
};

const VRViewNative = requireNativeComponent('VRView', VRView);
const NodeNative = requireNativeComponent('VRNodeView', Group, {
  nativeOnly: { nodePosition: true },
});
const HudNative = requireNativeComponent('VRHudView', Hud);
const SphereNative = requireNativeComponent('VRSphereView', Sphere);
const PlaneNative = requireNativeComponent('VRPlaneView', Plane);
const FloorNative = requireNativeComponent('VRFloorView', Floor);

