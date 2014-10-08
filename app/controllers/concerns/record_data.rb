module RecordData
  extend ActiveSupport::Concern
  included do
    class << self
      def record url, ip, country, city, article_id, user_id
        create! url: url, ip: ip, country: country, city: city,
          article_id: article_id, user_id: user_id
      end
    end
  end
end