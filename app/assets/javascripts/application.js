// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require bootstrap-sprockets

$(document).ready(function() {
	var $win = $(window),
	    $header = $('.header'),
      $navbar = $('.navbar'),
	    headerHeight = $header.outerHeight(),
      navbarHeight = $navbar.outerHeight(),
	    startPos = 0;
	$win.on('load scroll', function() {
		var value = $(this).scrollTop();
		if ( value > startPos && value > navbarHeight) {
			$header.css('top', '-' + headerHeight + 'px');
      $navbar.css('top', '-' + navbarHeight + 'px');
		} else {
			$header.css('top', '0');
      $navbar.css('top', headerHeight + 'px');
		}
    startPos = value;
	});
});
