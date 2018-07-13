import React from 'react';
import HomeScene from './scenes/home_scene';
import VideoScene from './scenes/video_scene';
import SpaceScene from './scenes/space_scene';

const SCENES = {
  home: HomeScene,
  space: SpaceScene,
  video: VideoScene,
};

export default class AppView extends React.Component {
  state = {
    currentScene: 'home',
  };

  onChangeScene = newScene => {
    this.setState({ currentScene: newScene });
  };

  render() {
    return React.createElement(SCENES[this.state.currentScene], {
      onChangeScene: this.onChangeScene,
    });
  }
}
