# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https:#github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require_tree .
$ ->
  $('[data-new-position]').on 'click', (e) ->
    e.preventDefault()
    $lastPositionForm = $('[data-position-number]')
    lastPositionForm = $lastPositionForm[$lastPositionForm.length - 1]
    lastNumber = parseInt(lastPositionForm.getAttribute('data-position-number'))
    nextNumber = lastNumber + 1
    newPositionForm = lastPositionForm.outerHTML.replace(new RegExp(lastNumber, "g"), nextNumber)
    console.log newPositionForm
    $positionsGroup = $('[data-position=group]')
    $positionsGroup.append newPositionForm
