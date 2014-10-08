class PageImpression
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :impressionable_type, type: String
  field :impressionable_id, type: String
  field :user_id, type: String
  field :controller_name, type: String
  field :action_name, type: String
  field :view_name, type: String
  field :request_hash, type: String
  field :ip_address, type: String
  field :session_hash, type: String
  field :message, type: String
  field :referrer, type: String

  class << self
    def unique_impressions_per_day
      map = %Q{
        function(){
          emit(this['_id']['created_at'], {count: 1});
        }
      }
      reduce = %Q{
        function(key, values){
          var count = 0;
          values.forEach(function(v){
            count += v['count'];
          });
          return {count: count};
        }
      }
      unique_impressions = map_reduce(map, reduce).out(inline: true)
      return unique_impressions
    end
  end
end
