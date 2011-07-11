module Admin::AdvancedReportsHelper
  def is_invalid(variant)
    variant.price == 0
  end
end
