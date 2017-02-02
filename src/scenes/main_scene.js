import React, { Component } from 'react';
import { VRView, Group, Sphere, Plane, Floor, Box } from '../vr';
import MotivationPoster from '../components/motivational_poster';

export default class MainScene extends Component {
  render() {
    // Textures
    const SPACE = 'http://opengameart.org/sites/default/files/styles/watermarked/public/space_lf_0.png';
    const MOON = 'https://3dexport.com/items/2015/02/20/385337/100201/moon_texture_3d_model_c4d_max_obj_fbx_ma_lwo_3ds_3dm_stl_1258985.png';
    const EARTH = 'https://img3.goodfon.ru/original/1920x1200/0/a9/zemlya-karta-oblaka.jpg';
    const MARS = 'http://maps.jpl.nasa.gov/pix/ven0ajj2.jpg';
    const CUBE = 'http://img.photobucket.com/albums/v600/Garrin/borg.jpg';
    const INVADER = 'http://orig04.deviantart.net/3f5e/f/2012/221/e/3/space_invader_by_tagahrim-d5aihgr.gif';
    const KANYE = 'http://www.pngall.com/wp-content/uploads/2016/06/Kanye-West.png';

    return (
      <VRView style={{ flex: 1 }}  bgSrc={SPACE} devBar pointer >
        <Group position={{ y: 2, z: -8 }}>
          <Group position={{ x: -3 }}>
            <Sphere
              textureSrc={EARTH}
              radius={1}
            />
            <Sphere
              textureSrc={MOON}
              radius={0.3}
              position={{ x: -3 }}
            />
          </Group>
          <Sphere
            textureSrc={MARS}
            radius={1}
            position={{ x: 3, y: 2 }}
          />
          <Plane
            width={4}
            height={4}
            color="rgba(0,0,255, 0.5)"
            position={{ z: 2, x: 3, y: 1 }}
            rotation={{ x: -45 }}
          />
          <Box
            textureSrc={CUBE}
            rotation={{ y: 45 }}
            position={{ z: 3  }}
          />
        </Group>
      </VRView>
    );
  }
}
