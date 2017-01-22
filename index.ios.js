/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

import { VRView } from './src/vr';

export default class VRDemo extends Component {
  render() {
    return (
      <VRView style={{flex: 1}} />
    );
  }
}

AppRegistry.registerComponent('VRDemo', () => VRDemo);
