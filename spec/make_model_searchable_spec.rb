require 'spec_helper'

describe MakeModelSearchable do
  it 'has a version number' do
    expect(MakeModelSearchable::VERSION).not_to be nil
  end

  describe "Model which specifies attributes to be searched from" do
  	before do
  		User.create(:first_name => "pm", :last_name => "dm")
  	end
  	it "returns search results" do 
  		expect(User.count).not_to eq(0)
  	end
	end

  describe "Model which does not specify attributes to be searched from"
  # it 'does something useful' do
  #   expect(false).to eq(true)
  # end
end
