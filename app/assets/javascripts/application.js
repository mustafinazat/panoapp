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
//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap



$(function() {


// $(function () {
 
//   // Search form
//   $('#virtualtours_search input').keyup(function () {
//     $.get($('#virtualtours_search').attr('action'), $('#virtualtours_search').serialize(), null, 'script');
//     return false;
//   });
// });

$(function () {
   // Search form
  $('#posts_search input').keyup(function () {
    $.get($('#posts_search').attr('action'), $('#posts_search').serialize(), null, 'script');
    return false;
  });
});




// $(document).on('click', '.pagination a', function () {
//      $.getScript(this.href);
//      return false;
//   });


  if ($('.pagination').length && $('#posts').length) {
   $(window).scroll(function() {
      const url = $('.pagination .next a').attr('href');
      if (url && ($(window).scrollTop() > ($(document).height() - $(window).height() - 50))) {
        $('.pagination').text('Загрузка постов...');
        return $.getScript(url);
      }
   });
   return $(window).scroll();
 }
});


