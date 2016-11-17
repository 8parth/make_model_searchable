require 'spec_helper'

describe MakeModelSearchable do
  it 'has a version number' do
    expect(MakeModelSearchable::VERSION).not_to be nil
  end

  describe "when valid attributes passed" do
  	before do
  		User.create(:first_name => "pm", :last_name => "dm")
  		# @users = User.search("p")
  	end
  	it "returns search results" do 
  		expect(User.count).not_to eq(0)
  	end

	end
  # it 'does something useful' do
  #   expect(false).to eq(true)
  # end
end
