require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let!(:task1) { create(:task, name: 'task1', description: 'task1', limit: Date.today) }
  let!(:task2) { create(:task, name: 'task2', description: 'task2', created_at: Time.current + 1.days, limit: Date.today + 1.days) }
  let!(:task3) { create(:task, name: 'task3', description: 'task3', created_at: Time.current + 2.days, limit: Date.today + 2.days) }

  describe 'GET /tasks' do
    it 'get response successfully' do
      get tasks_path
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /tasks/sort' do
    subject { get sort_tasks_path, params: { keyword: keyword, commit: "並べ替え" } }

    context 'sorted by created_at' do
      let(:keyword) { "new_create_date" }

      it do
        subject
        expect(response.status).to eq(200)
      end
    end

    context 'when sorted by limit' do
      let(:keyword) { "old_limit_date" }

      it do
        subject
        expect(response.status).to eq(200)
      end
    end

    context 'sent different query' do
      let(:keyword) { "hoge" }

      it do
        subject
        expect(response.status).to eq(400)
      end
    end
  end
end
