import React, { Component } from 'react';
import { VRView, Video360, Group, Plane, Floor, Text, Sphere } from '../../src/vr';
import * as TEXTURES from '../lib/textures';
import Button from '../components/button';
import HomeButton from '../components/home_button';

const VIDEOS = [
  {
    name: 'Color Run',
    src: 'https://theta360.com/en/gallery/sample/videos_s_4.mp4',
    thumbnail: require('../assets/videos/color_run.png'),
  },
  {
    name: 'Skydive',
    src: 'https://theta360.com/en/gallery/sample/videos_s_9.mp4',
    thumbnail: require('../assets/videos/skydive.png'),
  },
  {
    name: 'Stargazers',
    src: 'https://theta360.com/en/gallery/sample/videos_s_7.mp4',
    thumbnail: require('../assets/videos/stargazers.png'),
  },
  {
    name: 'Paris Drive',
    src: 'https://theta360.com/en/gallery/sample/videos_s_5.mp4',
    thumbnail: require('../assets/videos/paris_drive.png'),
  },
  {
    name: 'Snow',
    src: 'https://theta360.com/en/gallery/sample/videos_s_10.mp4',
    thumbnail: require('../assets/videos/snow.png'),
  },
];

class VideoThumbnail extends Component {
  render() {
    const { src, ...rest } = this.props;

    return <Plane textureSrc={src} {...rest} />;
  }
}

const ITEM_WIDTH = 3.45;
const ITEM_HEIGHT = 1.66;
const ITEM_SPACING = 0.5;

export default class VideoScene extends Component {
  state = {
    currentVideo: null,
  };

  handleVideoSelected(video) {
    this.setState({ currentVideo: video });
  }

  handleGoHome = () => {
    this.props.onChangeScene('home');
  };

  closeVideo = () => {
    this.setState({ currentVideo: null });
  };

  renderCurrentVideo = () => {
    return (
      <Group>
        <Video360 src={this.state.currentVideo.src} />
        <Button position={{ z: -2, y: -1.5, x: -0.5 }} onPointerHold={this.closeVideo}>
          Close
        </Button>
      </Group>
    );
  };

  renderGridItem = (video, index) => {
    const position = { x: index * (ITEM_WIDTH + ITEM_SPACING) };
    const onPointerHold = this.handleVideoSelected.bind(this, video);

    return (
      <VideoThumbnail
        key={video.src}
        position={position}
        width={ITEM_WIDTH}
        height={ITEM_HEIGHT}
        src={video.thumbnail}
        onPointerHold={onPointerHold}
      />
    );
  };

  renderGrid() {
    const totalWidth = (VIDEOS.length - 1) * (ITEM_WIDTH + ITEM_SPACING);
    const x = totalWidth * -1;
    return (
      <Group>
        <Group scale={2} position={{ x, y: 3, z: -15 }}>
          {VIDEOS.map(this.renderGridItem)}
        </Group>
      </Group>
    );
  }

  render() {
    return (
      <VRView style={{ flex: 1 }} pointer>
        <Sphere radius={80} color="red" textureSrc={TEXTURES.SKY} isDoubleSided />
        <HomeButton position={{ z: -3, y: -3 }} onSelect={this.handleGoHome} />
        {this.state.currentVideo ? this.renderCurrentVideo() : this.renderGrid()}
      </VRView>
    );
  }
}
