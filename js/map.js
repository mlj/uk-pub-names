var dispatch = d3.dispatch("ready");
var projection, svg, updateData;

(function() {

var width = 960,
    height = 1160;

projection = d3.geo.albers()
    .center([0, 55.4])
    .rotate([4.4, 0])
    .parallels([50, 60])
    .scale(6000)
    .translate([width / 2, height / 2]);

var path = d3.geo.path()
    .projection(projection)
    .pointRadius(2);

svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height);

dispatch.on("ready.0", function(uk) {
  var subunit = svg.selectAll(".subunit")
      .data(topojson.feature(uk, uk.objects.subunits).features)
    .enter().append("g")
      .attr("class", function(d) { return "subunit " + d.id; });

  subunit.append("path")
      .attr("d", path);

  subunit.append("text")
      .attr("transform", function(d) { return "translate(" + path.centroid(d) + ")"; })
      .attr("dy", ".35em")
      .text(function(d) { return d.properties.name; });

  svg.append("path")
      .datum(topojson.mesh(uk, uk.objects.subunits, function(a, b) { return a !== b && a.id !== "IRL"; }))
      .attr("d", path)
      .attr("class", "subunit-boundary");

  svg.append("path")
      .datum(topojson.mesh(uk, uk.objects.subunits, function(a, b) { return a === b && a.id === "IRL"; }))
      .attr("d", path)
      .attr("class", "subunit-boundary IRL");

  svg.append("path")
      .datum(topojson.feature(uk, uk.objects.places))
      .attr("d", path)
      .attr("class", "place");

  svg.selectAll(".place-label")
      .data(topojson.feature(uk, uk.objects.places).features)
    .enter().append("text")
      .attr("class", "place-label")
      .attr("transform", function(d) { return "translate(" + projection(d.geometry.coordinates) + ")"; })
      .attr("x", function(d) { return d.geometry.coordinates[0] > -1 ? 6 : -6; })
      .attr("dy", ".35em")
      .style("text-anchor", function(d) { return d.geometry.coordinates[0] > -1 ? "start" : "end"; })
      .text(function(d) { return d.properties.name; });

  //updateData(".json");
});

})();

updateData = function(file) {
    d3.json(file, function(error, pubs) {
      if (error) return console.warn(error);
        var u = svg.selectAll(".pub")
            .data(pubs);

        u.enter().append("circle")
          .attr("class", "pub")
          .attr("cx", function(d) {
            return projection(d.coordinates)[0];
          })
          .attr("cy", function(d) {
            return projection(d.coordinates)[1];
          })
          .attr("r", 5)
          .style("fill", "green");

        u.attr("cx", function(d) {
            return projection(d.coordinates)[0];
          })
          .attr("cy", function(d) {
            return projection(d.coordinates)[1];
          });

        u.exit()
          .remove();

        var t = svg.selectAll(".pub-label")
            .data(pubs);

        t.enter().append("text")
          .attr("class", "pub-label")
          .attr("transform", function(d) { return "translate(" + projection(d.coordinates) + ")"; })
          .attr("x", function(d) { return d.coordinates[0] > -1 ? 6 : -6; })
          .attr("dy", ".35em")
          .style("text-anchor", function(d) { return d.coordinates[0] > -1 ? "start" : "end"; })
          .text(function(d) { return d.name; });

        t.attr("transform", function(d) { return "translate(" + projection(d.coordinates) + ")"; })
         .text(function(d) { return d.name; });

        t.exit()
          .remove();
    });
  };
