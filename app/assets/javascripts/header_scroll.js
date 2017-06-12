$(document).ready(function() {
  var $win = $(window);
  var $header = $('.header');
  var $navbar = $('.navbar');
  var headerHeight = $header.outerHeight();
  var navbarHeight = $navbar.outerHeight();
  var startPos = 0;
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
