require 'rails_helper'

RSpec.describe "users/edit", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :displayName => "MyString",
      :gplus_url => "MyString",
      :image_url => "MyString",
      :about_me => "MyString",
      :gender => "MyString",
      :gplus_id => 1
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_displayName[name=?]", "user[displayName]"

      assert_select "input#user_gplus_url[name=?]", "user[gplus_url]"

      assert_select "input#user_image_url[name=?]", "user[image_url]"

      assert_select "input#user_about_me[name=?]", "user[about_me]"

      assert_select "input#user_gender[name=?]", "user[gender]"

      assert_select "input#user_gplus_id[name=?]", "user[gplus_id]"
    end
  end
end
