$(document).ready(function(){
  $('#update-password-button').click(function(){
    updatePassword();
  });
})

function updatePassword(){
  newPass = $('#new-pass').val();
  comfirmPass = $('#comfirm-pass').val();
  currentPass = $('#current-pass').val();
  idUser = $('.user-id').val();
  url = "/admin/users/"+ idUser
  $.ajax({
    url: url,
    type: 'PATCH',
    data: {password: newPass, comfirm_pass: comfirmPass , current_pass: currentPass, type: 'updatepass'},
    dataType: 'json'
  }).done(function(data) {
    if(data.status === "0"){
      flash = "update fail";
      $.growl.error({ message: flash});
    }else{
      flash = "update success";
      $.growl.error({ message: flash});
    }
  });
}
