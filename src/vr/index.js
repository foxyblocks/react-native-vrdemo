import React,  { Component } from 'react';
import { requireNativeComponent, VRNodeManager } from 'react-native';

const VRViewNative = requireNativeComponent('VRView', VRView);
const VRNodeNative = requireNativeComponent('VRNodeView', VRNode);

export default class VRView extends Component {
  render() {
    return <VRViewNative {...this.props} />
  }
}

export class VRNode extends Component {
  render() {
    return <VRNodeNative {...this.props} />;
  }
}
