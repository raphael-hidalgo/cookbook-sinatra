require "nokogiri"
require "open-uri"

class Parsing
  attr_reader :name, :rating, :description, :prep, :urls

  def initialize(ingredient)
    @ingredient = ingredient
    @urls = []
  end

  def scrape
    url = "https://www.allrecipes.com/search/results/?search=#{@ingredient}"
    doc = Nokogiri::HTML(URI.open(url).read, nil, "utf-8")
    @name = doc.search("body .card__title").text.split("\n").map { |i| i.strip }.select { |i| i if i != "" }[0..4]
    @rating = doc.search("body .card__ratingContainer .review-star-text").text.split(/\d\K\s/)[0..4]
    @description = doc.search(".card__detailsContainer-left .card__summary").text.split("\n").map { |i| i.strip }.select { |i| i if i != "" }[0..4]
    doc.search('.card__detailsContainer-left .card__titleLink').each do |url_recipe|
      @urls << url_recipe.attribute('href').value
    end
  end

  def scrape_prep(url)
    new_doc = Nokogiri::HTML(URI.open(url).read, nil, "utf-8")
    @prep = new_doc.search('.two-subcol-content-wrapper .recipe-meta-item-body').text.split(/mins\K\s/).first
  end
end
