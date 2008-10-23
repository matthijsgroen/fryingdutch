// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

GameRating = $.klass({
	initialize: function() {
	},
	onclick: function(event) {
		this.element.html("");
	}	
	
});


$(function() {

	$(".gamerating").attach(GameRating)
	
});
