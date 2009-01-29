// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

GameRating = jQuery.klass({
	initialize: function() {
		this.bar = jQuery(".userrating", this.element);
		this.rating = this.bar.width();
		var game_container = this.element.parents(".game");
		this.game_url = jQuery("h2 a", game_container).attr("href");
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
		jQuery.ajax({
			url: this.game_url + "/rating",
			data: {
				_method: "put",
				rating: width / 18.0,
			},
			dataType: "script"
		})
	}
});

ExternalLink = jQuery.klass({
	initialize: function() {
		this.element.attr("target", "_blank");
	}
});

FlashMessage = jQuery.klass({
	initialize: function() {
		this.element.highlight(500);
//		this.element.blindUp(500);
//		this.element.queue(function () {
//        $(this).remove();
//        $(this).dequeue();
//    });
	}
});

GameTabLink = jQuery.klass(Remote.Link, {
	initialize: function($super) {
		this.menu = this.element.parents("ul");
		var game_container = this.element.parents(".game");
		this.content_box = jQuery(".tab_contents", game_container);
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
		jQuery("a.game_tab", this.menu).removeClass("active");
		if (this.content_box.css("display") != "none") {
			this.content_box.blindUp(500);
		}
	},
	success: function(data) {
		this.content_box.queue(function () {
        jQuery(this).html(data);
        jQuery(this).dequeue();
    });
		this.content_box.blindDown(500);
	}
});

ExpandCommentBox = jQuery.klass({
	initialize: function() {
		this.container = this.element.parents("li");
	},
	onfocus: function(event) {
		this.container.addClass("expanded");
		jQuery("textarea", this.container).css("height", "auto").attr("rows", 3);
	},
});

DisableSubmit = jQuery.klass({
	initialize: function() {
		this.container = this.element.parents("li");
	},
	onkeyup: function(event) {
		var value = this.element.val();
		jQuery("input[type=\"submit\"]", this.container).attr("disabled", (value.length > 3) ? "" : "disabled");
	}
})

NavigationBarLink = jQuery.klass({
	initialize : function() {},
	onclick: function() {
		id = this.element.attr('id').substring(5);
		if(jQuery('#able_'+id.substring(0,id.length-7)).hasClass('active')) {
			bars = jQuery(".navbar").hide();
			bar = jQuery("#"+id);
			pos = this.element.position();
			bar.css('top', pos.top+bar.height());
			bar.css('left', pos.left);
			bar.show();
		} else
			jQuery("#open_"+id).click();
		return false;
	}
});

NavigationBar = jQuery.klass({
	initialize: function() {
		this.element.hide();
		this.element.css('position', 'absolute');
	},
});

SearchBox = jQuery.klass({
	initialize: function() {
		this.helptext = "Zoeken..."
		this.time_reference = null;
		this.onblur();
	},
	onfocus: function() {
		if (this.element.hasClass("empty")) {
			this.element.val("");
			this.element.removeClass("empty");
		} 
	},
	onblur: function() {
		if ((this.element.val() == "") || (this.element.val() == this.helptext)) {
			this.element.val(this.helptext);
			this.element.addClass("empty");
		} 
	},
	onkeyup: function() {
		var minsize = 3
		if (this.time_reference != null) {
			clearTimeout(this.time_reference)
		}
		var q = this.element.val();
		if (q.length == 0) {
			jQuery("#search_result").html("");
		} else
		if (q.length < minsize) {
			jQuery("#search_result").html("<div class=\"results\"><p>Zoekopdracht moet uit minstens "+minsize+" karakters bestaan</p></div>");
  	} else {
			jQuery("#search_result").html("<div class=\"results\"><p>Bezig met zoeken...</p></div>");
			this.time_reference = setTimeout(function() {
				var box = jQuery("#search input") 
				var q = box.val();
		  	box.addClass("searching");
		  	jQuery.post("/search", {
		  		q: q
		  	}, null, "script");
			}, 1000);
		}
	}
});

jQuery(document).ready(function($) {
	$('#search input').attach(SearchBox)
	$('a[rel*=remote]').attach(Remote.Link, { dataType: "script" } );
  $('a[rel*=facebox]').facebox();
	// Add facebox-support for will-paginate links created as a facebox-navigation
	$('#facebox .pagination a').attach(Remote.Link, { dataType: "script" } );

	$('a[rel*=navbar]').attach(NavigationBarLink);
	$('div .navbar').attach(NavigationBar);

	$(".shoutbox .comment textarea").attach(DisableSubmit);
	$(".shoutbox .new_comment textarea").attach(DisableSubmit);
	$(".shoutbox .new_comment textarea").attach(ExpandCommentBox);
	$(".userrating.box.editable").attach(GameRating);
	$("a.external").attach(ExternalLink);
	$(".flash").attach(FlashMessage);
	$("a.game_tab").attach(GameTabLink);

})
