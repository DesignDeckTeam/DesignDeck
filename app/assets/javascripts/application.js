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
//= require turbolinks
//= require bootstrap/alert
//= require bootstrap/dropdown
//= require bootstrap/tab
//= require bootstrap/transition
//= require jquery_nested_form
//= require_tree .
//= require_self



$(document).ready(function(){

  $("#order_product_quantity").change(function() {

    unit_price = 0;

    if ($("#order_preference_type_LOGO__").is(":checked")) {
      unit_price = 2000;
    }
    if ($("#order_preference_type_PPT____").is(":checked")) {
      unit_price = 500;
    }
    if ($("#order_preference_type_Web____").is(":checked")) {
      unit_price = 1000;
    }
    quantity =  parseInt($("#order_product_quantity").val());
    $("#total_price").text(unit_price * quantity);

  });



  $("#order_preference_type_LOGO__").click(function() {
    unit_price = 2000;
    quantity =  parseInt($("#order_product_quantity").val());
    $("#total_price").text(unit_price * quantity);
    $("#design_type").text("LOGO商标");
    //获得第一个radio的“单价”属性中的值
    //获得“需要的页数”控件中“页数”的值
    //获得“total_price”这个text element，然后改变他的text属性，计算结果 = 单价*页数
  });

  $('#order_preference_type_PPT____').click(function() {
    unit_price = 500;
    quantity =  parseInt($("#order_product_quantity").val());
    $("#total_price").text(unit_price * quantity);
      $("#design_type").text("PPT演示文稿");
    //获得第二个radio的“单价”属性中的值
    //获得“需要的页数”控件中“页数”的值
    //获得“total_price”这个text element，然后改变他的text属性，计算结果 = 单价*页数
  });

  $('#order_preference_type_Web____').click(function() {
    unit_price = 1000;
    quantity =  parseInt($("#order_product_quantity").val());
    $("#total_price").text(unit_price * quantity);
      $("#design_type").text("Web页面设计");
    //获得第三个radio的“单价”属性中的值
    //获得“需要的页数”控件中“页数”的值
    //获得“total_price”这个text element，然后改变他的text属性，计算结果 = 单价*页数
  });







});
