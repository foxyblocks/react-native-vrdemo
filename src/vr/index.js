import { pick, omit } from 'lodash';
import React, { PropTypes, Component } from 'react';
import { requireNativeComponent, ColorPropType, View } from 'react-native';
import Pointer from './pointer';
import Devbar from './devbar';

// ------------------------------------------------------------------------------------------
// PropTypes
// ------------------------------------------------------------------------------------------
const Vector3Zero = {x: 0, y: 0, z: 0};

const Vector3Type = PropTypes.shape({
  x: PropTypes.number,
  y: PropTypes.number,
  z: PropTypes.number,
});

const NodeProps = {
  position: Vector3Type,
  rotation: Vector3Type,
};

const NodeDefaults = {
  position: Vector3Zero,
  rotation: Vector3Zero,
};

const PointableProps = {
  onPointerEnter: PropTypes.func,
  onPointerLeave: PropTypes.func,
  onPointerHold: PropTypes.func,
};

const ShapeProps = {
  ...PointableProps,
  color: ColorPropType,
  textureSrc: PropTypes.string,
};
// ------------------------------------------------------------------------------------------

export class VRView extends Component {
  constructor(props) {
    super(props);
    this.handlePointerStart = this.handlePointerStart.bind(this);
    this.handlePointerEnd = this.handlePointerEnd.bind(this);
    this.handleToggleCamera = this.handleToggleCamera.bind(this);
    this.state = {
      showingCamera: !!this.props.showRealWorld,
    };
  }

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

  handlePointerStart() {
    if (this.pointer) {
      this.pointer.startAnimating();
    }
  }

  handlePointerEnd() {
    if (this.pointer) {
      this.pointer.reset();
    }
  }

  handleToggleCamera() {
    this.setState({ showingCamera: !this.state.showingCamera });
  }

  render() {
    const { children, ...rest } = this.props;
    const { showingCamera } = this.state;

    const passedProps = {
      ...rest,
      showRealWorld: showingCamera,
    };

    return (
      <View style={{ flex: 1 }}>
        <VRViewNative {...passedProps}>
          { this.props.devBar ?
            <Devbar showingCamera={showingCamera} onToggleCamera={this.handleToggleCamera} />
          : null}
          { children }
        </VRViewNative>
        <Pointer ref={(c) => { this.pointer = c; }} />
      </View>
    );
  }
}
VRView.propTypes = {
  showRealWorld: PropTypes.bool,
  devBar: PropTypes.bool,
  children: PropTypes.node.isRequired,
};
VRView.childContextTypes = {
  startPointer: PropTypes.func,
  endPointer: PropTypes.func,
};

export class Group extends Component {
  render() {
    const { position, rotation, ...rest } = this.props;
    const passedProps = {
      // rename position to nodePosition to avoid name conflict
      // we also merge in a zero for any missing axis.
      // allowing the consumer to only specify the axes that are non-zero
      nodePosition: { ...Vector3Zero, ...position },
      rotation: { ...Vector3Zero, ...rotation },
      ...rest,
    };

    return <NodeNative {...passedProps} />;
  }
}

Group.propTypes = {
  ...NodeProps,
  onHitStart: PropTypes.func,
  onHitEnd: PropTypes.func,
};

Group.defaultProps = {
  ...NodeDefaults,
  onHitStart: () => {},
  onHitEnd: () => {},
};


const withGroup = (Wrapped) => {
  class Grouped extends Component {
    constructor(props) {
      super(props);
      this.handleHitStart = this.handleHitStart.bind(this);
      this.handleHitEnd = this.handleHitEnd.bind(this);
    }

    componentWillUnmount() {
      clearTimeout(this.timeout);
    }

    handleHitStart() {
      if (this.props.onPointerEnter) {
        this.props.onPointerEnter();
      }

      if (!this.props.onPointerHold) {
        return;
      }

      this.context.startPointer();
      this.timeout = setTimeout(() => {
        if (this.props.onPointerHold) {
          this.props.onPointerHold();
        }
      }, 1000);
    }

    handleHitEnd() {
      if (this.props.onPointerLeave) {
        this.props.onPointerLeave();
      }
      if (!this.props.onPointerHold) {
        return;
      }

      clearTimeout(this.timeout);
      this.context.endPointer();
    }

    render() {
      const groupProps = [
        'position',
        'rotation',
      ];

      return (
        <Group
          {...pick(this.props, groupProps)}
          onHitStart={this.handleHitStart}
          onHitEnd={this.handleHitEnd}
        >
          <Wrapped {...omit(this.props, groupProps)} />
        </Group>
      );
    }
  }

  Grouped.propTypes = {
    ...PointableProps,
  };

  Grouped.defaultProps = {
  };

  Grouped.contextTypes = {
    startPointer: PropTypes.func,
    endPointer: PropTypes.func,
  };

  return Grouped;
};

export const Sphere = withGroup(props => <SphereNative {...props} />);
Sphere.propTypes = {
  ...ShapeProps,
  radius: PropTypes.number,
};

Sphere.defaultProps = {
  radius: 1,
};

export const Plane = withGroup(props => <PlaneNative {...props} />);

Plane.propTypes = {
  ...ShapeProps,
  width: PropTypes.number,
  height: PropTypes.number,
};

Plane.defaultProps = {
  width: 1,
  height: 1,
};

export const Floor = withGroup(props => <FloorNative {...props} />);

Floor.propTypes = {
  ...ShapeProps,
  reflectivity: PropTypes.number,
};

export const Text = withGroup(({ value, children, ...rest }) => {
  const passedProps = {
    ...rest,
    value: value || children || '',
  };

  return <TextNative {...passedProps} />;
});

Text.propTypes = {
  ...ShapeProps,
  value: PropTypes.string,
  fontSize: PropTypes.number,
  truncation: PropTypes.oneOf(['none', 'start', 'middle', 'end']),
  alignment: PropTypes.oneOf(['left', 'right', 'center', 'justified', 'natural']),
  children: PropTypes.string,
};

const VRViewNative = requireNativeComponent('VRView', VRView);
const NodeNative = requireNativeComponent('VRNodeView', Group, {
  nativeOnly: { nodePosition: true },
});
const SphereNative = requireNativeComponent('VRSphereView', Sphere);
const PlaneNative = requireNativeComponent('VRPlaneView', Plane);
const FloorNative = requireNativeComponent('VRFloorView', Floor);
const TextNative = requireNativeComponent('VRTextView', Text);

