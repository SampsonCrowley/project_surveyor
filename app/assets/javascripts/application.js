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
//= require bootstrap
//= require html.sortable.min.js
//= require turbolinks
//= require_tree .
$(function(){
  $('.sortable > input').each(function(){
    console.log(this);
    $('.sortable').append(this);
  });
  sortable('.sortable', {
    handle: 'h5'
  });
  sortable('.sortable')[0].addEventListener('sortupdate', function(e) {
    $(e.detail.startparent).children('div').each(function(i){
      $(this).children('li').each(function(){
        $($(this).children('input')[0]).val(i + 1)
      })
    })
    $('.reorder').removeClass("hidden");
    /*

    This event is triggered when the user stopped sorting and the DOM position has changed.

    e.detail.item contains the current dragged element.
    e.detail.index contains the new index of the dragged element (considering only list items)
    e.detail.oldindex contains the old index of the dragged element (considering only list items)
    e.detail.elementIndex contains the new index of the dragged element (considering all items within sortable)
    e.detail.oldElementIndex contains the old index of the dragged element (considering all items within sortable)
    e.detail.startparent contains the element that the dragged item comes from
    e.detail.endparent contains the element that the dragged item was added to (new parent)

    */
  });
})
