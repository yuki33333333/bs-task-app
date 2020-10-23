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

  describe 'フィルター' do
    let!(:waiting_task) { create_list(:task, 3, name: 'waiting_task', description: 'task1', status: 0) }
    let!(:doing_task) { create_list(:task, 3, name: 'doing_task', description: 'task2', status: 1) }
    let!(:done_task) { create_list(:task, 3, name: 'done_task', description: 'task3', status: 2) }

    context 'waitingのタスクだけが表示されていること' do
      it do
        visit tasks_path
        select 'waiting'
        click_on '絞り込み'
        within '.tasks' do
          task_names = all('.task-name').map(&:text)
          expect(task_names).not_to include("doing_task", "done_task")
        end
      end
    end

    context 'doingのタスクだけが表示されていること' do
      it do
        visit tasks_path
        select 'doing'
        click_on '絞り込み'
        within '.tasks' do
          task_names = all('.task-name').map(&:text)
          expect(task_names).not_to include("waiting_task", "done_task")
        end
      end
    end

    context 'doneのタスクだけが表示されていること' do
      it do
        visit tasks_path
        select 'done'
        click_on '絞り込み'
        within '.tasks' do
          task_names = all('.task-name').map(&:text)
          expect(task_names).not_to include("waiting_task", "doing_task")
        end
      end
    end
  end

  describe '検索' do
    let!(:hoge_name_task) { create(:task, name:"ahoge1") }
    let!(:hoge_description_task) { create(:task, name:"task1", description:"#hoge~") }

    it 'name,descriptionを対象としてhogeをLIKE検索できていること' do
      visit tasks_path
      fill_in('keyword', with: 'hoge')
      click_on '検索する'
      within '.tasks' do
        task_names = all('.task-name').map(&:text)
        expect(task_names).to include('ahoge1', 'task1')
      end
    end
  end
end
