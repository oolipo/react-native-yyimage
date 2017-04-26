'use strict';

import React, {Component, PropTypes} from "react";
import {requireNativeComponent, NativeModules} from "react-native"
import resolveAssetSource from "react-native/Libraries/Image/resolveAssetSource";
const RNYYImageManager = NativeModules.RNYYImageManager;

const {
	ScaleToFill,
	ScaleAspectFit,
	ScaleAspectFill
} = NativeModules.RNYYImageManager;

const MODES = {
	"stretch": ScaleToFill,
	"contain": ScaleAspectFit,
	"cover": ScaleAspectFill
};

class YYImage extends Component {
	static propTypes = {
		contentMode: PropTypes.number,
		source: PropTypes.oneOfType([
			PropTypes.shape({
				uri: PropTypes.string,
				width: PropTypes.number,
				height: PropTypes.number,
				scale: PropTypes.number
			}),
			PropTypes.number,
		]),
		src: PropTypes.string,
		resizeMode: PropTypes.string,
		onLoadEnd: PropTypes.func
	};

	static defaultProps = {
		resizeMode: "contain"
	};

	render() {
		const contentMode = MODES[this.props.resizeMode];
		const source = resolveAssetSource(this.props.source) || {uri: undefined, width: undefined, height: undefined};
		const src = source.uri;
		return (
			<RNYYImage {...this.props} src={src} contentMode={contentMode}/>
		);
	}

	/**
	 * Get size of the image.
	 * Supports gifs, jpg, png, webp etc.
	 *
	 * @param uri uri to resource, remote or local.
	 * @param success success callback.
	 * @param failure failure callback.
	 */
	static getSize(uri, success: (width, height) => void, failure: (error) => void) {
		RNYYImageManager.getSize(uri, success, failure);
	}
}

const RNYYImage = requireNativeComponent("RNYYImage", YYImage);
export default YYImage;