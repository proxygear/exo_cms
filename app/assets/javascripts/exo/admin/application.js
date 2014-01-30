// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require exo/admin/epiceditor
//= require_self

$(document).ready(function(){
  $('input#item_published').change(function(){
    $('#publish_date_picker').toggle();
  });

  $('.toggle-sidenav').click(function (e){
    e.preventDefault();
    var wrapper = $('#wrapper');
    if (wrapper.hasClass('sidenav-visible')){
      wrapper.removeClass('sidenav-visible');
      $(this).find('i').addClass('disabled');
    }
    else{
      wrapper.addClass('sidenav-visible');
      $(this).find('i').removeClass('disabled')
    }
  });

  var opts = {
    basePath: '/assets/admin/epiceditor',
    theme: {
      base: '/epiceditor.css',
      editor: '/epic-light.css',
      preview: '/github.css'
    }
  };
  var el = document.getElementsByClassName('epiceditor');
  for (var i = 0; i < el.length; i++) {
    opts.container = el[i];
    var editor = new EpicEditor(opts).load();
  }
});

var saveAllCkeditables = function(e) {
  e.preventDefault();
  var path = $('iframe#preview').attr('src').split('?')[0];
  var blocks = {};
  $('iframe#preview').contents().find('._block').each(function (){
    blocks[$(this).attr('id')] = this.innerHTML;
  });
  $('#editor_header .success.button').addClass('disabled');
  $.ajax({
    type: "PUT",
    url:  '/admin/pages/blocks/',
    data: {
      route_path: path,
      blocks: blocks,
      dataType: 'txt/json'
    }
  })
  .fail(function(){
    alert('Sorry, something went wrong ...');
  })
  .success(function(){ window.location.replace('/admin/routes');
  })
  .always(function(){
    $('#editor_header .success.button').removeClass('disabled');
  });
};

