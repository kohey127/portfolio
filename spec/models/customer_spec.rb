require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'バリデーションのテスト' do
    let(:customer) { build(:customer) }
    subject { test_customer.valid? }
    context 'nameカラム' do
      let(:test_customer) {customer}
      it '空欄でないこと' do
        test_customer.name = ''
        is_expected.to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Serviceモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:services).macro).to eq :has_many
      end
    end
    context 'Serviceモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:services).macro).to eq :has_many
      end
    end
    context 'AppointmentCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:appointment_comments).macro).to eq :has_many
      end
    end
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'PointHistoryモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:point_histories).macro).to eq :has_many
      end
    end
    context 'ExpHisotyモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:exp_histories).macro).to eq :has_many
      end
    end
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Service.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
  end
end
