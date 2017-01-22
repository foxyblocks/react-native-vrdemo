import React,  { Component } from 'react';
import { requireNativeComponent } from 'react-native';

const VRTestViewNative = requireNativeComponent('VRTestView', VRTestView);

export default class VRTestView extends Component {
  render() {
    return <VRTestViewNative {...this.props} />
  }
}
