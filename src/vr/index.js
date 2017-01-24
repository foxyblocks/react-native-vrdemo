import React, { PropTypes } from 'react';
import { requireNativeComponent } from 'react-native';


// ------------------------------------------------------------------------------------------
// PropTypes
// ------------------------------------------------------------------------------------------
const Vector3Type = PropTypes.shape({
  x: PropTypes.number.isRequired,
  y: PropTypes.number.isRequired,
  z: PropTypes.number.isRequired,
});

const NodeTypes = {
  position: Vector3Type,
  rotation: Vector3Type,
};
// ------------------------------------------------------------------------------------------

export const VRView = props => <VRViewNative {...props} />;
VRView.propTypes = { };

export const Group = props => <NodeNative {...props} />;
Group.propTypes = {
  ...NodeTypes,
};


export const Sphere = props => <SphereNative {...props} />;
Sphere.propTypes = {
  ...NodeTypes,
  radius: PropTypes.number,
};

export const Plane = props => <PlaneNative {...props} />;
Plane.propTypes = {
  ...NodeTypes,
  width: PropTypes.number,
  height: PropTypes.number,
};

const VRViewNative = requireNativeComponent('VRView', VRView);
const NodeNative = requireNativeComponent('VRNodeView', Group);
const SphereNative = requireNativeComponent('VRSphereView', Sphere);
const PlaneNative = requireNativeComponent('VRPlaneView', Plane);

