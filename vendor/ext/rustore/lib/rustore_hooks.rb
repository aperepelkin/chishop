class RustoreHooks < Spree::ThemeSupport::HookListener
  insert_before :product_properties , 'shared/attributes'

  replace :product_description, 'products/description'
  replace :cart_item_description, 'order/order_item_detail'
end