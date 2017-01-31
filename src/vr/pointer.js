import { compact } from 'lodash';
import React, { Component } from 'react';
import { View } from 'react-native';
import { AnimatedCircularProgress } from 'react-native-circular-progress';

export default class Pointer extends Component {
  constructor(props) {
    super(props);
    this.circles = [];
    this.startAnimating = this.startAnimating.bind(this);
    this.reset = this.reset.bind(this);
  }

  startAnimating() {
    this.circles.forEach((circle) => {
      circle.performLinearAnimation(100, 1000);
    });
  }

  reset() {
    this.circles.forEach((circle) => {
      circle.performLinearAnimation(0, 350);
    });
  }

  render() {
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
      justifyContent: 'center',
    };

    const eyeOffset = -20;

    const leftView = {
      ...viewStyle,
      marginRight: eyeOffset,
    };

    const rightView = {
      ...viewStyle,
      marginLeft: eyeOffset,
    };

    const circleRef = (c) => {
      this.circles = compact(this.circles.concat(c));
    };

    const circleProps = {
      size: 40,
      fill: 0,
      width: 10,
      backgroundColor: 'rgba(255,255,255, 0.5)',
      tintColor: 'white',
      style: circleStyle,
    };


    return (
      <View style={container} pointerEvents="none">
        <View style={leftView}>
          <AnimatedCircularProgress ref={circleRef} {...circleProps} />
        </View>
        <View style={rightView}>
          <AnimatedCircularProgress ref={circleRef} {...circleProps} />
        </View>
      </View>
    );
  }
}
