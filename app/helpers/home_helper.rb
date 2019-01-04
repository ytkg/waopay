module HomeHelper
  def display_order_detail(orders)
    dom = "<ul class='row list-group list-group-flush'>"

    orders.each do |order|
      dom += "<li class='list-group-item list-group-item-action flex-column align-items-start'>"
      dom += "<div class='d-flex w-100 justify-content-between'>"
      dom += "<small>#{order.created_at.strftime("%Y/%m/%d %H:%M:%S")}</small>"

      sign = @current_user.id == order.receiving_user_id ? '+' : '-'
      dom += "<h5 class='mb-1'>#{sign}#{number_to_currency(order.amount)}</h5>"
      dom += "</div>"

      if @current_user.id == order.receiving_user_id
        dom += "<small>#{order.payment_user.name}(#{order.payment_user.username})さんから受け取り</small>"
      else
        dom += "<small>#{order.receiving_user.name}(#{order.receiving_user.username})さんに支払い</small>"
      end

      dom += "</li>"
    end

    dom += "</ul>"

    dom.html_safe
  end
end
