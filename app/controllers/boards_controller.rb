require 'textmood'
class BoardsController < ApplicationController
  def show
    @comparisons_all = current_user.comparisons
    @comparisons = @comparisons_all.select do |comparison|
      comparison.articles_one.present?
      selected_articles_one = JSON.parse(comparison.selected_articles_one)
      selected_articles_two = JSON.parse(comparison.selected_articles_two)
      comparison.update(sentiment_one: avg_textmood(selected_articles_one))
      comparison.update(sentiment_two: avg_textmood(selected_articles_two))
    end
  end

  def avg_textmood(articles)
    total_articles = articles.count
    tm = TextMood.new(language: "en", normalize_score: true)
    sum_title = 0
    sum_description = 0
    articles.each do |article|
      sum_title += tm.analyze(article["title"])
      sum_description += tm.analyze(article["description"])
    end
    # average_t = sum_title / total_articles
    # @average_title = stringify_sentiment(average_t)
    average_d = sum_description / total_articles
    stringify_sentiment(average_d)
  end

  def stringify_sentiment(number)
    case number
    when 75..100
      "Overwhelmingly positive"
    when 50..74
      "Very positive"
    when 25..49
      "Positive"
    when 10..24
      "Somewhat positive"
    when -10..9
      "Neutral"
    when -25..-11
      "Somewhat negative"
    when -50..-26
      "Negative"
    when -75..-51
      "Very negative"
    when -100..-76
      "Overwhelmingly negative"
    else
      "Unknown"
    end
  end
end
