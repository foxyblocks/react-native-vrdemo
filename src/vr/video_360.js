import React from 'react';
import PropTypes from 'prop-types';
import { requireNativeComponent } from 'react-native';

const Video360 = props => <Video360Native {...props} />;

Video360.propTypes = {
  src: PropTypes.string,
};

const Video360Native = requireNativeComponent('VRVideo360View', Video360);

export default Video360;
