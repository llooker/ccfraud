var width = 135,
    height = 135,
    twoPi = 2 * Math.PI,
    progress = 0,
    allocated = 2000000,
    total = 4300000,
    formatPercent = d3.format(".0%");

var arc = d3.svg.arc()
    .startAngle(0)
    .innerRadius(52)
    .outerRadius(66);

var svg = d3.select("#docsChart").append("svg")
    .attr("width", width)
    .attr("height", height)
  .append("g")
    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

var meter = svg.append("g")
    .attr("class", "funds-allocated-meter");

meter.append("path")
    .attr("class", "background")
    .attr("d", arc.endAngle(twoPi));

var foreground = meter.append("path")
    .attr("class", "foreground");

var percentComplete = meter.append("text")
    .attr("text-anchor", "middle")
    .attr("class", "percent-complete")
    .attr("dy", "0em");

var description = meter.append("text")
    .attr("text-anchor", "middle")
    .attr("class", "description")
    .attr("dy", "2.3em")
    .text("Total Complete");

var i = d3.interpolate(progress, allocated / total);

 d3.transition().duration(1000).tween("progress", function() {
  return function(t) {
    progress = i(t);
    foreground.attr("d", arc.endAngle(twoPi *-progress));
    percentComplete.text(formatPercent(progress));
  };
});