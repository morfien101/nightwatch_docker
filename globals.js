var chromedriver = require('chromedriver');
//var video = require('nightwatch-video-recorder');

module.exports = {
  before : function(done) {
    chromedriver.start();
    console.log("Starting");
    done();
  },
  beforeEach: function (browser, done) {
    video.start(browser, done);
  },
  afterEach: function (browser, done) {
    video.stop(browser, done);
  },
  after : function(done) {
    chromedriver.stop();
    done();
  }
};  
