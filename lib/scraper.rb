require "nokogiri"
require "open-uri"
require "pry"

require_relative "./movie.rb"
module Top100Movies
    class Scraper 

        def self.scrape_movie_index
            doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/"))
            doc.css(".table tr").drop(1).each.with_index(1) do |row, index|
                rank = index
                title = row.css(".articleLink").text.strip
                link = row.css(".articleLink").attribute("href").value
                rating = row.css(".tMeterScore").text
                Top100Movies::Movie.new(rank, title, rating, link)
            end
        end

        def self.scrape_movie_summary(movie)
            doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/#{movie.link}"))
            movie.summary = doc.css(".what-to-know__section-body span").text
            binding.pry
        end
    end
end

Top100Movies::Scraper.scrape_movie_index
Top100Movies::Scraper.scrape_movie_summary(Movie.all[0])