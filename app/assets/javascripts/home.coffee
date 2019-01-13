# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  # pay
  window.openQRCamera = (node) ->
    reader = new FileReader();
    reader.onload = ->
      node.value = '';
      qrcode.callback = (res) ->
        if res instanceof Error
          alert("QRコードが見つかりません。 QRコードがカメラのフレーム内にあることを確認してから、もう一度やり直してください。");
        else
          node.parentNode.previousElementSibling.value = res;
          $('#pay_qrcode_text').val(res);
          $('#payButton').click();
      qrcode.decode(reader.result);
    reader.readAsDataURL(node.files[0]);

  $('#pills-pay-tab, #openCamera').click ->
    $('#pills-pay > div > label > input[type="file"]').click();

  # qrcode
  $('#qrcode_amount').change ->
    amount = parseInt($(this).val());
    if amount < 1
      $(this).val('');
      $('#makeButton').prop('disabled', true);
    else if amount >= 1000000
      $(this).val('999999');
      $('#makeButton').prop('disabled', false);
    else
      $(this).val(amount);
      $('#makeButton').prop('disabled', false);
