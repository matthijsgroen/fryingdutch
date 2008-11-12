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
		this.bar.addClass("setting");
		var offset = this.element.offset();
		var width = event.pageX - offset.left;
		this.set_width(width);
	},
	onmouseleave: function(event) {
		this.bar.removeClass("setting");		
		this.set_width(this.rating);
	},
	set_width: function(width) {
		var rounded_width = Math.round(width / 9.0) * 9;
		this.bar.css("width", rounded_width);
		var amount_stars = Math.floor(rounded_width / 18.0);
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
				rating: width / 18.0,
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
//		this.element.blindUp(500);
//		this.element.queue(function () {
//        $(this).remove();
//        $(this).dequeue();
//    });
	}
});

GameTabLink = $.klass(Remote.Link, {
	initialize: function($super) {
		this.menu = this.element.parents("ul");
		var game_container = this.element.parents(".game");
		this.content_box = $(".tab_contents", game_container);
		$super({ dataType: "script" });
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
		this.content_box.queue(function () {
        $(this).html(data);
        $(this).dequeue();
    });
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
});

DisableSubmit = $.klass({
	initialize: function() {
		this.container = this.element.parents("li");
	},
	onkeyup: function(event) {
		var value = this.element.val();
		$("input[type=\"submit\"]", this.container).attr("disabled", (value.length > 3) ? "" : "disabled");
	}
})

jQuery(document).ready(function($) {
	$('a[rel*=remote]').attach(Remote.Link, { dataType: "script" } );
  $('a[rel*=facebox]').facebox();
	// Add facebox-support for will-paginate links created as a facebox-navigation
	//$('#facebox .footer .navigation a[rel*=next][rel*=prev][rel*=start]').facebox();
	//$('a[rel*=next]').attach(Remote.Link, { dataType: "script" } );

	$(document).bind('beforeReveal.facebox', function() { $('#facebox .pagination a[@rel*=next], #facebox .pagination a[@rel*=prev], #facebox .pagination a[@rel*=start]').attach(Remote.Link, { dataType: "script" } ); })

	$(".shoutbox .comment textarea").attach(DisableSubmit);
	$(".shoutbox .new_comment textarea").attach(DisableSubmit);
	$(".shoutbox .new_comment textarea").attach(ExpandCommentBox);
	$(".userrating.box.editable").attach(GameRating);
	$("a.external").attach(ExternalLink);
	$(".flash").attach(FlashMessage);
	$("a.game_tab").attach(GameTabLink);
})
