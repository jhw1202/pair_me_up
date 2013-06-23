$(document).ready(function(){
  $('.about').on('click', function(){
    $('.description').toggle('slow', function(){})
  })

  $('.members-list-expand').on('click', function(){
    var _this = $(this)
    _this.text() === "Show members" ? _this.text("Hide members") : _this.text("Show members")
    $(this).next().toggle('slow', function(){})
  })
})
