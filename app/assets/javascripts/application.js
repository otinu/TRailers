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

/*================= 投稿詳細 ================= */

$(document).on('turbolinks:load',function(){
  $(".enlarge-it").on("click", function(event) {
    $(this).toggleClass("active");
    $("#enlarge").fadeToggle(500);
    event.preventDefault();
  });
});

    window.addEventListener('DOMContentLoaded', function() {
    document.getElementById('enlarge-touch').addEventListener('touchstart', function() {
      this.animate(
        {
          transform: [
            'scale(1)',
            'scale(5)'
          ]
        },
        {
          duration: 1000,
          fill: 'forwards',
          easing: 'ease'
        }
      );
    });
    document.getElementById('enlarge-touch').addEventListener('touchend', function() {
      this.animate(
        {
          transform: [
            'scale(5)',
            'scale(1)'
          ]
        },
        {
          duration: 1000,
          fill: 'forwards',
          easing: 'ease'
        }
      );
    });
  });





  window.addEventListener('DOMContentLoaded', function() {
    document.getElementById('enlarge').addEventListener('touchstart', function() {
      const image = document.getElementById('enlarge-touch');
      let touchObject = event.changedTouches[0];
      let x = touchObject.clientX;
  	  let y = touchObject.clientY;
      image.style.marginTop = y + "px";
      image.style.marginLeft = x + "px";
      image.style.marginRight = 0;
      image.style.marginBottom = 0;
    });
  });

  window.addEventListener('DOMContentLoaded', function() {
    document.getElementById('enlarge').addEventListener('click', function(event) {
      const image = document.getElementById('enlarge-touch');
      image.style.marginTop = event.clientY + "px";
      image.style.marginLeft = event.clientX + "px";
      image.style.marginRight = 0;
      image.style.marginBottom = 0;
    });
  });










/*============== ユーザー詳細ページ ============= */

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