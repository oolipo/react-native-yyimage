# react-native-yyimage
YYImage for React Native

This is react native port of [YYImage](https://github.com/ibireme/YYImage) library.

Hints you wanna know:
* use _Pods_ for [YYImage](https://github.com/ibireme/YYImage) dependency
* lib returns the image size on `onLoadEnd`
* port was written to match [FLAnimatedImage](https://github.com/nihgwu/react-native-flanimatedimage) implementation (it doesn't contain `onFrameChange` method ) 

## Install

**You have to install [YYImage](https://github.com/ibireme/YYImage) first** via _Pods_

```shell
npm install react-native-yyimage --save
```

## Link

In XCode, in the project navigator:
- Right click _Libraries_
- Add Files to _[your project's name]_
- Go to `node_modules/react-native-yyimage/RNYYImage`
- Add the `.xcodeproj` file

In XCode, in the project navigator, select your project.
- Add the `libRNYYImage.a` from the _deviceinfo_ project to your project's _Build Phases ➜ Link Binary With Libraries_

## Usage

```js
import YYImage from "react-native-yyimage";

...
  onLoadEnd = (e) => {
    if (!e.nativeEvent.size) return;
    const { width, height } = e.nativeEvent.size;
    this.setState({
      width,
      height,
    });
  }
...
  const style = {width: this.state.width, height: this.state.height};
  return <YYImage source={{uri:this.props.url}}
				style={style}
				resizeMode='contain'
				onLoadEnd={(event) => this.onLoadEnd(event)}/>;
...
```

# Changelog

## Version 0.1.4
- Add method to get size of image (jpg, png, gif, webp - for webp need to install WebP framework from native YYImage)