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

import VRTestView from './src/vr_view.js';

export default class VRDemo extends Component {
  render() {
    return (
      <VRTestView style={{flex: 1}} />
    );
  }
}

AppRegistry.registerComponent('VRDemo', () => VRDemo);
