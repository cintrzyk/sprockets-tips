$(document).on('turbolinks:load', function() {
  $('[data-js-price]').each(function() {
    $(this).text(accounting.formatMoney($(this).text()))
  });
});
