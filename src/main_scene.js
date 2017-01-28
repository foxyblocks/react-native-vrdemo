import React, { Component } from 'react';
import { VRView, Group, Sphere, Plane, Hud, Floor } from './vr';

export default class MainScene extends Component {
  render() {
    return (
      <VRView style={{ flex: 1 }} >
        <Floor position={{ y: -2 }} color="#111" reflectivity={0.12}/>
        <Group position={{ z: -10 }}>
          <Sphere color="#f00" radius={1} />
          <Sphere color="#0f0" radius={1} position={{ x: -1 }} />
          <Plane
            color="#00f"
            width={2}
            height={2}
            position={{ z: 2, x: 2, y: -1 }}
            rotation={{ x: -45 }}
          />
        </Group>
      </VRView>
    );
  }
}
