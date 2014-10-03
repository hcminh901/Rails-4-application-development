$ ->
  $("#posts").infinitescroll
    navSelector: "nav.pagination"
    nextSelector: "nav.pagination a[rel=next]"
    itemSelector: "#main #posts #tiles"

  wookmark = () ->
    $handler = $("#tiles td")
    $handler.wookmark
      autoResize: true
      container: $("#main")
      offset: 5
      outerOffset: 10
      itemWidth: 210

    $handler.click ->
      newHeight = $("img", @).height() + Math.round(Math.random() * 300 + 30)
      $(@).css "height", newHeight + "px"
      $handler.wookmark()

  $("#posts").bind "DOMNodeInserted", ->
    wookmark()
  wookmark()