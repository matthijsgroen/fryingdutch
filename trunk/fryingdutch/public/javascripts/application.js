// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

GameRating = $.klass({
	initialize: function() {
		this.bar = $(".userrating", this.element);
		this.rating = this.bar.width();
		var game_container = this.element.parents(".game");
		this.game_url = $("h2 a", game_container).attr("href");
	},
	onmousemove: function(event) {
		var offset = this.element.offset();
		var width = event.pageX - offset.left;
		this.set_width(width);
	},
	onmouseleave: function(event) {
		this.set_width(this.rating);
	},
	set_width: function(width) {
		var rounded_width = Math.round(width / 8.0) * 8;
		this.bar.css("width", rounded_width);
		var amount_stars = Math.floor(rounded_width / 16.0);
		switch(amount_stars) {
			case 0: 
			case 1: 
			case 2: 
			case 3: 
				this.bar.removeClass("score2");
				this.bar.addClass("score1");
				break;
			case 4: 
			case 5: 
				this.bar.removeClass("score1");
				this.bar.addClass("score2");
				break;
		}
	},
	onclick: function(event) {
		var offset = this.element.offset();
		var width = event.pageX - offset.left;
		this.rating = width;
		
		this.set_width(width);
		// send message to server
		$.ajax({
			url: this.game_url + "/rating",
			data: {
				_method: "put",
				rating: width / 16.0,
			},
			dataType: "script"
		})
	}
});

ExternalLink = $.klass({
	initialize: function() {
		this.element.attr("target", "_blank");
	}
});

$(function() {
	$(".userrating.box").attach(GameRating)
	$("a.external").attach(ExternalLink)
	
});
