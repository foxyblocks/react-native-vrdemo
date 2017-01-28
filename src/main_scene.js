import React, { Component } from 'react';
import { VRView, Group, Sphere, Plane, Hud } from './vr';

export default class MainScene extends Component {
  render() {
    return (
      <VRView style={{ flex: 1 }}>
        <Group position={{ z: -8 }}>
          <Sphere color="#f00" radius={2} />
          <Sphere color="#0f0" radius={2} position={{ x: -1 }} />
          <Plane
            color="#00f"
            width={3}
            height={3}
            position={{ z: 4, x: 1 }}
            rotation={{ x: -45 }}
          />
        </Group>
      </VRView>
    );
  }
}
