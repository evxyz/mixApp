class Song < ActiveRecord::Base
  validates :name, :length => {:in => 1..10}
  
  validate :must_be_good_music
  
  def must_be_good_music
    if !name.match /adele/
      errors.add(:base, "Song must be good")
    end
  end
  
end