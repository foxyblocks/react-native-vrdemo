import React,  { Component } from 'react';
import { requireNativeComponent } from 'react-native';

const VRViewNative = requireNativeComponent('VRView', VRView);

export default class VRView extends Component {
  render() {
    return <VRViewNative {...this.props} />
  }
}
