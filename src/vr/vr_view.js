/* global VRViewNative */
import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { ColorPropType, View, requireNativeComponent } from 'react-native';
import Pointer from './pointer';
import Devbar from './devbar';
import { resolveAsset } from './lib/utils';

export default class VRView extends Component {
  static propTypes = {
    showRealWorld: PropTypes.bool,
    bgColor: ColorPropType,
    bgSrc: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
    devBar: PropTypes.bool,
    pointer: PropTypes.bool,
    children: PropTypes.node.isRequired,
  };

  static defaultProps = {
    showRealWorld: false,
    devBar: false,
    pointer: false,
  };

  static childContextTypes = {
    startPointer: PropTypes.func,
    endPointer: PropTypes.func,
  };

  state = {
    showingCamera: !!this.props.showRealWorld,
  };

  getChildContext() {
    return {
      startPointer: this.handlePointerStart,
      endPointer: this.handlePointerEnd,
    };
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.showRealWorld !== this.props.showRealWorld) {
      this.setState({ showRealWorld: nextProps.showRealWorld });
    }
  }

  handlePointerStart = () => {
    if (this.pointer) {
      this.pointer.startAnimating();
    }
  };

  handlePointerEnd = () => {
    if (this.pointer) {
      this.pointer.reset();
    }
  };

  handleToggleCamera = () => {
    this.setState({ showingCamera: !this.state.showingCamera });
  };

  render() {
    const { children, bgSrc, ...rest } = this.props;
    const { showingCamera } = this.state;

    const passedProps = {
      ...rest,
      bgSrc: resolveAsset(bgSrc),
      showRealWorld: showingCamera,
    };

    return (
      <View style={{ flex: 1 }}>
        <VRViewNative {...passedProps}>
          {this.props.devBar ? (
            <Devbar showingCamera={showingCamera} onToggleCamera={this.handleToggleCamera} />
          ) : null}
          {children}
        </VRViewNative>
        {this.props.pointer ? (
          <Pointer
            ref={c => {
              this.pointer = c;
            }}
          />
        ) : null}
      </View>
    );
  }
}

const VRViewNative = requireNativeComponent('VRView', VRView);
