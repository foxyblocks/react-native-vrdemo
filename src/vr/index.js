import React, { Component, PropTypes } from 'react';
import { requireNativeComponent } from 'react-native';

// ------------------------------------------------------------------------------------------
// PropTypes
// ------------------------------------------------------------------------------------------
const Vector3Zero = {x: 0, y: 0, z: 0};

const Vector3Type = PropTypes.shape({
  x: PropTypes.number,
  y: PropTypes.number,
  z: PropTypes.number,
});

const NodeTypes = {
  position: Vector3Type,
  rotation: Vector3Type,
};

const NodeDefaults = {
  position: Vector3Zero,
  rotation: Vector3Zero,
};
// ------------------------------------------------------------------------------------------

export const VRView = props => <VRViewNative {...props} />;
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
  ...NodeTypes,
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

  Grouped.propTypes = NodeTypes;

  return Grouped;
};

export const Hud = props => <HudNative {...props} />;
Hud.propTypes = {
  ...NodeTypes,
};

Hud.defaultProps = {
};

export const Sphere = withGroup(props => <SphereNative {...props} />);
Sphere.propTypes = {
  ...NodeTypes,
  radius: PropTypes.number,
};

Sphere.defaultProps = {
  radius: 1,
};

export const Plane = withGroup(props => <PlaneNative {...props} />);

Plane.propTypes = {
  ...NodeTypes,
  width: PropTypes.number,
  height: PropTypes.number,
};

Plane.defaultProps = {
  width: 1,
  height: 1,
};

const VRViewNative = requireNativeComponent('VRView', VRView);
const NodeNative = requireNativeComponent('VRNodeView', Group, {
  nativeOnly: { nodePosition: true },
});
const HudNative = requireNativeComponent('VRHudView', Hud);
const SphereNative = requireNativeComponent('VRSphereView', Sphere);
const PlaneNative = requireNativeComponent('VRPlaneView', Plane);

