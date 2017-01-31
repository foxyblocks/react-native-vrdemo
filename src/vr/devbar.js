import React, { Component } from 'react';
import { Group, Text, Plane } from './index';

export default class Devbar extends Component {
  render() {
    const text = this.props.showingCamera ? 'Hide Camera' : 'Show Camera';
    return (
      <Group position={{ z: 0, y: -2, x: 1 }} rotation={{ x: -45, y: -90 }} >
        <Plane
          width={2}
          height={0.5}
          position={{ x: 0, y: 1, z: 0 }}
          onPointerHold={this.props.onToggleCamera}
          color="transparent"
        />
        <Text alignment="center" fontSize={0.2}>
          {text}
        </Text>
      </Group>
    );
  }
}
