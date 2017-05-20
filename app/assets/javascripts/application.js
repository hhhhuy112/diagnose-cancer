// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require jquery-1.11.1.min
//= require modernizr-2.7.1-respond-1.4.2.min
//= require app
//= require bootstrap.min
//= require highcharts
//= require chartkick
//= require portfolio
//= require plugins
//= require bootstrap-datepicker
//= require register
//= require groups.js
//= require search.js
//= require ckeditor/init
//= ckeditor_custom.js


$(document).ready(function(){
    $('.avatar-register').change(function(){
      readURL(this);
    });

    $('#flash-message').delay(2000).slideUp(500, function() {
      $(this).remove();
    });
});

$(document).on('click', '.create_rule', function (event){
  $(".loader").show();
});

$(document).on('click', '.show_loader', function (event){
  $(".loader").show();
});

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('.image-register').attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
}

//active-sidebar

$('.sidebar-nav').ready(function () {
    $('a[href="' + this.location.pathname + '"]').addClass('active');
    $('a[href="' + this.location.pathname + '"]').parent().parent().parent().addClass('active');
});
