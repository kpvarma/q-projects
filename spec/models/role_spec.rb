require 'rails_helper'

RSpec.describe Role, :type => :model do

  context "Factory" do
    it "should validate the role factory" do
      expect(FactoryGirl.build(:role).valid?).to be true
    end
  end

  context "Validations" do
    it {should validate_inclusion_of(:name).in_array(Role::LIST) }
  end

  context "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end

end