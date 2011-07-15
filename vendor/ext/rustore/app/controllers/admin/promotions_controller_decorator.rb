Admin::PromotionsController.class_eval do
  respond_to :html

  def replicate
    prefix = params[:prefix]
    start = params[:start_from]
    stop = params[:stop_to]
    start.upto(stop) do |num|
      code = prefix + num.to_s

      new_promotion = @promotion.clone
      new_promotion.code = code
      new_promotion.name = code
      new_promotion.calculator = @promotion.calculator.clone
      new_promotion.calculator.stored_preferences = @promotion.calculator.stored_preferences.dup
      new_promotion.promotion_rules = @promotion.promotion_rules.dup
      new_promotion.save

    end
    redirect_to admin_promotions_path
  end

end
