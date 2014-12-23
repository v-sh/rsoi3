require 'rails_helper'

RSpec.describe "oauth_accounts/index", :type => :view do
  before(:each) do
    assign(:oauth_accounts, [
      OauthAccount.create!(
        :email => "Email",
        :telephone => "Telephone",
        :encrypted_password => "Encrypted Password",
        :salt => "Salt"
      ),
      OauthAccount.create!(
        :email => "Email",
        :telephone => "Telephone",
        :encrypted_password => "Encrypted Password",
        :salt => "Salt"
      )
    ])
  end

  it "renders a list of oauth_accounts" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Telephone".to_s, :count => 2
    assert_select "tr>td", :text => "Encrypted Password".to_s, :count => 2
    assert_select "tr>td", :text => "Salt".to_s, :count => 2
  end
end
