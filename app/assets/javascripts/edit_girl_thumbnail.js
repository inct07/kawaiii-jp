$('.thumbnail-img.candidate').on('click', function(){
  $('.selected').removeClass('selected')
  $(this).addClass('selected')
  $('#thumbnail-id').val($(this).attr('id'))
  $('.thumbnail-img.elected').attr('style', $(this).attr('style'))
})

$('#open-thumbnail-candidate').on('click', function(){
  $('.thumbnail-candidate-panel').slideToggle()
})
