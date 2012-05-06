$(function(){
  $("#song_artist_id").chosen();
  $("#song_genre_names").tokenInput('/genres.json', {
    theme: 'facebook',
    allowCustomEntry: true,
    prePopulate: $("#song_genre_names").data("genres")
  })
});