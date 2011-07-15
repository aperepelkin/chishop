class Calculator::PriceFixVolumeDiscount < Calculator
  preference :minimal_amount, :decimal, :default => 0
  preference :normal_amount, :decimal, :default => 0
  preference :discount_amount, :decimal, :default => 0

  def self.description
    I18n.t("price_fix_volume_discount")
  end

  def self.register
    super
    #Promotion.register_calculator(self)
    ShippingMethod.register_calculator(self)
  end

  # as object we always get line items, as calculable we have Coupon, ShippingMethod
  def compute(object)
    return unless object.present? and object.line_items.present?
    base = object.line_items.map(&:amount).sum

    if base < self.preferred_minimal_amount
      self.preferred_normal_amount
    else
      self.preferred_discount_amount
    end
  end
end
