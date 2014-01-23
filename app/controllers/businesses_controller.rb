class BusinessesController < ApplicationController

  layout 'avatar_editor'
  in_place_edit_for :business, :website

  def dashboard
    page = params['page'] || 1
    @businesses = Business.find_top_ranked_businesses_without_pictures page
    @details = Business.get_details_for_list_of_business_ids @businesses
  end

  def edit
    @business = Business.find(params[:id])
  end

  def geo
    page = params['page'] || 1
    @zip_code_list = CHICAGO
    @details = Business.find_all_businesses_in_zip page, @zip_code_list
  end


end
