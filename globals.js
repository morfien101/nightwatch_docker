var fs = require('fs')
var chromedriver = require('chromedriver');
if (process.env.VIDEO_ENABLED == "TRUE") {
  var video_enabled = true
} else {
  var video_enabled = false
}
//var video = require('nightwatch-video-recorder');

var globals = {
  before : function(done) {
    chromedriver.start();
    console.log("Starting Chrome Browser Driver");
    done();
  },
  beforeEach: function (browser, done) {
    if (video_enabled) {
      console.log("Starting Video");
      video.start(browser, done);
    } else {
      done();
    }
  },
  afterEach: function (browser, done) {
    if (video_enabled) {
      console.log("Stopping Video");
      video.stop(browser, done);
    } else {
      done();
    }
  },
  after : function(done) {
    chromedriver.stop();
    done();
  }
};  

if (fs.existsSync('./customGlobals.js')) {
  var customGlobals = require('./customGlobals.js')
  globals = Object.assign({}, globals, customGlobals)
}

module.exports = globals
