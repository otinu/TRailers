# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |number|
  user = User.create(name: "Administrator",
                    email: Faker::Internet.email,
                    mine_open: Faker::Boolean.boolean(true_ratio: 1),
                    others_open: Faker::Boolean.boolean(true_ratio: 1),
                    password: "#{ENV['ADMIN_PASSWORD']}",
                    password_confirmation: "#{ENV['ADMIN_PASSWORD']}") if number == 0
  user = User.create(name: Faker::Name.middle_name,
                    email: Faker::Internet.email,
                    mine_open: Faker::Boolean.boolean(true_ratio: 1),
                    others_open: Faker::Boolean.boolean(true_ratio: 1),
                    password: 'password',
                    password_confirmation: 'password') unless number == 0

  image_url = Faker::Avatar.image(slug: user.email, size: '50x50')
  # ActiveStorageを使ってavatarを設定
  user.profile_image.attach(io: URI.parse(image_url).open, filename: 'avatar.png')
end

5.times do |number|
  genre = ["Rails", "Ruby", "HTML", "CSS", "JavaScript", "API", "AWS", "Python", "DB", "Test", "DesignApp", "Rest"]
  post = Post.new(user_id: 1)

  post.title = "Railsの投稿" if number == 0
  post.title = "Rubyの投稿" if number == 1
  post.title = "HTMLの投稿" if number == 2
  post.title = "CSSの投稿" if number == 3
  post.title = "JavaScriptの投稿" if number == 4

  post.tag_list = genre[0] if number == 0
  post.tag_list = genre[1] if number == 1
  post.tag_list = genre[2] if number == 2
  post.tag_list = genre[3] if number == 3
  post.tag_list = genre[4] if number == 4

  post.explanation = "【サンプル/Sample】\nこの投稿はサンプルです。\n恐れながら、ポートフォリオ用のストレージの関係で投稿できるファイルのサイズは最大で3MBになっておりますが、サンプル動画は特別に3MB以上で投稿しています。\n\nI'm sorry, but the maximum file size that can be posted is 3MB.\nSamples are specially posted over 3MB" if number == 0
  post.explanation = "【サンプル/Sample】\n seedファイル作成しました。Faker便利ですね。\n面白いのはBooleanには確率を設定できるようで、「true_ratio: 0.5」と指定するとtrueとfalseを返す確率が半々になるようです。" if number == 1
  post.explanation = "【サンプル/Sample】\nやっとTop画面完成！！\n色とか余白とか色々と気になると止まらなくて、気づいたら3時間も経過;;\nこれでまだTop一枚…。\nヽ( ´￢`)ﾉ ﾜ～ｲ" if number == 2
  post.explanation = "【サンプル/Sample】\n何故か色んなブラウザで確認するとレイアウト乱れるなと思ったら！\n皆さんもお気をつけください～" if number == 3
  post.explanation = "【サンプル/Sample】\n以前チーム開発で作ったアプリに素のJavaScriptを入れてみました！ 調べてみると「touchstart」というイベントもあるようで、時間ある際にチャレンジしてみたいと思います！" if number == 4

  post.post_file.attach(io: File.open('app/assets/images/Rails_sample.mp4'), filename: 'Rails_sample.mp4') if number == 0
  post.post_file.attach(io: File.open('app/assets/images/Ruby_sample.png'), filename: 'Ruby_sample.png') if number == 1
  post.post_file.attach(io: File.open('app/assets/images/HTML_sample.pdf'), filename: 'HTML_sample.pdf') if number == 2
  post.post_file.attach(io: File.open('app/assets/images/CSS_sample.jpg'), filename: 'CSS_sample.jpg') if number == 3
  post.post_file.attach(io: File.open('app/assets/images/JS_sample.mp4'), filename: 'JS_sample.mp4') if number == 4

  post.save(validate: false)
end