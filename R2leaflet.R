##################################################
#  R2leaflet                                     #
#  Some R functions to take location data and    #
#  produce a JavaScript interactive map          #
#                                                #
#  Version 0.1: produces only simple markers     #
#               and pop-up labels on OSM tiles   #
#                                                #
#  See also: leafletjs.com                       #
#  github.com/shramov/leaflet-plugins            #
#  robertgrantstats.wordpress.com                #
#  robert.grant@sgul.kingston.ac.uk              #
##################################################

double.escape<-function(textvector) {
	text.out<-gsub('"','\"',textvector)
	text.out<-gsub("'","\\\\'",text.out)
	text.out<-paste("\'",text.out,"\'",sep="")
	return(text.out)
}


R2leaflet<-function(lat,long,label,
                    map.height=480,
                    map.lat=53.16,
                    map.long=-1.27,
                    map.zoom=6,
			  map.source="OSM",
                    filename="mymap.html",
			  leafletcss="http://cdn.leafletjs.com/leaflet-0.5/leaflet.css",
                    leafletjs="http://cdn.leafletjs.com/leaflet-0.5/leaflet.js",
			  lgooglejs="https://raw.github.com/shramov/leaflet-plugins/master/layer/tile/Google.js",
                    mgooglejs="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false",
			  popup=TRUE) {
	# ifelse later requires popup to be a vector but we do not know length(label) until now
	if (popup==TRUE & length(label)>1) { 
		popup<-rep(TRUE,length(label))
	}
	head.open<-"<head>"
	head.comment<-"<!-- The links in the header bring in the leaflet styles from CSS and the JavaScript program behind it all. -->"
	head.css<-paste("<link rel=\"stylesheet\" href=\"",leafletcss,"\" />",sep="")
	head.js1<-paste("<script src=\"",leafletjs,"\"></script>",sep="")
	head.js2<-paste("<script src=\"",lgooglejs,"\"></script>",sep="")
	if (map.source=="Google") {
		head.js3<-paste("<script src=\"",mgooglejs,"\"></script>",sep="")
	} else {
		head.js3<-" "
	}
	head.close<-"</head>"
	
	body.open<-"<body>"
	body.comment1<-"<!-- First we create a div (section of the page) called map -->"
	div.open<-paste("<div id=\"map\" style=\"height:",
	                map.height,
	                "px;\"><script type=\"text/javascript\">", sep="")
	body.comment2<-"<!-- Then we get into the JavaScript, using the leaflet function L.map to set the center and zooming -->"
	div.view<-paste("var map = L.map(\'map\').setView([",
	                map.lat,
	                ",",
	                map.long,
	                "], 6);", sep="")
	body.comment3<-"<!-- The images are obtained online using L.tileLayer... -->"
	if (map.source=="OSM") {
		div.tile<-"L.tileLayer(\'http://{s}.tile.osm.org/{z}/{x}/{y}.png\', { attribution: \'&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors\' }).addTo(map);"
	} else {
		div.tile<-c("var osm = new L.TileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png');",
				"var ggl = new L.Google();",
				"map.addLayer(ggl);",
				"map.addControl(new L.Control.Layers( {'OSM':osm, 'Google':ggl}, {}));")
	}
	bindpopup<-ifelse(popup,paste(".bindPopup(",double.escape(label),")",sep=""),rep(" ",length(label)))
	body.comment4<-"<!-- ...and then markers are added using L.marker, with pop-up captions using .bindPopup -->"
	div.mark<-paste("L.marker([",
	                lat,
	                ",",
	                long,
	                "]).addTo(map)",
			    bindpopup,
	                ";", sep="")
	# NB div.mark is a vector. If lat, long and label are different lengths, it will recycle them with surprising results!
	body.comment5<-"<!-- Finally, the tags for JavaScript, the map div, and the body of the webpage are closed off -->"
	div.end<-"</script></div>"
	body.close<-"</body>"
	
	leaflet.text<-c(head.open,head.comment,head.css,head.js1,head.js2,head.js3,head.close,
                      body.open,body.comment1,div.open,body.comment2,
			    div.view,body.comment3,div.tile,body.comment4,
			    div.mark,body.comment5,div.end,body.close)
	conn<-file(filename)
	writeLines(leaflet.text,conn)
	close(conn)
}

