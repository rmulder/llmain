ACCESS_TOKEN = {
  :access_token => "plataformatec"
}

FACEBOOK_INFO = {
  :id => '32950',
  :link => 'http://facebook.com/user_example',
  :email => 'johndoe@example.com',
  :first_name => 'John',
  :last_name => 'Doe',
  :website => 'http://blog.plataformatec.com.br'
}

When /^Facebook reply$/ do
  Devise::OmniAuth.short_circuit_authorizers!
  Devise::OmniAuth.stub!(:facebook) do |b|
    b.post('/oauth/access_token') { [200, {}, ACCESS_TOKEN.to_json] }
    b.get('/me?access_token=plataformatec') { [200, {}, FACEBOOK_INFO.to_json] }
  end

  visit '/auth/facebook/callback'
end
