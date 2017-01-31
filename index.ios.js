/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React from 'react';
import { AppRegistry } from 'react-native';

import AppView from './src/app_view';

export default function VRDemo() {
  return (
    <AppView />
  );
}

AppRegistry.registerComponent('VRDemo', () => VRDemo);
