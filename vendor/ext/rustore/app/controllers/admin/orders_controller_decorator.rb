Admin::OrdersController.class_eval do
  respond_to :html

  def deliver
    @order.shipments.each do |shipment|
      unless shipment.shipped?
        unless shipment.ready?
          shipment.ready!
        end
        shipment.ship!
      end
    end

    @order.update!
    redirect_to admin_order_path(@order)
  end

  def delivered
    @order.payments.each do |payment|
      unless payment.completed?
        payment.started_processing!
        payment.complete!
      end
    end

    @order.update!
    redirect_to admin_order_path(@order)
  end
end
