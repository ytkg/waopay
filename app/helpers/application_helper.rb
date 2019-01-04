module ApplicationHelper
  def qrcode_tag(text)
    qr = ::RQRCode::QRCode.new(text)
    qr_data_url = ChunkyPNG::Image.from_datastream(qr.as_png.resize(500, 500).to_datastream).to_data_url
    image_tag(qr_data_url, width: '100%')
  end
end
