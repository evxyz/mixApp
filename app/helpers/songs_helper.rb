module SongsHelper

  def songs_for(object)
    content_tag :p do
      "<strong>Songs</strong><br>"
      content_tag :ul do
        render({:partial => 'songs/song_li', :collection => object.songs, :as => :song})
      end
    end
  end

end
