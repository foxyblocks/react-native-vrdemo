import React, { Component } from 'react';
import { VRView } from './vr';
import MainScene from './scenes/main_scene';

export default class AppView extends Component {
  render() {
    return (
      <VRView style={{ flex: 1 }} devBar >
        <MainScene />
      </VRView>
    );
  }
}
