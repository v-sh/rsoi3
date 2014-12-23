require 'rails_helper'

RSpec.describe "users/show", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :displayName => "Display Name",
      :gplus_url => "Gplus Url",
      :image_url => "Image Url",
      :about_me => "About Me",
      :gender => "Gender",
      :gplus_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Display Name/)
    expect(rendered).to match(/Gplus Url/)
    expect(rendered).to match(/Image Url/)
    expect(rendered).to match(/About Me/)
    expect(rendered).to match(/Gender/)
    expect(rendered).to match(/1/)
  end
end
