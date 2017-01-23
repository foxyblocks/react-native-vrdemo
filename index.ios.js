/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import { AppRegistry, } from 'react-native';

import MainScene from './src/main_scene';

export default class VRDemo extends Component {
  render() {
    return (
      <MainScene />
    );
  }
}

AppRegistry.registerComponent('VRDemo', () => VRDemo);
