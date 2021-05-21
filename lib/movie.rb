module Top100Movies
    class Movie 

        attr_reader :rank, :title, :rating, :link

        @@all = []

        def initialize(rank, title, rating, link)
            @rank = rank
            @title = title
            @rating = rating 
            @link = link
            self.save
        end

        def save 
            @@all << self
        end

        def self.all 
            @@all
        end
    end
end