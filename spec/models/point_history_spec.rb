require 'rails_helper'

RSpec.describe PointHistory, type: :model do
  describe 'バリデーションのテスト' do
    let(:customer) { create(:customer) }
    let(:service) { create(:service, customer_id: customer.id)}
    let!(:point_history) { build(:point_history, customer_id: customer.id, trigger_id: service.id )}
    subject { point_history.valid? }

    context 'balanceカラム' do
      it '空欄でないこと' do
        point_history.balance = ''
        is_expected.to eq false;
      end
    end
    context 'triggerカラム' do
      it '空欄でないこと' do
        point_history.trigger_id = ''
        is_expected.to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(PointHistory.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
    context 'trigger(Customer)モデルとの関係' do
      it 'N:1となっている' do
        expect(PointHistory.reflect_on_association(:trigger).macro).to eq :belongs_to
      end
    end
  end
end
