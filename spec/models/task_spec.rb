require 'rails_helper'

RSpec.describe Task, type: :model do
  it "タスク名のバリデーションが有効かどうか" do
    task = Task.new()
    task.valid?
    expect(task.errors.messages[:name]).to include('を入力してください')
  end
end
