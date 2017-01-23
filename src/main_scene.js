import React, { Component } from 'react';
import VRView, { Group } from './vr';

export default class MainScene extends Component {

  render() {
    return (
      <VRView style={{flex: 1}}>
        <Group position={{x: 0, y: -7, z: -4}} />
      </VRView>
    );
  }
}

