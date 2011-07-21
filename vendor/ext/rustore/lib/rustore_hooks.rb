class RustoreHooks < Spree::ThemeSupport::HookListener

  insert_before :product_properties , 'shared/attributes'

  replace :product_description, 'products/description'
  replace :cart_item_description, 'order/order_item_detail'
  replace :admin_order_show_buttons, 'admin/orders/order_buttons'
  replace :admin_shipment_edit_form_buttons, 'admin/shipments/shipment_buttons'
end