require 'spec_helper'

describe SocialCouponsController do

  def mock_social_coupon(stubs={})
    (@mock_social_coupon ||= mock_model(SocialCoupon).as_null_object).tap do |social_coupon|
      social_coupon.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all social_coupons as @social_coupons" do
      SocialCoupon.stub(:all) { [mock_social_coupon] }
      get :index
      assigns(:social_coupons).should eq([mock_social_coupon])
    end
  end

  describe "GET show" do
    it "assigns the requested social_coupon as @social_coupon" do
      SocialCoupon.stub(:find).with("37") { mock_social_coupon }
      get :show, :id => "37"
      assigns(:social_coupon).should be(mock_social_coupon)
    end
  end

  describe "GET new" do
    it "assigns a new social_coupon as @social_coupon" do
      SocialCoupon.stub(:new) { mock_social_coupon }
      get :new
      assigns(:social_coupon).should be(mock_social_coupon)
    end
  end

  describe "GET edit" do
    it "assigns the requested social_coupon as @social_coupon" do
      SocialCoupon.stub(:find).with("37") { mock_social_coupon }
      get :edit, :id => "37"
      assigns(:social_coupon).should be(mock_social_coupon)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created social_coupon as @social_coupon" do
        SocialCoupon.stub(:new).with({'these' => 'params'}) { mock_social_coupon(:save => true) }
        post :create, :social_coupon => {'these' => 'params'}
        assigns(:social_coupon).should be(mock_social_coupon)
      end

      it "redirects to the created social_coupon" do
        SocialCoupon.stub(:new) { mock_social_coupon(:save => true) }
        post :create, :social_coupon => {}
        response.should redirect_to(social_coupon_url(mock_social_coupon))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved social_coupon as @social_coupon" do
        SocialCoupon.stub(:new).with({'these' => 'params'}) { mock_social_coupon(:save => false) }
        post :create, :social_coupon => {'these' => 'params'}
        assigns(:social_coupon).should be(mock_social_coupon)
      end

      it "re-renders the 'new' template" do
        SocialCoupon.stub(:new) { mock_social_coupon(:save => false) }
        post :create, :social_coupon => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested social_coupon" do
        SocialCoupon.should_receive(:find).with("37") { mock_social_coupon }
        mock_social_coupon.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :social_coupon => {'these' => 'params'}
      end

      it "assigns the requested social_coupon as @social_coupon" do
        SocialCoupon.stub(:find) { mock_social_coupon(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:social_coupon).should be(mock_social_coupon)
      end

      it "redirects to the social_coupon" do
        SocialCoupon.stub(:find) { mock_social_coupon(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(social_coupon_url(mock_social_coupon))
      end
    end

    describe "with invalid params" do
      it "assigns the social_coupon as @social_coupon" do
        SocialCoupon.stub(:find) { mock_social_coupon(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:social_coupon).should be(mock_social_coupon)
      end

      it "re-renders the 'edit' template" do
        SocialCoupon.stub(:find) { mock_social_coupon(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested social_coupon" do
      SocialCoupon.should_receive(:find).with("37") { mock_social_coupon }
      mock_social_coupon.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the social_coupons list" do
      SocialCoupon.stub(:find) { mock_social_coupon }
      delete :destroy, :id => "1"
      response.should redirect_to(social_coupons_url)
    end
  end

end
