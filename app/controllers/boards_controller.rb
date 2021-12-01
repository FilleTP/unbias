class BoardsController < ApplicationController
  def show
    @comparisons_all = current_user.comparisons
    @comparisons = @comparisons_all.select do |comparison|
      comparison.articles_one.present?
    end
  end

  def avg_textmood(articles)
    tm = TextMood.new(language: "en", normalize_score: true)
    @source = Source.where(source_keyword: articles.map { |article| article["source"] })
         .or(Source.where(name: articles.map { |article| article["source"] }))
    @tally = articles.map { |article| article["source"] }.tally

    articles.each do |article|
      article["sentiment_title_score"] = tm.analyze(article["title"])
      article["sentiment_title_string"] = stringify_sentiment(tm.analyze(article["title"]))
      article["sentiment_description_score"] = tm.analyze(article["description"])
      article["sentiment_description_string"] = stringify_sentiment(tm.analyze(article["description"]))
    end
  end

end
