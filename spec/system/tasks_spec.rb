require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'ソート' do
    let(:task1){ Task.create(name:'task1', description:'task1') }
    let(:task2){ Task.create(name:'task2', description:'task2', created_at: Time.current + 1.days) }
    let(:task3){ Task.create(name:'task3', description:'task3', created_at: Time.current + 2.days) }

    it 'タスク作成日時の降順であること' do
      # Task一覧画面を開く
      visit tasks_path

      # Taskの並び順が新規作成日時順が新しい順であること（task３、２、１の順）
      within '.tasks' do
        task_names = all('.task-name').map(&:text)
        expect(task_names).to eq %w(task3 task2 task1)
      end
    end
  end
end