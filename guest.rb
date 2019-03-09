require("pry")

class Guest

  attr_reader :name
  attr_accessor :wristband

  def initialize(name, money, fav_song)

    @name = name

    @money = money

    @fav_song = fav_song

    @wristband = false

  end

  def how_much_money()
    return @money
  end

  def spend_money(money)
    if @money >= money
      @money -= money
      return money
    else
      return 0
    end
  end

  def what_is_fav_song()
    return @fav_song
  end

 def cheer_for_song(song)
   return "Woooo! #{song.title}"
 end

 def boo()
   return "BOOOOO!"
 end

 def look_for_favourite_song(room)
   is_song_there = room.is_song_in_library?(@fav_song)
   if is_song_there == true
     cheer_for_song(@fav_song)
   else
     boo()
   end

 end

end
