class Click
  include RecordData
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Geocoder::Model::Mongoid

  field :ip, type: String
  field :url, type: String
  field :article_id, type: String
  field :user_id, type: String
  field :country, type: String
  field :city, type: String
  field :coordinates, type: Array

  geocoded_by :country
  geocoded_by :city

  belongs_to :article
  after_validation :geocode

  class << self
    def clicks_per_article_per_day
      map = %Q{
        function(){
          emit({created_at: this.created_at, article_id: this.article_id}, {count: 1});
        }
      }

      reduce = %Q{
        function(key, values) {
          var count = 0;
          values.forEach(function(v){
            count += v['count'];
          });
          return {count: count};
        }
      }
      click_count = map_reduce(map, reduce).out(inline: true)
      return click_count
    end

    def get_click_data
      daily_clicks = clicks_per_article_per_day
      click_data = []
      daily_clicks.each do |d|
        id = d["_id"]
        daily_clicks = d["value"]
        date = d["_id"]["created_at"]
        clicks = daily_clicks["count"]
        click_data << {date: date, clicks: clicks.to_i}
      end
      return click_data
    end

    def clicks_per_country
      map = %Q{
        function() {
          emit({country: this.country}, {count: 1});
        }
      }

      reduce = %Q{
        function(key, values) {
          var count = 0;
          values.forEach(function(v) {
            count += v['count'];
          });
          return {count: count};
        }
      }
      unique_clicks = map_reduce(map, reduce).out(inline: true)
      return unique_clicks
    end

    def get_click_by_country_data
      demographics = clicks_per_country
      @impressions_data = []

      demographics.each do |d|
        id = d["_id"]
        demo = d["value"]
        country = id["country"]
        visits = demo["count"]
        @impressions_data << {label: country, value: visits.to_i}
      end
      return @impressions_data
    end
  end
end
