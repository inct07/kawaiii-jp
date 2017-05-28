$('.thumbnail-candidate-img').on('click', function(){
    $('#thumbnail-id').val($(this).attr('id'))
    $('.thumbnail-img').attr('style', $(this).attr('style'))
})

$('#open-thumbnail-candidate').on('click', function(){
   $('.thumbnail-candidate-panel').slideToggle()
})
