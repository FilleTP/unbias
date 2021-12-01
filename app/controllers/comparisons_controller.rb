require 'faraday'
require 'json'
require 'textmood'
require 'words_counted'
# maybe open-uri?
BASE_URL = "http://api.mediastack.com/v1/news?access_key=bc6099508dd0e4321fbe33e136b8cd96&languages=en"

class ComparisonsController < ApplicationController
  # before_action :show, :filter_sources
  def create
    @comparison = Comparison.new(strong_params)
    @comparison.user = current_user
    if @comparison.save
      redirect_to worldmap_comparison_path(@comparison)
    else
      render 'pages/home'
    end
  end

  def destroy
    @comparison = Comparison.find(params[:id])
    @comparison.destroy
    redirect_to board_path
  end

  def worldmap
    @comparison = Comparison.find(params[:id])
    build_url(@comparison)

    payload(@url_cnn_worldmap)
    @articles_cnn = JSON.parse(@response.body)["data"]

    payload(@url_bbc_worldmap)
    @articles_bbc = JSON.parse(@response.body)["data"]

    payload(@url_fox_worldmap)
    @articles_fox = JSON.parse(@response.body)["data"]

    payload(@url_worldmap)
    @articles = JSON.parse(@response.body)["data"]

    @articles += @articles_cnn + @articles_bbc + @articles_fox

    avg_textmood(@articles)
    word_counter(@articles)
    generate_markers(@articles)
  end


  def generate_markers(articles)
    @sources = generate_sources(articles)
    @tally = tally(articles)
    # @tally[source['source_keyword']].to_i.times do
      @markers = @sources.geocoded.map do |source|
        filtered_articles = articles.select do |article|
          (article["source"] == source[:name]) || (article["source"] == source[:source_keyword])
        end

        words = word_counter(filtered_articles)

          {
            lat: source.latitude,
            lng: source.longitude,
            info_window: render_to_string(partial: "info_window", locals: { source: source, words: words }),
            image_url: helpers.asset_url(source.img)
            # info_window: render_to_string(partial: "info_window")
          }
      end
  end

  def update
    @comparison = Comparison.find(params[:id])
    if params[:comparison][:topic]
      if @comparison.update(topic: params[:comparison][:topic],
                            start_date: params[:comparison][:start_date],
                            end_date: params[:comparison][:end_date])
        redirect_to worldmap_comparison_path(@comparison)
      else
        :update
      end
    else
      if @comparison.update(publisher_one: params[:comparison][:publisher_one],
                            publisher_two: params[:comparison][:publisher_two])
        redirect_to comparison_path(@comparison)
      else
        :update
      end
    end
  end

  def show
    @comparison = Comparison.find(params[:id])

    if @comparison.selected_articles_one && @comparison.selected_articles_two
      @articles_one = JSON.parse(@comparison.selected_articles_one)
      @articles_two = JSON.parse(@comparison.selected_articles_two)
    else
      build_url(@comparison)
      payload(@url_one)
      @articles_one = JSON.parse(@response.body)["data"].first(10)
      @comparison.update(articles_one: JSON.parse(@response.body)["data"].to_json)
      @comparison.update(selected_articles_one: @articles_one.to_json)

      payload(@url_two)
      @articles_two = JSON.parse(@response.body)["data"].first(10)
      @comparison.update(articles_two: JSON.parse(@response.body)["data"].to_json)
      @comparison.update(selected_articles_two: @articles_two.to_json)
    end

    @source = Source.where(source_keyword: @articles_one[0]["source"])
    avg_textmood(@articles_one)
    @words_one = word_counter(@articles_one)

    @source_two = Source.where(source_keyword: @articles_two[0]["source"])
    avg_textmood(@articles_two)
    @words_two = word_counter(@articles_two)
  end

  def avg_textmood(articles)
    tm = TextMood.new(language: "en", normalize_score: true)
    @sources = generate_sources(articles)
    @tally = articles.map { |article| article["source"] }.tally

    articles.each do |article|
      article["sentiment_title_score"] = tm.analyze(article["title"])
      article["sentiment_title_string"] = stringify_sentiment(tm.analyze(article["title"]))
      article["sentiment_description_score"] = tm.analyze(article["description"])
      article["sentiment_description_string"] = stringify_sentiment(tm.analyze(article["description"]))
    end

    @averages = []

    @tally.each do |key, value|
      sum_title = 0
      sum_description = 0
      filtered_articles = articles.select do |article|
        article[key] = key
      end
      filtered_articles.each do |article|
        sum_title += article["sentiment_title_score"]
        sum_description += article["sentiment_description_score"]
      end

      average_t = sum_title / value
      @average_title = stringify_sentiment(average_t)
      average_d = sum_description / value
      @average_description = stringify_sentiment(average_d)

      @averages << { "#{key} " => { average_title: @average_title, average_description: @average_description } }
    end
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

  def word_counter(articles)
    stop_words = Article::STOPWORDS
    tokenized = ""
    articles.each do |article|
      tokenized += WordsCounted::Tokeniser.new(article["description"]).tokenise(exclude: stop_words).join(" ")
    end
      @words = WordsCounted.count(tokenized).token_frequency
  end

  def generate_sources(articles)
    @sources = Source.where(source_keyword: articles.map { |article| article["source"] })
          .or(Source.where(name: articles.map { |article| article["source"] }))
          .or(Source.where(name: articles.map { |article| article["source"].start_with?("BBC")}))
          .or(Source.where(name: articles.map { |article| article["source"].start_with?("CNN")}))
          .or(Source.where(name: articles.map { |article| article["source"].start_with?("FOX")}))
  end

  private

  def tally(articles)
    articles.map { |article| article["source"] }.tally
  end

  def strong_params
    params.require(:comparison).permit(:topic, :start_date, :end_date)
  end

  def build_url(comparison)
    keyword = "&keywords=#{comparison.topic}"
    date = "&date=#{comparison.start_date},#{comparison.end_date}"

    s_one = Source.where(id: @comparison.publisher_one)
    publisher_one = "&sources=#{s_one[0]["source_keyword"]}" if s_one[0] != nil

    s_two = Source.where(id: @comparison.publisher_two)
    publisher_two = "&sources=#{s_two[0]["source_keyword"]}" if s_two[0] != nil
    country_one = ""
    country_two = ""

    sources = []
    Source.all.each do |source|
      sources << source['source_keyword']
    end
    @url_worldmap = "#{BASE_URL}#{keyword}#{date}&sources=#{sources.join(',')},-cnn,-bbc,-foxnews&limit=100"
    @url_cnn_worldmap = "#{BASE_URL}#{keyword}#{date}&sources=cnn&limit=50"
    @url_bbc_worldmap = "#{BASE_URL}#{keyword}#{date}&sources=bbc&limit=50"
    @url_fox_worldmap = "#{BASE_URL}#{keyword}#{date}&sources=foxnews&limit=50"


    @url_one = "#{BASE_URL}#{keyword}#{date}#{publisher_one}#{country_one}"
    @url_two = "#{BASE_URL}#{keyword}#{date}#{publisher_two}#{country_two}"
  end

  def payload(url)
    retries = 0
    begin
      @response = Faraday.get(url) do |req|
        req.options.open_timeout = 20
        req.options.timeout = 20
      end
    rescue URI::InvalidURIError => exception
      Rollbar.error(exception)

    rescue JSON::ParserError => exception
      Rollbar.error(exception)

    rescue Faraday::ConnectionFailed
      if (retries += 1) <= 3
        sleep(retries * 3)
        retry
      end

    rescue Faraday::TimeoutError
      if (retries += 1) <= 3
        sleep(retries * 3)
        retry
      end
    end
  end
end
