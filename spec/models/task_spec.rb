require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションが有効かどうか' do
    it "is invalid without name column" do
      task = Task.new()
      task.valid?
      expect(task.errors.messages[:name]).to include('を入力してください')
    end
  end

  describe 'タスク新規作成ができるかどうか' do
    # タスク名だけでタスク新規作成できるか
    it "is valid with name colmun" do
      task = Task.new(name: "掃除")
      expect(task).to be_valid
    end

    # タスク名と説明でタスク新規作成できるか
    it "is valid with name, describe colmun" do
      task = build(:task)
      expect(task).to be_valid
    end
  end
end
