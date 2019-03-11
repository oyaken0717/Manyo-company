2019.03.11
18:00

schema.rb

![スクリーンショット 2019-03-11 17 45 25](https://user-images.githubusercontent.com/46299780/54112146-d980fa80-4428-11e9-9cc9-22f9a1effd6f.png)


```ruby
create_table "users", force: :cascade do |t|
  t.string "name", null: false
end
```

```ruby
create_table "tasks", force: :cascade do |t|
  t.string "name", null: false
  t.date "deadline", null: false
  t.integer "priority", null: false
  t.string "status", null: false
  t.text "label", null: false
end
```
