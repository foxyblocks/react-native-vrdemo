import React, { Component } from 'react';
import { VRView, Group, Sphere, Plane, Floor, Box } from '../vr';
import * as TEXTURES from '../lib/textures';

export default class SpaceScene extends Component {
  render() {
    return (
      <VRView style={{ flex: 1 }} bgSrc={TEXTURES.SPACE} devBar pointer>
        <Group position={{ y: 2, z: -8 }}>
          <Group position={{ x: -3 }}>
            <Sphere textureSrc={TEXTURES.EARTH} radius={1} />
            <Sphere textureSrc={TEXTURES.MOON} radius={0.3} position={{ x: -3 }} />
          </Group>
          <Sphere textureSrc={TEXTURES.MARS} radius={1} position={{ x: 3, y: 2 }} />
          <Plane
            width={4}
            height={4}
            color="rgba(0,0,255, 0.5)"
            position={{ z: 2, x: 3, y: 1 }}
            rotation={{ x: -45 }}
          />
          <Box textureSrc={TEXTURES.BORG} rotation={{ y: 45 }} position={{ z: 3 }} />
        </Group>
      </VRView>
    );
  }
}
