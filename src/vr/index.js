import React from 'react';
import { requireNativeComponent } from 'react-native';

export const VRView = props => <VRViewNative {...props} />;

export const Group = props => <NodeNative {...props} />;

export const Sphere = props => <SphereNative {...props} />;


const VRViewNative = requireNativeComponent('VRView', VRView);
const NodeNative = requireNativeComponent('VRNodeView', Group);
const SphereNative = requireNativeComponent('VRSphereView', Sphere);

