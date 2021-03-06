import React, { Component } from 'react';
import { VRView, Group, Sphere, Box } from '../../src/vr';
import * as TEXTURES from '../lib/textures';
import HomeButton from '../components/home_button';
import Planet from '../components/planet';

export default class SpaceScene extends Component {
  handleGoHome = () => {
    this.props.onChangeScene('home');
  };
  render() {
    return (
      <VRView style={{ flex: 1 }} devBar pointer>
        <Sphere rotation={{ x: -180 }} radius={80} textureSrc={TEXTURES.SPACE2} isDoubleSided />
        <HomeButton position={{ z: -3, y: -3 }} onSelect={this.handleGoHome} />
        <Group position={{ y: 2, z: -8 }}>
          <Group position={{ x: -3 }}>
            <Planet textureSrc={TEXTURES.EARTH} radius={1} />
            <Planet textureSrc={TEXTURES.MOON} radius={0.3} position={{ x: -3 }} />
          </Group>
          <Planet textureSrc={TEXTURES.MARS} radius={1} position={{ x: 3, y: 2 }} />
          <Box textureSrc={TEXTURES.BORG} rotation={{ y: 45 }} position={{ z: 3 }} />
        </Group>
      </VRView>
    );
  }
}
