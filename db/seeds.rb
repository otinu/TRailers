# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |number|
  user = User.create(name: Faker::Name.middle_name,
                    email: Faker::Internet.email,
                    mine_open: Faker::Boolean.boolean(true_ratio: 1),
                    others_open: Faker::Boolean.boolean(true_ratio: 1),
                    password: 'password',
                    password_confirmation: 'password')

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

  post.explanation = "Rails頑張りました" if number == 0
  post.explanation = "Ruby頑張りました" if number == 1
  post.explanation = "HTML頑張りました" if number == 2
  post.explanation = "CSS頑張りました" if number == 3
  post.explanation = "JavaScript頑張りました" if number == 4

  post.post_file.attach(io: File.open('app/assets/images/test.mp4'), filename: 'test.mp4') if number == 0
  post.post_file.attach(io: File.open('app/assets/images/test.pdf'), filename: 'test.pdf') if number == 1
  post.post_file.attach(io: File.open('app/assets/images/locomotive.png'), filename: 'locomotive.png') if number == 2
  post.post_file.attach(io: File.open('app/assets/images/lens.jpg'), filename: 'lens.jpg') if number == 3
  post.post_file.attach(io: File.open('app/assets/images/photo.png'), filename: 'photo.png') if number == 4

  post.save(validate: false)
end