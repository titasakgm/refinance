//= require surveyor/jquery-1.9.0
//= require surveyor/jquery-ui-1.10.0.custom
//= require surveyor/jquery-ui-timepicker-addon
//= require surveyor/jquery.selectToUISlider
//= require surveyor/jquery.surveyor
//= require surveyor/jquery.maskedinput

var sect5, s5, count=0;

function hide_flash() {
  $('.surveyor_flash').hide();
}

$(".alert" ).fadeOut(5000);
$(".notice" ).fadeOut(5000);
setTimeout(hide_flash, 5000);

$(function() {
  sect5 = $("#help_text");
  sect5.dialog({
    title: "ตัวอย่างการทำรีไฟแนนซ์",
    autoOpen: false,
    modal: true,
    width: "500px",
    show: {
      effect: "blind",
      duration: 1000
    },
    hide: {
      effect: "explode",
      duration: 1000
    }
  });

  s5 = $("#survey_section_5 #q_58 legend span");
  s5.mouseover(function(){
    count += 1;
    if (count % 3 == 1) {
      sect5.dialog("open");
    }
  });
});
