import React, { Component } from "react";
import { VRView, Video360, Group, Plane, Floor, Text } from "../vr";

const VIDEOS = [
  {
    name: "Color Run",
    src: "https://theta360.com/en/gallery/sample/videos_s_4.mp4",
    thumbnail: "https://theta360.com/en/gallery/img/gallery_57.png"
  },
  {
    name: "Skydive",
    src: "https://theta360.com/en/gallery/sample/videos_s_9.mp4",
    thumbnail: "https://theta360.com/en/gallery/img/gallery_62.png"
  },
  {
    name: "Stargazers",
    src: "https://theta360.com/en/gallery/sample/videos_s_7.mp4",
    thumbnail: "https://theta360.com/en/gallery/img/gallery_60.png"
  },
  {
    name: "Paris Drive",
    src: "https://theta360.com/en/gallery/sample/videos_s_5.mp4",
    thumbnail: "https://theta360.com/en/gallery/img/gallery_58.png"
  },
  {
    name: "Snow",
    src: "https://theta360.com/en/gallery/sample/videos_s_10.mp4",
    thumbnail: "https://theta360.com/en/gallery/img/gallery_63.png"
  }
];

class Button extends Component {
  render() {
    const { children, onPointerHold, ...rest } = this.props;

    return (
      <Group {...rest}>
        <Plane
          width={2}
          height={0.5}
          position={{ y: 1 }}
          onPointerHold={onPointerHold}
          color="transparent"
        />
        <Text alignment="center" fontSize={0.2}>
          {" "}
          {children}{" "}
        </Text>
      </Group>
    );
  }
}

class VideoThumbnail extends Component {
  render() {
    const { src, ...rest } = this.props;

    return <Plane textureSrc={src} {...rest} />;
  }
}

const itemWidth = 3.45;
const itemHeight = 1.66;
const spacing = 0.5;

export default class VideoScene extends Component {
  constructor(props) {
    super(props);
    this.state = {};
    this.renderGridItem = this.renderGridItem.bind(this);
    this.renderCurrentVideo = this.renderCurrentVideo.bind(this);
    this.closeVideo = this.closeVideo.bind(this);
  }

  handleVideoSelected(video) {
    this.setState({ currentVideo: video });
  }

  closeVideo() {
    this.setState({ currentVideo: null });
  }

  renderCurrentVideo() {
    return (
      <Group>
        <Video360 src={this.state.currentVideo.src} />
        <Button
          position={{ z: -2, y: -1.5, x: -0.5 }}
          onPointerHold={this.closeVideo}
        >
          Close
        </Button>
      </Group>
    );
  }

  renderGridItem(video, index) {
    const position = { x: index * (itemWidth + spacing) };
    const onPointerHold = this.handleVideoSelected.bind(this, video);

    return (
      <VideoThumbnail
        key={video.src}
        position={position}
        width={itemWidth}
        height={itemHeight}
        src={video.thumbnail}
        onPointerHold={onPointerHold}
      />
    );
  }

  renderGrid() {
    const totalWidth = (VIDEOS.length - 1) * (itemWidth + spacing) - spacing;
    const x = -0.5 * totalWidth;
    return (
      <Group>
        <Floor position={{ y: -4 }} color="#111" reflectivity={0.1} />
        <Group scale={2} position={{ x, y: 3, z: -20 }}>
          {VIDEOS.map(this.renderGridItem)}
        </Group>
      </Group>
    );
  }

  render() {
    return (
      <VRView style={{ flex: 1 }} pointer>
        {this.state.currentVideo
          ? this.renderCurrentVideo()
          : this.renderGrid()}
      </VRView>
    );
  }
}
