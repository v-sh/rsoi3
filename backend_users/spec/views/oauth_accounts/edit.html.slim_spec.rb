require 'rails_helper'

RSpec.describe "oauth_accounts/edit", :type => :view do
  before(:each) do
    @oauth_account = assign(:oauth_account, OauthAccount.create!(
      :email => "MyString",
      :telephone => "MyString",
      :encrypted_password => "MyString",
      :salt => "MyString"
    ))
  end

  it "renders the edit oauth_account form" do
    render

    assert_select "form[action=?][method=?]", oauth_account_path(@oauth_account), "post" do

      assert_select "input#oauth_account_email[name=?]", "oauth_account[email]"

      assert_select "input#oauth_account_telephone[name=?]", "oauth_account[telephone]"

      assert_select "input#oauth_account_encrypted_password[name=?]", "oauth_account[encrypted_password]"

      assert_select "input#oauth_account_salt[name=?]", "oauth_account[salt]"
    end
  end
end
