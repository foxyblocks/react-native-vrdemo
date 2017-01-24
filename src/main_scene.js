import React from 'react';
import { VRView, Group, Sphere, Plane } from './vr';

export default function MainScene() {
  return (
    <VRView style={{ flex: 1 }}>
      <Group position={{ x: 0, y: -9, z: 0 }}>
        <Sphere color="#f00" radius={2} />
        <Plane color="#00f" width={4} height={4} position={{ x: -1, y: 0, z: 2 }} />
        <Sphere color="#0f0" radius={1} position={{ x: 4, y: 0, z: 0 }} />
      </Group>
    </VRView>
  );
}
