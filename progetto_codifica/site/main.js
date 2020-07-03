$(document).ready(function(){
  $('#img_preview').click(function(){
    $('#big').show();
    $('nav').show();
    });

  $('.closebtn').click(function(){
    $('#big').hide();
    $('nav').hide();
  });

  $('.btn').click(function(){
    $('#partial_letter').css("display","block");
    $('#intest').css("display","none");
    $('.btn').css("display","none");
    $('.btn2').css("display","block");
  });

  $('.btn2').click(function(){
    $('#partial_letter').css("display","none");
    $('#intest').css("display","block");
    $('.btn2').css("display","none");
    $('.btn').css("display","block");
  });

  
});
