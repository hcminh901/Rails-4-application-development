class Subdomain
  class << self
    def matches? request
      case request.subdomain
      when "www", "", nil
        false
      else
        true
      end
    end
  end
end