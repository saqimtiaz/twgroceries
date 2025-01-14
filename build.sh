#!/bin/sh

#install tiddlywiki
npm install tiddlywiki

#clean up any remnants from last build
rm -fr wiki
rm -fr static

#unpack single file wiki into wiki folder
node node_modules/tiddlywiki/tiddlywiki.js --load twgroceries.html --savewikifolder ./wiki

#render each non-system tiddler as a static HTML file
node node_modules/tiddlywiki/tiddlywiki.js ./wiki --output ./ --render '[!is[system]]' '[encodeuricomponent[]addprefix[static/]addsuffix[.html]]'  'text/plain' '$:/core/templates/static.tiddler.html'

#render the css as an external file
node node_modules/tiddlywiki/tiddlywiki.js ./wiki --output ./ --render '$:/core/templates/static.template.css' 'static/static.css'  'text/plain'

#render the index page
node node_modules/tiddlywiki/tiddlywiki.js ./wiki --output ./ --render '$:/core/templates/static.template.html' 'static/index.html' 'text/plain'

#remove the wiki folder
rm -fr wiki

#uncomment below lines to copy static files to root directory of repo, warning if a tiddler has the same name as the wiki file it will be overwritten
#cp -a static/. .
#rm -fr static