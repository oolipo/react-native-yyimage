'use strict';

import React, {Component} from 'react';
import {View} from 'react-native';

/**
 * YYImage doesn't support Android, so empty view is returned.
 */
class YYImage extends Component {
	render() {
		return (
			<View />
		);
	}
}
export default YYImage;