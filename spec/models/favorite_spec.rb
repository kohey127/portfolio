require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
    context 'Serviceモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:service).macro).to eq :belongs_to
      end
    end
  end
end
