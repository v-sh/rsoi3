require 'rails_helper'

RSpec.describe "oauth_accounts/show", :type => :view do
  before(:each) do
    @oauth_account = assign(:oauth_account, OauthAccount.create!(
      :email => "Email",
      :telephone => "Telephone",
      :encrypted_password => "Encrypted Password",
      :salt => "Salt"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Telephone/)
    expect(rendered).to match(/Encrypted Password/)
    expect(rendered).to match(/Salt/)
  end
end
