require 'rails_helper'

RSpec.describe "users/index", :type => :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :displayName => "Display Name",
        :gplus_url => "Gplus Url",
        :image_url => "Image Url",
        :about_me => "About Me",
        :gender => "Gender",
        :gplus_id => 1
      ),
      User.create!(
        :displayName => "Display Name",
        :gplus_url => "Gplus Url",
        :image_url => "Image Url",
        :about_me => "About Me",
        :gender => "Gender",
        :gplus_id => 1
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Display Name".to_s, :count => 2
    assert_select "tr>td", :text => "Gplus Url".to_s, :count => 2
    assert_select "tr>td", :text => "Image Url".to_s, :count => 2
    assert_select "tr>td", :text => "About Me".to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
