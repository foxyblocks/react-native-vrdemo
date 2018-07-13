import React, { Component } from 'react';
import { VRView, Group, Sphere, Plane } from '../vr';
import * as TEXTURES from '../lib/textures';
import Button from '../components/button';
import Planet from '../components/planet';

export default class HomeScene extends Component {
  state = { rotationTo: 360 };
  onPickSpaceScene = () => {
    this.props.onChangeScene('space');
  };

  onRest = () => {
    this.setState({
      rotationTo: this.state.rotationTo + 360,
    });
  };

  render() {
    return (
      <VRView style={{ flex: 1 }} devBar pointer>
        <Sphere radius={80} textureSrc={TEXTURES.SKY} isDoubleSided />
        <Group position={{ z: -15 }}>
          <Group position={{ x: -6 }}>
            <Planet
              onPointerHold={this.onPickSpaceScene}
              textureSrc={TEXTURES.EARTH}
              radius={2}
              rpm={1}
            />
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
              360 Video Gallery
            </Button>
          </Group>
        </Group>
      </VRView>
    );
  }
}
