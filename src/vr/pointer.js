import React from 'react';
import { View } from 'react-native';
import { AnimatedCircularProgress } from 'react-native-circular-progress';

export default function Pointer() {
  const container = {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    flexDirection: 'row',
    position: 'absolute',
    left: 0,
    top: 0,
    bottom: 0,
    right: 0,
  };

  const circleStyle = {
    backgroundColor: 'transparent',
  };

  const viewStyle = {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center', };

  const eyeOffset = -20;

  const leftView = {
    ...viewStyle,
    marginRight: eyeOffset,
  };

  const rightView = {
    ...viewStyle,
    marginLeft: eyeOffset,
  };

  const circleProps = {
    size: 40,
    fill: 20,
    width: 10,
    backgroundColor: 'rgba(255,255,255, 0.5)',
    tintColor: 'white',
    style: circleStyle,
  };

  return (
    <View style={container} pointerEvents="none">
      <View style={leftView}>
        <AnimatedCircularProgress {...circleProps} />
      </View>
      <View style={rightView}>
        <AnimatedCircularProgress {...circleProps} />
      </View>
    </View>
  );
}
