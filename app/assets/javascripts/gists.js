$(function(){
  var gists = $('section.gists')
  if (gists) {
    $.getJSON('/account/gists.json', function(data){
      gists.replaceWith(data.div);
      $('.importable-gist').tooltip({title: 'You can import this gist to new post.'});
    })
  }
  
  $("article.post a:contains('gist:')").click(function(){
    var article = $(this).parents('article:first')
    if (!article.hasClass('detail')) {
      document.location = article.attr('rel')
      return false
    }
  })
  
  $("article.post.detail a:contains('gist:')").each(function(){
    var id = $(this).html().match(/gist:(\d+)/)[1],
      link = ("/gists/" + id + ".json"),
      element = $(this)
    $.getJSON(link, function(data){
      element.replaceWith(data.div)
    })
  })
  
  var box = $("#post_content")
  $("a.importable-gist").live('click', function(){
    if(box.length > 0) {
      box.val(box.val() + "gist:" + $(this).data('gist-id') + " #" + $(this).data('gist-lang') + " ")
      return false;
    }
  })
})