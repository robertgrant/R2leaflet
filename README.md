## R2leaflet

R2leaflet is a simple R function to take latitude, longitude and a few extra details, and produce an interactive online map. Interactive graphics are incredibly useful in getting people interested in your work and communicating your data effectively, but very few statisticians / data analysts have the skills needed to make them. My aim with this is firstly to encourage more data people to find out about JavaScript and teach themselves some basic skills, and secondly to give you a really easy way of making an online interactive map.

The main function is called R2leaflet because it uses the popular JavaScript package called [leaflet](http://leafletjs.com) to send the instructions for the map to the web browser of anyone looking at your site. It just takes your data and constructs a lot of text around it to form a new HTML file which contains your map. You can upload this HTML file and it will work as a webpage that contains nothing but the map, or you can add text and other content to it.

## The double.escape() function

There is a subsidiary function called double.escape because additional escaping and quoting is required for any text you want in pop-up captions to get through first R and then JavaScript unscathed.
Input text may not contain backslashes, other than as escapes.
I imagine most useRs will provide text in character objects inside double quotes, which works fine, and you can display single quotes on your leaflet map if you want, but double.escape is still not happy with double quotes inside singles... I can't be certain that it will cope with all possible character combinations but gradually it will get more robust.

## To-do list

The current version (0.1) produces only simple markers and pop-up labels on OpenStreetMap tiles. You will see I have been trying, without success, to use [shramov's Google Maps plugins](https://github.com/shramov/leaflet-plugins) to provide a Google tiles option, but Google are notoriously tricky with access to their tiles.

Beyond that, here's more arguments I want to provide in version 0.2:
*	map.width (simple but a lot of the time you just want it to fill the user's screen and switching from % to pixels is required; I just haven't got round to it yet!)
*	map.source: get Google working, Bing, maybe also satellite images (yeah right)
*	Add Boolean option to skip double.escape if text is already double.escaped
*	Allow different marker colors (leafletjs.org has jpegs for the blue marker and its shadow so I will recolor the marker and store various colors on Github.

Then for v0.3 I'll think about choropleth maps.

## Beyond leaflet

It would be cool to do some more R to JS translation functions. D3 is an obvious target-rich environment. I know [Hadley Wickham has been working on a generic R2D3 via ggplot2 approach](https://github.com/hadley/r2d3) but my aim is to get data people thinking about JavaScript and I think simple specific functions to do specific types of plot would be welcome.

I encourage anyone interested in this to join me and contribute so we can make a whole suite of simple R2JS visualization functions and get more number-crunchers making interactive outputs.
