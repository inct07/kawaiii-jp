jQuery(document).ready(function($) {
  var $container = $('#grid');
  var $firstElems = $('.girl-grid');
  $firstElems.css('display', 'none');
  $container.imagesLoaded(function() {
    $container.masonry({
      isAnimated: true,
      isFitWidth: true,
      isResizable: true
    });
    $firstElems.imagesLoaded(function() {
      $firstElems.css('display', 'inline');
      $container.masonry('appended', $firstElems, true);
    });
  });
  $container.infinitescroll( {
    navSelector: '.navigation',
    nextSelector: '.navigation a',
    itemSelector: '.girl-grid',
    loading: {
      msgText: '',
      finishedMsg: '',
      img: '/assets/loading.gif'
    }
  },
  function(newElements) {
    var $newElems = $(newElements);
    $newElems.css('display', 'none');
    $newElems.imagesLoaded(function() {
      $newElems.css('display', 'inline');
      $container.masonry('appended', $newElems, true);
    });
    var buttons = $('.favorite-button');
    for (var i = 0; i < buttons.length; i++) {
      buttons[i].onclick = function() { imageFavorite($(this).val(),$(this)); };
    }
  });
});
