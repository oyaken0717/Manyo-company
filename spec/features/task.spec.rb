require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end

  scenario "タスク一覧のテスト" do
    # tasks_pathにvisitする（タスク一覧ページに遷移する）
    visit tasks_path

    # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'

  end

  scenario "タスク作成のテスト" do
      # new_task_pathにvisitする（タスク登録ページに遷移する）
    # 1.ここにnew_task_pathにvisitする処理を書く
    visit new_task_path
    # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
    # タスクのタイトルと内容をそれぞれfill_in（入力）する
    # 2.ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
    fill_in "task_title", with:"test_task_03"

    # 3.ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
    fill_in "task_content", with:"testtesttest3"
    # 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
    # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
    click_on "Create Task"
    # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
    # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
    # 5.タスク詳細ページに、テストコードで作成したはずのデータ（記述）がhave_contentされているか（含まれているか）を確認（期待）するコードを書く
    expect(page).to have_content 'test_task_03'
    expect(page).to have_content 'testtesttest3'
  end

  scenario "タスク詳細のテスト" do

    visit tasks_path

    page.first(".task-index__show-link").click
    # click_on "詳細"
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル２'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント２'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    # backgroundに必要なタスクデータの作成処理が書かれているので、ここで書く必要がない

    # タスクが作成日時の降順に並んでいるかのテスト
    visit tasks_path
    expect(Task.order("created_at DESC").map(&:id)).to eq [12,11,10]
  end

  scenario "タスクが終了期限の昇順に並んでいるかのテスト" do
    visit tasks_path
    click_link "終了期限でソートする"
    @tasks = Task.order("deadline ASC")
    expect(@tasks[0].deadline < @tasks[1].deadline).to be true
  end

  scenario "タスクが優先順位の降順に並んでいるかのテスト" do
    visit tasks_path
    click_on "優先順位でソートする"
    expect(Task.order("priority DESC").map(&:priority)).to eq ["高","中","低"]

  end
end
