jQuery(document).ready(function($) {
  var buttons = $('.favorite-button');
  for (var i = 0; i < buttons.length; i++) {
    buttons[i].onclick = function() { imageFavorite($(this).val(),$(this)); };
  }
});
function imageFavorite(id, button) {
  if (button.hasClass('favorite')) {
    $.ajax({url: '/image_favorite', type: 'POST', data: {_method: 'delete',
      authenticity_token: $('#authenticity_token').val(), image_id: id}})
        .done(function(data){
            button.removeClass('favorite').addClass('no-favorite')
            button.addClass('btn-default')
            button.children().removeClass('glyphicon-heart').addClass('glyphicon-heart-empty')
        })
  } else {
    $.ajax({url: '/image_favorite', type: 'POST', data: {_method: 'post',
      authenticity_token: $('#authenticity_token').val(), image_id: id}})
        .done(function(data){
            button.removeClass('no-favorite').addClass('favorite')
            button.removeClass('btn-default')
            button.children().removeClass('glyphicon-heart-empty').addClass('glyphicon-heart')
        })
  }
}
