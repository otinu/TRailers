module NewPostSupport
  def new_post(post)
    visit new_post_path
    expect(page).to have_content "投稿へのコメント"
    fill_in 'post[title]', with: post.title
    select "Ruby", from: "post[tag_list]"
    attach_file("post[post_file]", "#{Rails.root}/spec/fixtures/lens.jpeg")
    fill_in "post[explanation]", with: post.explanation
    expect { click_button "登録する" }.to change(Post.all, :count).by(1)
  end

  def create_and_skip_show(post)
    new_post(post)
    within "div#1" do
      find('.post-glass').click
    end
  end
end
