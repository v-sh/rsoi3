require "rails_helper"

RSpec.describe OauthAccountsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/oauth_accounts").to route_to("oauth_accounts#index")
    end

    it "routes to #new" do
      expect(:get => "/oauth_accounts/new").to route_to("oauth_accounts#new")
    end

    it "routes to #show" do
      expect(:get => "/oauth_accounts/1").to route_to("oauth_accounts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/oauth_accounts/1/edit").to route_to("oauth_accounts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/oauth_accounts").to route_to("oauth_accounts#create")
    end

    it "routes to #update" do
      expect(:put => "/oauth_accounts/1").to route_to("oauth_accounts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/oauth_accounts/1").to route_to("oauth_accounts#destroy", :id => "1")
    end

  end
end
