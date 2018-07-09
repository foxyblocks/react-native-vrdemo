import React, { Component } from 'react';
import { VRView, Group, Sphere, Plane } from '../vr';
import * as TEXTURES from '../lib/textures';
import Button from '../components/button';

export default class HomeScene extends Component {
  onPickSpaceScene = () => {
    this.props.onChangeScene('space');
  };

  render() {
    return (
      <VRView style={{ flex: 1 }} devBar pointer>
        <Sphere radius={80} color="red" textureSrc={TEXTURES.SKY} isDoubleSided />
        <Group position={{ z: -15 }}>
          <Group position={{ x: -6 }}>
            <Sphere onPointerHold={this.onPickSpaceScene} textureSrc={TEXTURES.EARTH} radius={2} />
            <Button scale={3} position={{ y: -6 }}>
              Space Textures
            </Button>
          </Group>
          <Group position={{ x: 6 }}>
            <Plane
              onPointerHold={() => this.props.onChangeScene('video')}
              textureSrc={require('../assets/videos/paris_drive.png')}
              width={3.45}
              height={1.66}
              scale={1.5}
            />
            <Button position={{ y: -6 }} scale={3}>
              Video Gallery
            </Button>
          </Group>
        </Group>
      </VRView>
    );
  }
}
