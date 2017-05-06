$('.thumbnail-candidate-img').on('click', function(){
    $('.thumbnail-id').val($(this).attr('id'))
    $('.thumbnail-img').attr('src', $(this).attr('src'))
})

$('.open-thumbnail-candidate').on('click', function(){
   $('.thumbnail-candidate-panel').slideToggle()
})
