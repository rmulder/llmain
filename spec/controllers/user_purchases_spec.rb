describe UserPurchasesController do

  it "is available before an action" do
    controller.should be_an_instance_of(UserPurchasesController)
  end

  describe "purchase" do
    it "renders the purchase template" do
      # simulate passing an id from a social coupon with a mock obj
      social_coupon = mock_model(SocialCoupon)
      SocialCoupon.should_receive(:find).with(social_coupon.id).and_return(social_coupon)
      get :purchase, { :id => social_coupon.id }
      # does it render the correct template?
      response.should render_template("purchase")
      assigns[:coupon].should be_kind_of(Coupon)
    end
  end

  describe "frame" do
    it "expects a valid social coupon id"
    it "won't sell a nonexistent social coupon"
    it "won't sell too many coupons to a user"
    it "won't sell too few coupons to a user"
    it "won't sell the same coupon to a user twice"
    it "won't sell too many coupons"
    it "expects valid coupon description records"
    it "redirects to merchant e-services when complete"
  end

  describe "frame_response" do
    it "shows an error when it receives an error"
    it "redirects when it receives a redirect"
  end

  describe "frame_complete" do
    it "shows a complete message or closes an iframe"
  end

  describe "purchase_callback" do
    it "expects a valid user_purchase id"
    it "expects a valid invoice number"
    it "expects invoice and purchase id to match"
    it "expects an invoice value"
    it "expects the invoice value to match the user_purchase value"
    it "times out after five minutes"
    it "expects for there to be coupon records"
    it "expects a valid secret code"

    it "creates a completed payment_transaction record"
    it "outputs OK"
  end

  describe "cancel_callback" do
    it "expects a valid user_purchase id"
    it "expects for there to be coupon records"
    it "expects a valid secret code"
    
    it "creates a cancelled payment_transaction record"
    it "voids the coupons in the cart"
    it "outputs OK"
  end

  describe "refund" do
    it "expects a valid user_purchase id"
    it "expects for there to be coupon records"
    it "returns a url to do a refund on merchant e-services"
    it "outputs OK"
  end

  describe "refund_callback" do
    it "expects a valid user_purchase id"
    it "expects an invoice value"
    it "expects the invoice value to match the user_purchase value"
    it "expects for there to be coupon records"
    it "expects a valid secret code"

    it "creates a refund payment_transaction record"
    it "outputs OK"
  end

  describe "cancel_refund_callback" do
    it "expects a valid user_purchase id"
    it "expects for there to be coupon records"
    it "expects a valid secret code"

    it "creates a refund-cancelled payment_transaction record"
    it "outputs OK"
  end

end