#= require bootstrap/affix
#= require bootstrap/alert
#= require bootstrap/button
#= require bootstrap/carousel
#= require bootstrap/collapse
#= require bootstrap/dropdown
#= require bootstrap/modal
#= require bootstrap/popover
#= require bootstrap/scrollspy
#= require bootstrap/tab
#= require bootstrap/tooltip
#= require bootstrap/transition

jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
