class Mixtape < ActiveRecord::Base
  has_many :mixtape_songs
  has_many :songs, :through => :mixtape_songs
  belongs_to :owner, :class_name => 'User'

  has_many :user_mixtapes
  has_many :users, :through => :user_mixtapes

  accepts_nested_attributes_for :songs

  after_create :add_owner_permission

  def self.authorize(*args)
    args.each do |arg|
      define_method :"#{arg}able_by?" do |user|
        !!user_mixtapes.find_by_user_id(user).try(:"#{arg}able?")
      end
    end
  end

  authorize :edit, :listen, :destroy

  def songs_to_add_by_song_id=(song_ids)
    # Add the Songs in song_ids to the mixtape
    self.songs << song_ids.map{|song_id| Song.find song_id}
  end

  def add_user(u, permission)
    self.user_mixtapes.create(:user => u).set_permission(permission)
  end

  # def listenable_by?(user)
  #   self.user_mixtapes.find_by_user_id(user).try(:listenable?)
  # end

  # def method_missing(method, *args)
  #   # if the method contains able_by? then run permission check
  #   if method.match /able_by\?$/
  #     action = method.to_s.gsub("_by?", "?")
  #     self.user_mixtapes.find_by_user_id(args).try(action.to_sym)
  #   else
  #     super
  #   end
  # end

  private
    def add_owner_permission
      self.add_user(self.owner, :own)
    end
end


