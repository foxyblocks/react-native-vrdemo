/**
 * Common prop types
 */

import PropTypes from 'prop-types';
import { ColorPropType } from 'react-native';
export const Vector3Zero = { x: 0, y: 0, z: 0 };

export const Vector3Type = PropTypes.shape({
  x: PropTypes.number,
  y: PropTypes.number,
  z: PropTypes.number,
});

export const NodeProps = {
  position: Vector3Type,
  rotation: Vector3Type,
  scale: PropTypes.oneOfType([Vector3Type, PropTypes.number]),
};

export const NodeDefaults = {
  position: Vector3Zero,
  rotation: Vector3Zero,
  scale: { x: 1, y: 1, z: 1 },
};

export const PointableProps = {
  onPointerEnter: PropTypes.func,
  onPointerLeave: PropTypes.func,
  onPointerHold: PropTypes.func,
};

export const ShapeProps = {
  ...PointableProps,
  color: ColorPropType,
  textureSrc: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
  cullMode: PropTypes.oneOf(['front', 'back']),
  isDoubleSided: PropTypes.bool,
};
