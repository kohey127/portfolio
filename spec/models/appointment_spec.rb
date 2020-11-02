require 'rails_helper'

RSpec.describe Appointment, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Serviceモデルとの関係' do
      it 'N:1となっている' do
        expect(Appointment.reflect_on_association(:service).macro).to eq :belongs_to
      end
    end
    context 'Customer(to_customer)モデルとの関係' do
      it 'N:1となっている' do
        expect(Appointment.reflect_on_association(:to_customer).macro).to eq :belongs_to
      end
    end
    context 'Customer(from_customer)モデルとの関係' do
      it 'N:1となっている' do
        expect(Appointment.reflect_on_association(:from_customer).macro).to eq :belongs_to
      end
    end
    context 'ExpHistoryモデルとの関係' do
      it '1:Nとなっている' do
        expect(Appointment.reflect_on_association(:exp_histories).macro).to eq :has_many
      end
    end
    context 'Appointment_commentモデルとの関係' do
      it '1:1となっている' do
        expect(Appointment.reflect_on_association(:appointment_comment).macro).to eq :has_one
      end
    end
  end  
end
