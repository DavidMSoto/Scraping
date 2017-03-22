// scrape_techstars.js

var args = require('system').args;
var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');

var address = args[1];
var path = args[2];

page.open(address, function (status) {
  var content = page.content;
  fs.write( path + ".html",content,'w')
  phantom.exit();
});