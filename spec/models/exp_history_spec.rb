require 'rails_helper'

RSpec.describe ExpHistory, type: :model do
  describe 'バリデーションのテスト' do
    let(:customer) { create(:customer) }
    let(:service) { create(:service, customer_id: customer.id)}
    let!(:exp_history) { build(:exp_history, customer_id: customer.id, trigger_id: service.id )}
    subject { exp_history.valid? }

    context 'balanceカラム' do
      it '空欄でないこと' do
        exp_history.balance = ''
        is_expected.to eq false;
      end
    end
    context 'triggerカラム' do
      it '空欄でないこと' do
        exp_history.trigger_id = ''
        is_expected.to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(ExpHistory.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
    context 'trigger(Customer)モデルとの関係' do
      it 'N:1となっている' do
        expect(ExpHistory.reflect_on_association(:trigger).macro).to eq :belongs_to
      end
    end
  end
end
