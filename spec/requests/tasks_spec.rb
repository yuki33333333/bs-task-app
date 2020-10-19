require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let!(:task1) { create(:task, name: 'task1', description: 'task1', limit: Date.today) }
  let!(:task2) { create(:task, name: 'task2', description: 'task2', created_at: Time.current + 1.days, limit: Date.today + 1.days) }
  let!(:task3) { create(:task, name: 'task3', description: 'task3', created_at: Time.current + 2.days, limit: Date.today + 2.days) }

  describe 'index' do
    it 'get response successfully' do
      get tasks_path
      expect(response.status).to eq(200)
    end
  end

  describe 'search' do
    context 'success' do
      it 'sorted by created_at' do
        get search_tasks_path, params: { keyword: "new_create_date", commit: "並べ替え" }
        expect(response.status).to eq(200)
      end

      it 'sorted by limit' do
        get search_tasks_path, params: { keyword: "old_limit_date", commit: "並べ替え" }
        expect(response.status).to eq(200)
      end
    end

    context 'failure' do
      it 'sent different query' do
        get search_tasks_path, params: { keyword: "hoge", commit: "並べ替え" }
        expect(response.status).to eq(200)
      end
    end
  end
end