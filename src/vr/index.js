import React,  { Component } from 'react';
import { requireNativeComponent, VRNodeManager } from 'react-native';

const VRViewNative = requireNativeComponent('VRView', VRView);
const VRNodeNative = requireNativeComponent('VRNodeView', Group);
const VRSphereNative = requireNativeComponent('VRSphereView', Sphere);

export default class VRView extends Component {
  render() {
    return <VRViewNative {...this.props} />
  }
}

export class Group extends Component {
  render() {
    return <VRNodeNative {...this.props} />;
  }
}

export class Sphere extends Component {
  render() {
    return <VRSphereNative {...this.props} />;
  }
}
