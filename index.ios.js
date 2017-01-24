/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React from 'react';
import { AppRegistry } from 'react-native';

import MainScene from './src/main_scene';

export default function VRDemo() {
  return (
    <MainScene />
  );
}

AppRegistry.registerComponent('VRDemo', () => VRDemo);
