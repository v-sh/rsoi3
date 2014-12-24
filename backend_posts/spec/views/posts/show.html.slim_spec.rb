require 'rails_helper'

RSpec.describe "posts/show", :type => :view do
  before(:each) do
    @post = assign(:post, Post.create!(
      :user_id => 1,
      :text => "Text"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Text/)
  end
end
