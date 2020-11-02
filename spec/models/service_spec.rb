require 'rails_helper'

RSpec.describe Service, type: :model do
  describe 'バリデーションのテスト' do
    let(:customer) { create(:customer) }
    let!(:service) { build(:service, customer_id: customer.id )}
    subject { service.valid? }

    context 'catchphraseカラム' do
      it '空欄でないこと' do
        service.catchphrase = ''
        is_expected.to eq false;
      end
    end
    context 'placeカラム' do
      it '空欄でないこと' do
        service.place = ''
        is_expected.to eq false;
      end
    end
    context 'contentカラム' do
      it '空欄でないこと' do
        service.content = ''
        is_expected.to eq false;
      end
    end
    context 'pointカラム' do
      it '空欄でないこと' do
        service.point = ''
        is_expected.to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Service.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
    context 'Appointmentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Service.reflect_on_association(:appointments).macro).to eq :has_many
      end
    end
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Service.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
  end
end
