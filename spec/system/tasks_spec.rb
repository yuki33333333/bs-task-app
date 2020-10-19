require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'ソート' do
    let!(:task1) { create(:task, name: 'task1', description: 'task1') }
    let!(:task2) { create(:task, name: 'task2', description: 'task2', created_at: Time.current + 1.days) }
    let!(:task3) { create(:task, name: 'task3', description: 'task3', created_at: Time.current + 2.days) }

    context 'タスク作成日時の降順であること' do
      it do
        visit tasks_path
        within '.tasks' do
          task_names = all('.task-name').map(&:text)
          expect(task_names).to eq %w(task3 task2 task1)
        end
      end
    end

    context '終了期限が古い順であること' do
      it do
        visit tasks_path
        select '終了期限が古い順'
        click_on '並べ替え'
        within '.tasks' do
          task_names = all('.task-name').map(&:text)
          expect(task_names).to eq %w(task1 task2 task3)
        end
      end
    end
  end
end
