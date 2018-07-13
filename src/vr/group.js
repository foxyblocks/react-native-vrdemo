import React, { Component } from 'react';
import { requireNativeComponent } from 'react-native';
import PropTypes from 'prop-types';
import { Vector3Zero, NodeProps, NodeDefaults } from './lib/prop_types';
import { convertScale } from './lib/utils';

export default class Group extends Component {
  static propTypes = {
    ...NodeProps,
    onHitStart: PropTypes.func,
    onHitEnd: PropTypes.func,
  };

  static defaultProps = {
    ...NodeDefaults,
    onHitStart: () => {},
    onHitEnd: () => {},
  };

  render() {
    const { position, rotation, scale, ...rest } = this.props;
    const passedProps = {
      // rename position to nodePosition to avoid name conflict
      // we also merge in a zero for any missing axis.
      // allowing the consumer to only specify the axes that are non-zero
      nodePosition: { ...Vector3Zero, ...position },
      rotation: { ...Vector3Zero, ...rotation },
      scale: { ...NodeDefaults.scale, ...convertScale(scale) },
      ...rest,
    };

    return <NodeNative {...passedProps} />;
  }
}

const NodeNative = requireNativeComponent('VRNodeView', Group, {
  nativeOnly: { nodePosition: true },
});
