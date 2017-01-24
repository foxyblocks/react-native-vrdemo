import 'react-native';
import React from 'react';
import Index from '../index.ios';

// Note: test renderer must be required after react-native.
// eslint-disable-next-line import/first
import renderer from 'react-test-renderer';

it('renders correctly', () => {
  renderer.create(
    <Index />,
  );
});
