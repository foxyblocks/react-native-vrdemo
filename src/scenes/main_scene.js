import React, { Component } from 'react';
import { VRView, Group, Sphere, Plane, Floor, Box } from '../vr';

const EARTH = "https://img3.goodfon.ru/original/1920x1200/0/a9/zemlya-karta-oblaka.jpg";

export default class MainScene extends Component {
  render() {
    return (
      <VRView style={{ flex: 1 }} devBar pointer >
        <Group position={{ z: -4 }}>
          <Floor
            position={{ y: -2 }}
            color="#0e0e0e"
            reflectivity={0.05}
          />
          <Group position={{ y: 2, z: -10 }}>
            <Sphere color="#f00" radius={1} position={{ x: 3, y: 2 }} />
            <Sphere
              textureSrc={EARTH}
              color="#00f"
              radius={1}
              position={{ x: -3 }}
            />
            <Plane
              color="#0f0"
              width={2}
              height={2}
              position={{ z: 2, x: 3, y: -1 }}
              rotation={{ x: -45 }}
            />
            <Box
              color="#ff0"
              rotation={{ y: 45 }}
              position={{ z: 3, x: -1 }}
            />
          </Group>
        </Group>
      </VRView>
    );
  }
}
