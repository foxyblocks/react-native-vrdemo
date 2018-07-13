import resolveAssetSrc from 'react-native/Libraries/Image/resolveAssetSource';

export const resolveAsset = asset =>
  typeof asset === 'number' ? resolveAssetSrc(asset).uri : asset;

export const convertScale = value =>
  typeof value === 'number' ? { x: value, y: value, z: value } : value;
