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
    expect(task).not_to be_valid
  end

  it "contentが空ならバリデーションが通らない" do
    task = Task.new(title: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end

  it "titleとcontentに内容が記載されていればバリデーションが通る" do
    task = Task.new(title: '成功テスト', content: '成功テスト')
    expect(task).to be_valid
  end

  it "title検索" do
    Task.create(title: "aaa", status: "未着手")
    Task.create(title: "bbb", status: "着手中")
    expect(Task.search_title("aaa")).to eq Task.where("title LIKE ?", "%#{"aaa"}%")
    expect(Task.search_title("aaa").count) == 1
  end

  it "status検索" do
    Task.create(title: "aaa", status: "未着手")
    Task.create(title: "bbb", status: "着手中")
    expect(Task.search_status("未着手")).to eq Task.where(status: "未着手")
    expect(Task.search_status("未着手").count) == 1
  end

  it "titleとstatus検索" do
    Task.create(title: "aaa", status: "未着手")
    Task.create(title: "bbb", status: "着手中")
    expect(Task.search_title("aaa").search_status("未着手")).to eq Task.where("title LIKE ?", "%#{"aaa"}%").where(status: "未着手")
    expect(Task.search_title("aaa").count) == 1
  end
end
