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
//= require jquery-ui
//= require turbolinks
//= require bootstrap/alert
//= require bootstrap/dropdown
//= require bootstrap/tab
//= require bootstrap/transition
//= require bootstrap/modal
//= require jquery_nested_form
//= require_tree .
//= require_self



// $(document).on('turbolinks:load', func);

// $(document).ready(function(){

//   $("#order_product_quantity").change(function() {

//     unit_price = 0;

//     if ($("#order_preference_type_LOGO__").is(":checked")) {
//       unit_price = 2000;
//     }
//     if ($("#order_preference_type_PPT____").is(":checked")) {
//       unit_price = 500;
//     }
//     if ($("#order_preference_type_Web____").is(":checked")) {
//       unit_price = 1000;
//     }
//     quantity =  parseInt($("#order_product_quantity").val());
//     $("#total_price").text(unit_price * quantity);

//   });



//   $("#order_preference_type_LOGO__").click(function() {
//     unit_price = 2000;
//     quantity =  parseInt($("#order_product_quantity").val());
//     $("#total_price").text(unit_price * quantity);
//     $("#design_type").text("LOGO商标");
//     //获得第一个radio的“单价”属性中的值
//     //获得“需要的页数”控件中“页数”的值
//     //获得“total_price”这个text element，然后改变他的text属性，计算结果 = 单价*页数
//   });

//   $('#order_preference_type_PPT____').click(function() {
//     unit_price = 500;
//     quantity =  parseInt($("#order_product_quantity").val());
//     $("#total_price").text(unit_price * quantity);
//       $("#design_type").text("PPT演示文稿");
//     //获得第二个radio的“单价”属性中的值
//     //获得“需要的页数”控件中“页数”的值
//     //获得“total_price”这个text element，然后改变他的text属性，计算结果 = 单价*页数
//   });

//   $('#order_preference_type_Web____').click(function() {
//     unit_price = 1000;
//     quantity =  parseInt($("#order_product_quantity").val());
//     $("#total_price").text(unit_price * quantity);
//       $("#design_type").text("Web页面设计");
//     //获得第三个radio的“单价”属性中的值
//     //获得“需要的页数”控件中“页数”的值
//     //获得“total_price”这个text element，然后改变他的text属性，计算结果 = 单价*页数
//   });


// });

  // simple text add to image
  // (function ( $ ) {

  //   $.TextOver = function(obj, options) {

  //     // Set options
  //       var settings = $.extend({}, options),
  //       messages = [];

  //       var text_css = {
  //         border: 'none',
  //         visibility: 'visible',
  //         margin: 0,
  //         padding: 0,
  //         position: 'absolute',
  //         top: 0,
  //         left: 0,
  //         background: '#C0CF84',
  //         color: 'black',
  //         'font-size': '18px',
  //         padding: '2px',
  //         height: '24px',
  //         width: '20px',
  //         overflow: 'hidden',
  //         outline: 'none',
  //         'box-shadow': 'none',
  //           '-moz-box-shadow': 'none',
  //           '-webkit-box-shadow': 'none',
  //           'resize': 'none'
  //       };

  //       var $img = $(obj);

  //       getPos = function(obj) {
  //         var pos = $(obj).offset();
  //         return [pos.left, pos.top];
  //       };

  //         getData = function() {
  //           removeEmpty();
  //           data = [];
  //           imgPos = getPos($img);
  //           $.each(messages, function() {
  //             pos = getPos(this);
  //             textLeft = pos[0] - imgPos[0];
  //             textTop = pos[1] - imgPos[1];
  //             data.push({ 'text': this.val(), 'left': textLeft, 'top': textTop });
  //           });
  //           return data;
  //         }

  //       mouseAbs = function(e) {
  //         return [e.pageX, e.pageY];
  //       };

  //       resizeTextArea = function(e) {
  //         var span = $('#helper');
  //         if(span.length < 1) {
  //           span = $('<span id="helper"></span>');
  //         }
  //         innerHTML = String($(this).val()).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/\n/g, '<br />') + '...';
  //         if(e.keyCode == 13) { innerHTML += '<br />...'; }
  //         span.html(innerHTML).css({
  //           'display': 'none',
  //           'word-wrap': 'break-word',
  //         'white-space': 'normal',
  //         'font-family': $(this).css('font-family'),
  //         'font-size': $(this).css('font-size'),
  //         'line-height': $(this).css('line-height'),
  //         'min-height': '24px'
  //         });
  //         $('body').append(span);
  //         $(this).css({'height': span.height()+6, 'width': span.width()+10});
  //       }

  //         newTextArea = function(e) {
  //           removeEmpty();
  //           var textArea = $('<textarea></textarea>');
  //           textArea.css(text_css);
  //           position = mouseAbs(e);
  //           textArea.css({'left': position[0], 'top': position[1]});
  //           $(this).after(textArea);
  //           $(textArea).bind('keydown', resizeTextArea);
  //           $(textArea).on('paste', function(e) {
  //             /*TODO Fix resize issue */
  //             $(this).trigger('keydown');
  //           })
  //           $(textArea).focus(function() {
  //             $(this).css('border', '1px dotted #cccccc');
  //           }).blur(function() {
  //             $(this).css('border', 'none');
  //           });
  //           textArea.focus();
  //           messages.push($(textArea));
  //         };

  //         removeTextArea = function(index) {
  //           $(messages[index]).remove();
  //           messages.splice(index, 1);
  //         };

  //         removeEmpty = function() {
  //           $.each(messages, function(i) {
  //             if($(this).val() == '') {
  //               removeTextArea(i);
  //             }
  //           });
  //         };

  //         handleEsc = function(e) {
  //           //console.log(e.keyCode);
  //           if(e.keyCode == 27) {
  //             removeTextArea(messages.length-1);
  //           }
  //         };

  //         $(obj).click(newTextArea);
  //         $(document).keydown(handleEsc);
  //   };

  //     $.fn.TextOver = function(options, callback) {

  //         api = $.TextOver(this, options);
  //         if ($.isFunction(callback)) callback.call(api);

  //         // Return "this" so the object is chainable (jQuery-style)
  //       return this;
  //     };

  // }(jQuery));


  // // simple text add to image
  // jQuery(function($){
  //     var textover_api;
  //     // How easy is this??
  //     $('#target').TextOver({}, function() {
  //       textover_api = this;
  //     });


  //     $('#show').click(function () {
  //       html = '';
  //       comments_array = [];


  //       $.each(textover_api.getData(), function() {
  //         html += 'Text &raquo; ' + this.text + ' Left &raquo; ' + this.left + ' Top &raquo; ' + this.top + '<br />';
  //         comment = {};
  //         comment.text = this.text;
  //         comment.left = this.left;
  //         comment.top = this.top;
  //         comments_array.push(comment);
  //       });

  //       // $('#data').html(html).show();
  //       // alert(html);

  //       var id = $(this).attr("number");

  //       $.ajax({
  //         url : "/account/samples/" + id,
  //         type : "put",
  //         data : { data_value: JSON.stringify(comments_array) }
  //       });
  //       return false;
  //     });
  // });
