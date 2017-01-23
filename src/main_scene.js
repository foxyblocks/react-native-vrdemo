import React, { Component } from 'react';
import VRView, { Group, Sphere } from './vr';

export default class MainScene extends Component {

  render() {
    return (
      <VRView style={{flex: 1}}>
        <Group position={{x: 0, y: -4, z: 0}}>
          <Sphere position={{x: -1, y: 0, z: 0}} />
          <Sphere position={{x: 0, y: 0, z: 1}} />
        </Group>
      </VRView>
    );
  }
}

