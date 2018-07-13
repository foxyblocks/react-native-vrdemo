import PropTypes from 'prop-types';
import React from 'react';
import { Sphere } from '../vr';
import { Spring } from 'react-spring/dist/native';
import { TimingAnimation, Easing } from 'react-spring/dist/addons';

export default class Planet extends React.PureComponent {
  static propTypes = {
    rpm: PropTypes.number, // revolutions per minute
    radius: PropTypes.number.isRequired,
    textureSrc: PropTypes.oneOfType([PropTypes.string, PropTypes.number]).isRequired,
  };

  static defaultProps = {
    rpm: 0.8,
  };

  state = { rotationTo: 360 };

  onRotationEnd = () => {
    this.setState({
      rotationTo: this.state.rotationTo + 360,
    });
  };

  render() {
    const { rpm, ...rest } = this.props;

    return (
      <Spring
        impl={TimingAnimation}
        config={{ duration: 60000 / this.props.rpm, easing: Easing.linear }}
        from={{ deg: 0 }}
        to={{ deg: this.state.rotationTo }}
        onRest={this.onRotationEnd}
      >
        {({ deg }) => <Sphere {...rest} rotation={{ y: deg }} />}
      </Spring>
    );
  }
}
