// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


/*================= 投稿一覧 ================= */

$(document).on('turbolinks:load',function(){
  $('#arrow_top').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.isDefaultPrevented();
  });
});

/*================= ユーザー詳細ページ ================= */

$(document).on('turbolinks:load',function(){
  $('.mine-comment').hide();
  $('.mine-open').mouseover(function(){
    $('.mine-comment').css({'display': ''});
  });
  $('.mine-open').mouseout(function(){
    $('.mine-comment').css({'display': 'none'});
  });
});

$(document).on('turbolinks:load',function(){
  $('.others-comment').hide();
  $('.others-open').mouseover(function(){
    $('.others-comment').css({'display': ''});
  });
  $('.others-open').mouseout(function(){
    $('.others-comment').css({'display': 'none'});
  });
});
