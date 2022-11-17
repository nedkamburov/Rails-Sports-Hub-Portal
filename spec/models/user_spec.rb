require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  it 'must be valid' do
    expect(user).to be_valid
  end

  describe 'name' do
    it 'must be present' do
      expect(user.name).to_not be_nil
    end
  end

  describe 'email' do
    it 'must be present' do
      expect(user.email).to_not be_nil
    end

    it 'must be valid email' do
      expect(user.email).to include '@'
    end

    it 'must be unique and raise an error if somebody wants to use the same email' do
      expect {
        user.save!
        FactoryBot.create(:user)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'password' do
    it 'must be present' do
      expect(user.password).to_not be_nil
    end

    it 'must be string' do
      expect(user.password).to be_a(String)
    end

    it 'must be at least 8 characters long' do
      expect(user.password.length).to be > 7
    end
  end

  describe 'role' do
    it 'must be present' do
      expect(user.role).to_not be_nil
    end

    it 'must be "user" by default' do
      expect(user.role).to eq 'user'
    end
  end
end