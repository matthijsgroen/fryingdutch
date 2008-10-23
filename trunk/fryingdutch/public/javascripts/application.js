// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

GameRating = $.klass({
	initialize: function() {
	},
	onclick: function(event) {
		this.element.html("");
	}	
	
});

ExternalLink = $.klass({
	initialize: function() {
		this.element.attr("target", "_blank");
	}
})

$(function() {

	$(".gamerating").attach(GameRating)
	$("a.external").attach(ExternalLink)
	
});
