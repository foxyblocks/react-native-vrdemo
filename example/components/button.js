import React from 'react';
import PropTypes from 'prop-types';
import { Group, Plane, Text } from '../../src/vr';

export default class Button extends React.Component {
  static propTypes = {
    children: PropTypes.node,
    onPointerHold: PropTypes.func,
  };

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
          {children}
        </Text>
      </Group>
    );
  }
}
