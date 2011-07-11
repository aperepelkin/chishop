class Admin::AdvancedReportsController < Admin::BaseController
  respond_to :html

  AVAILABLE_REPORTS = {
    :inventory   => {:name => "inventory", :description => "inv"}
  }

  def index
    @reports = AVAILABLE_REPORTS
    respond_with(@reports)
  end

  def inventory
    @products = Product.joins(:variants_with_only_master).order('sku').not_deleted

    respond_with
  end

end
