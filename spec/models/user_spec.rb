require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
    it { should validate_confirmation_of(:password) }
  end

  describe 'instance methods' do
    it { should respond_to(:status) }
    it { should respond_to(:active?) }
    it { should respond_to(:inactive?) }
    it { should respond_to(:active!) }
    it { should respond_to(:inactive!) }
  end
end
