require 'rails_helper'

RSpec.describe AppointmentComment, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(AppointmentComment.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
    context 'Appointmentモデルとの関係' do
      it 'N:1となっている' do
        expect(AppointmentComment.reflect_on_association(:appointment).macro).to eq :belongs_to
      end
    end
  end  
end
