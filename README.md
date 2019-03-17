2019.03.11
20:37

|User         |Task            |
|:-----------:|:--------------:|
|name string  |name string     |
|             |deadline date   |
|             |priority integer|
|             |status string   |
|             |label text      |

2019.3.17 13:10
step13
どのような手順でデプロイすれば良いかの方法を README.md に記載しましょう
$ heroku login
$ rails assets:precompile RAILS_ENV=production
$ heroku run rails db:migrate
$ git add -A
$ git commit -m
$ git push heroku master
