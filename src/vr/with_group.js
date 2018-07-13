import { pick, omit } from 'lodash';
import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { NodeProps, PointableProps } from './lib/prop_types';
import Group from './group';
import { resolveAsset } from './lib/utils';

const withGroup = Wrapped => {
  class Grouped extends Component {
    static propTypes = {
      ...PointableProps,
    };

    static defaultProps = {};

    static contextTypes = {
      startPointer: PropTypes.func,
      endPointer: PropTypes.func,
    };

    componentWillUnmount() {
      clearTimeout(this.timeout);
    }

    handleHitStart = () => {
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
          this.context.endPointer();
        }
      }, 1000);
    };

    handleHitEnd = () => {
      if (this.props.onPointerLeave) {
        this.props.onPointerLeave();
      }
      if (!this.props.onPointerHold) {
        return;
      }

      clearTimeout(this.timeout);
      this.context.endPointer();
    };

    render() {
      const groupProps = Object.keys(NodeProps);

      return (
        <Group
          {...pick(this.props, groupProps)}
          onHitStart={this.handleHitStart}
          onHitEnd={this.handleHitEnd}
        >
          <Wrapped
            {...omit(this.props, groupProps)}
            textureSrc={resolveAsset(this.props.textureSrc)}
          />
        </Group>
      );
    }
  }

  return Grouped;
};

export default withGroup;
