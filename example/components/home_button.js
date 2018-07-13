import React from 'react';
import { Group, Plane } from '../../src/vr';
import Button from './button';
import { HOME_ICON } from '../lib/textures';

export default function HomeButton({ onSelect, children = 'Home', ...rest }) {
  return (
    <Group {...rest}>
      <Plane
        width={0.5}
        height={0.5}
        textureSrc={HOME_ICON}
        position={{ y: 1.4 }}
        onPointerHold={onSelect}
        isDoubleSided
      />
      <Button onPointerHold={onSelect}>{children}</Button>
    </Group>
  );
}
