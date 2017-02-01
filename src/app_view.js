import React, { Component } from 'react';
import MainScene from './scenes/main_scene';
import VideoScene from './scenes/video_scene';

export default class AppView extends Component {
  render() {
    // return <MainScene />;
    return <VideoScene />;
  }
}
