import React from 'react';
import { VRView, Group, Sphere, Plane, Floor } from './vr';

export default function MainScene() {
  return (
    <VRView style={{ flex: 1 }} devBar >
      <Floor position={{ y: -7 }} color="#111" reflectivity={0.12} />
      <Group position={{ y: 2, z: -10 }}>
        <Sphere color="#f00" radius={1} position={{ x: 3 }} />
        <Sphere color="#0f0" radius={1} position={{ x: -3 }} />
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
