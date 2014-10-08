class Article
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps::Created

  field :title, type: String
  field :body, type: String
  field :_slugs, type: Array, default: []
  field :user_id, type: String

  is_impressionable

  slug :title, history: true
  belongs_to :user
  has_many :clicks

  def track_clicks_per_article
    clicks = Click.where article_id: self.id
    click_count = clicks.count
  end

  class << self
    def impressions_per_article_per_day
      map = %Q{
        function(){
          emit({created_at: this.created_at}, {count: 1});
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
      impression_count = map_reduce(map, reduce).out(inline: true)
      return impression_count
    end

    def get_impression_data
      daily_impressions = impressions_per_article_per_day
      @impressions_data = []
      daily_impressions.each do |d|
        id = d["_id"]
        daily_impressions = d["value"]
        date = d["_id"]["created_at"]
        impressions = daily_impressions["count"]
        @impressions_data << {date: date, impressions: impressions.to_i}
      end
      @impressions_data
    end
  end
end
