require 'spec_helper'
require 'pry'

describe MakeModelSearchable do
  it 'has a version number' do
    expect(MakeModelSearchable::VERSION).not_to be nil
  end

  describe "Model which specifies attributes to be searched from" do
    context "records with search term present for specified field" do
    	before(:all) do
        @search_term = "hn"
    		FactoryGirl.create(:user)
        @users = User.search(@search_term)
    	end
    	it "searches records from Model which matches search term" do
    		expect(@users.pluck(:first_name).include?(FactoryGirl.attributes_for(:user)[:first_name])).to eq(true)
      end 
    end
    context "records with search term not present for specified field" do
      before(:all) do
        @search_term = "doe"
        FactoryGirl.create(:user)
        @users = User.search(@search_term)
      end
      it "no records which matches to search term are found" do
        expect(@users.pluck(:first_name).include?(FactoryGirl.attributes_for(:user)[:first_name])).to eq(false)
      end
      it { 
        expect(@users.count).to eq(0)
      }
    end
	end

  describe "Model which does not specify attributes to be searched from" do
    context "no records present" do 
      before do 
        @search_term = "weasley"
        Person.search(:person)
        @persons = Person.search(@search_term)
      end
      it {
        expect(@persons.count).to eq(0)
      }
    end
    context "records matching search criteria present" do 
      before do 
        @search_term = "weasley"
        FactoryGirl.create(:person)
        @persons = Person.search(@search_term)
      end
      it {
        expect(@persons.count).to eq(1)
      }
      it "records matching to serach term are returned" do 
        expect(@persons.pluck(:last_name).include?(FactoryGirl.attributes_for(:person)[:last_name])).to eq(true)
      end
    end
  end
  
  describe "searchable_attributes" do 
    context "accepts joins columns" do 
      before do
        5.times do |t|
          @post = FactoryGirl.create(:post)
        end

        it { binding.pry }
      end
    end
  end
end
