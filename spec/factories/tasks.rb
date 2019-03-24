FactoryBot.define do
  factory :task do
    user { User.first || association(:user) }
    title { 'タイトル1' }
    content { 'コンテンツ1' }
    deadline { Date.today + 1 }
    priority { "低" }
  end

  factory :second_task, class: Task do
    title { 'タイトル2' }
    content { 'コンテンツ2' }
    deadline { Date.today + 2 }
    priority { "高" }
    user { User.first || association(:user) }
  end

  factory :third_task, class: Task do
    title { 'タイトル3' }
    content { 'コンテンツ3' }
    deadline { Date.today + 3 }
    priority { "中" }
    user { User.first || association(:user) }
  end
end
