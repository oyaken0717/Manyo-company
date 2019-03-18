require 'rails_helper'
require 'pry'

RSpec.describe Task, type: :model do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end

  it "titleが空ならバリデーションが通らない" do
    task = Task.new(title: '', content: '失敗テスト')
    # task = Task.create!(title: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end

  it "contentが空ならバリデーションが通らない" do
    # ここに内容を記載する
    task = Task.new(title: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end

  it "titleとcontentに内容が記載されていればバリデーションが通る" do
    # ここに内容を記載する
    task = Task.new(title: '成功テスト', content: '成功テスト')
    expect(task).to be_valid
  end

  it "モデルに作成したscopeを使ってタイトルによる検索ができる" do
    task = User.first.tasks.build(title: "aaabbb", summary: "タイトルけんさく", limit: '2019-04-17T12:30:45', status: '未着手')
    task.save
    expect_task_title = Task.where(title: "aaabbb").first.title
    search_title = Task.search_with_title(@search_params).first.title
    expect(search_title).to eq expect_task_title
  end

end
