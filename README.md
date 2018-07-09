# Virtual Reality and React native

![](https://file-hwrgyflure.now.sh)

This is an experimental project that wraps native 3D APIs with react native components to build mobile VR experiences for react native. It is intended to run on an iPhone with a head mounted case such as [Google Cardboard](https://vr.google.com/cardboard/)

- Currently iOS only (depends on the [SceneKit](https://developer.apple.com/reference/scenekit) framework)

**NOTE** This project is incomplete, and [highly experimental](https://media.giphy.com/media/xDQ3Oql1BN54c/giphy.gif).

## Running the project

1.  clone the project

2.  install dependencies `npm install`
3.  Open `ios/VRDemo.xcodeproj` in xcode and run on either simulator or device.

The simulator allows you to mouse drag on the view to simulate head movement.

## Components

## `<VRView>`

The root view of a VR scene. All other components should be nested inside the VR view. This view can be positioned with flexbox like any other react native view.

### Properties

#### `pointer : boolean`

Whether or not to show the interactivity pointer. Default is false.

#### `devBar : boolean`

Whether or not to show the developer bar at the bottom of the VR view.
Currently this only has a single button which will allow you to turn on the camera of the
iOS device so you can see the real world while in VR. (currently only works with a real device
not the simulator)

![](https://file-tiqxgiegnu.now.sh/)

## `<Group>`

Groups a set of components and controls their positioning, rotation, and scale

### Properties

#### `position : object{x : number, y : number, z: number}`

Position of the group in 3D space. Any axis can be left out and will be defaulted to 0.
Example:

```javascript
<Group position={{x: 1}} />`

<Group position={{x: 1, y: 1, z: -1}} />
```

#### `rotation : object{x : number, y : number, z: number}`

Rotation of the group around the x, y and z axes. Values should be specified as a number in degrees. Any axis can be left out and will be defaulted to 0.
Example:

```javascript
<Group rotation={{ x: 180 }} />

<Group rotation={{ y: -180, z: 45 }} />
```

#### `scale : object{x : number, y : number, z: number} | number`

Scale of the group in each of the x, y and z axes. Can be an object of each axis or a number that should apply to all axes. Any axis can be left out and will be defaulted to 1.
Example:

```javascript
<Group scale={{ x: 2 }} />
// scales "2" in the x axis and "1" in the y and z axes

<Group scale={4} />
// scales the group by 4 in three axes
```

## Shapes

Shapes include all geometry and text components. Each shape has it's on specific props but they all share some set of common props.

The shape components include

- `Box`
- `Sphere`
- `Plane`
- `Floor`
- `Text`

### Properties

#### `textureSrc : string`

URL for the texture to apply to the shape

#### `cullMode : 'front' | 'back'`

Determines the cullMode for the shape texture rendering. (see [SceneKit docs](https://developer.apple.com/documentation/scenekit/scnmaterial/1462571-cullmode))

#### `isDoubleSided : boolean`

Determines if the texture for the shape should be rendered on both the front and back surfaces
of a shape, or the inside and the outside of a closed shape. (see [SceneKit docs](https://developer.apple.com/documentation/scenekit/scnmaterial/1462531-isdoublesided))

#### `color : string`

Color of the shape

#### `onPointerHold : function`

When the is enabled, and the user points at a shape, a progress bar on the pointer starts to fill. After it fills, this callback is triggered.

Shape components also accept all the properties for groups. `position`, `rotation`, and `scale`

## `<Box />`

A shape component. Accepts all the shape properties as well as

- `length: number`
- `width: number`
- `height: number`

## `<Sphere />`

A shape component. Accepts all the shape properties as well as

- `radius: number`

## `<Plane />`

A shape component that renders a 2d plane. Accepts all the shape properties as well as

- `width: number`
- `height: number`

## `<Floor />`

A shape component that renders a 2d plane that extends infinitely. Accepts all the shape properties as well as

- `reflectivity: number` between 0 and 1

## `<Text />`

A shape component that render 2d text. Accepts all the shape properties as well as

- `value: string` String for the text
- `fontSize: number` Size of the text
- `truncation: string(none|left|right|middle)`
- `alignment: string(natural|left|right|center|justified)`

# Presentation

A clip from the original demonstration at Instacart HQ. Sorry the video is not longer, this is all that survived.

[![](https://i.imgur.com/ij7I92E.jpg)](https://twitter.com/pinteration/status/827007420232708096)
