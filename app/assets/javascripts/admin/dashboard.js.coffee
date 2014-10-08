$ ->
  Morris.Line
    element: "impressions_chart"
    data: $("#impressions_chart").data("impression")
    xkey: "date"
    ykeys: ["impressions"]
    labels: ["Impressions"]

  Morris.Line
    element: "click_chart"
    data: $("#click_chart").data("click")
    xkey: "date"
    ykeys: ["clicks"]
    labels: ["Clicks"]

  Morris.Donut
    element: "demographic"
    data: $("#demographic").data("demo")
