module SocialCouponsHelper
  def this_is_beta
    true if request.env['SERVER_NAME'] == 'beta.likelist.com'
  end
end
