# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  limit       :date
#  status      :integer
#
require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    context 'invalid' do
      let(:task) { build(:task, name: nil) }

      it "is invalid without name column" do
        task.valid?
        expect(task.errors.messages[:name]).to include('を入力してください')
      end
    end

    context 'valid with name colmun' do
      let(:task) { build(:task, description: nil) }

      it "is valid with name colmun" do
        expect(task).to be_valid
      end
    end

    context 'valid with name, describe colmun' do
      let(:task) { build(:task) }

      it "is valid with name, describe colmun" do
        expect(task).to be_valid
      end
    end
  end
end
