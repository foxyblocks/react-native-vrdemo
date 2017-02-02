import React from 'react';
import { Plane } from '../vr';

export default function MotivationPoster() {
  return (
    <Plane
      textureSrc="http://political-merch.com/wp-content/uploads/2016/04/Bernie-Sanders-presidential-seal.jpg"
      width={1}
      height={1}
      position={{ z: -2, x: 1.5 }}
      rotation={{ y: -45 }}
    />
  );
}
