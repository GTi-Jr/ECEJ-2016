// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
//= require plugins/formatter/jquery.formatter.min.js
//= require plugins/jquery-validation/jquery.validate.min.js
//= require plugins/jquery-validation/additional-methods.min.js
jQuery(function($){
  $('#phone').formatter({
            'pattern': '({{99}}) {{9}} {{9999}}-{{9999}}',
  });
});
