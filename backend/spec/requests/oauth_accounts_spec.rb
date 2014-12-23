require 'rails_helper'

RSpec.describe "OauthAccounts", :type => :request do
  describe "GET /oauth_accounts" do
    it "works! (now write some real specs)" do
      get oauth_accounts_path
      expect(response.status).to be(200)
    end
  end
end
