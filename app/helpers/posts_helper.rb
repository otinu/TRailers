module PostsHelper
  def make_all_genre(posts)
    @all_genre = []
    posts.each_with_index do |post, i|
      post.tag_list.each do |genre|
        @all_genre[i] = genre
      end
    end
  end
end
