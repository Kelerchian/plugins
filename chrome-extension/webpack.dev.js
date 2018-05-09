const merge = require('webpack-merge');
const webpack = require('webpack');
const {
    bgConfig, unMangledConfig, pluginsConfig,
} = require('./webpack.common.js');


let featureFlags = {
	DEBUG: JSON.stringify(true),
	// for manually forcing speech
	INCLUDE_SPEECH_TEST_HARNESS: JSON.stringify(true),
    CLEAR_SETTINGS: JSON.stringify(true),
    SKIP_TUTORIAL: JSON.stringify(true),
	AUTO_ON: JSON.stringify(false),
	PRETEND_FIRST_INSTALL: JSON.stringify(true),
};


let devCommon = {
    plugins: [
		new webpack.DefinePlugin(featureFlags),
		//new WebpackShellPlugin({onBuildEnd:['tests/plugins/test-plugins.sh']}),
    ]
};

module.exports = [
    merge(bgConfig, devCommon, {

    }),
    merge(unMangledConfig, devCommon, {

    }),
    pluginsConfig, 
];