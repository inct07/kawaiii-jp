jQuery(document).ready(function($) {
  var $container = $('#grid');
  $container.imagesLoaded(function() {
    $container.masonry({
      isAnimated: true,
      isFitWidth: true,
      isResizable: true
    });
  });
  $container.infinitescroll( {
    navSelector: '.navigation',
    nextSelector: '.navigation a',
    itemSelector: '.col-xs-12.col-md-6.col-lg-3',
    loading: {
      finishedMsg: 'All Loaded',
      img: '/loading.gif'
    }
  },
  function(newElements) {
    var $newElems = $(newElements);
    $newElems.imagesLoaded(function() {
      $container.masonry('appended', $newElems, true);
    });
    var buttons = $('.favorite-button');
    for (var i = 0; i < buttons.length; i++) {
      buttons[i].onclick = function() { imageFavorite($(this).val(),$(this)); };
    }
  });
});
