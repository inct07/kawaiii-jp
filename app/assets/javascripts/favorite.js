$('.favorite-button').on('click', function(){
    favorite($(this).val(),$(this))
})

function favorite(id, button) {
    if (button.hasClass('favorite')){
        $.ajax({url: '/favorite', type: 'POST', data: {_method: 'delete', authenticity_token: $('#authenticity_token').val(), image_id: id}})
            .done(function(data){
                button.removeClass('favorite').addClass('no-favorite')
                button.removeClass('btn-danger').addClass('btn-default')
            })
    }else{
        $.ajax({url: '/favorite', type: 'POST', data: {_method: 'post', authenticity_token: $('#authenticity_token').val(), image_id: id}})
            .done(function(data){
                button.removeClass('no-favorite').addClass('favorite')
                button.removeClass('btn-default').addClass('btn-danger')
            })
    }
}
