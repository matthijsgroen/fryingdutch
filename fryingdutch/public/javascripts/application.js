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
		for (var i = 0; i <= 5; i++) {
			this.bar.removeClass("score"+i);
		}
		this.bar.addClass("score" + amount_stars);
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

FlashMessage = $.klass({
	initialize: function() {
		this.element.highlight(500);
		this.element.blindUp(500);
		this.element.queue(function () {
        $(this).remove();
        $(this).dequeue();
    });
	}
});

GameTabLink = $.klass(Remote.Link, {
	initialize: function($super) {
		$super({ success: this.success });
		this.menu = this.element.parents("ul");
		var game_container = this.element.parents(".game");
		this.content_box = $(".tab_contents", game_container);
	},
	onclick: function($super, event) {
		if (this.element.hasClass("active")) {
			this.resetTabs();
			return false;
		}
		this.resetTabs();
		this.element.addClass("active");
		$super(event);
		return false;
	},
	resetTabs: function() {
		$("a.game_tab", this.menu).removeClass("active");
		if (this.content_box.css("display") != "none") {
			this.content_box.blindUp(500);
		}
	},
	success: function(data) {
		this.content_box.html(data)
		this.content_box.blindDown(500);
	}
});

ExpandCommentBox = $.klass({
	initialize: function() {
		this.container = this.element.parents("li");
	},
	onfocus: function(event) {
		this.container.addClass("expanded");
		$("textarea", this.container).css("height", "auto").attr("rows", 3);
	},
	onkeyup: function(event) {
		var value = this.element.val();
		$("input[type=\"submit\"]", this.container).attr("disabled", (value.length > 3) ? "" : "disabled");
	}
});

$(function() {
	$(".shoutbox .new_comment textarea").attach(ExpandCommentBox);
	$(".userrating.box.editable").attach(GameRating);
	$("a.external").attach(ExternalLink);
	$(".flash").attach(FlashMessage);
	$("a.game_tab").attach(GameTabLink);
});
