import React, { Component } from 'react';
import VRView, { Group, Sphere } from './vr';

export default class MainScene extends Component {

  render() {
    return (
      <VRView style={{flex: 1}}>
        <Group position={{x: 0, y: -9, z: 0}}>
          <Sphere radius={2} />
          <Sphere radius={1} position={{x: 4, y: 0, z: 0}} />
        </Group>
      </VRView>
    );
  }
}

