import React, { Component } from 'react';
import { Group, Sphere, Plane, Floor, Box } from '../vr';

export default class MainScene extends Component {
  render() {
    return (
      <Group>
        <Floor position={{ y: -7 }} color="#111" reflectivity={0.12} />
        <Group position={{ y: 2, z: -10 }}>
          <Sphere color="#f00" radius={1} position={{ x: 3 }} />
          <Sphere
            textureSrc="https://img3.goodfon.ru/original/1920x1200/0/a9/zemlya-karta-oblaka.jpg"
            color="#00f"
            radius={1}
            position={{ x: -3 }}
          />
          <Plane
            color="#0f0"
            width={2}
            height={2}
            position={{ z: 2, x: 5, y: -1 }}
            rotation={{ x: -45 }}
          />
          <Box
            color="#ff0"
            rotation={{ y: 45 }}
            position={{ z: 3, x: -1 }}
          />
        </Group>
      </Group>
    );
  }
}
