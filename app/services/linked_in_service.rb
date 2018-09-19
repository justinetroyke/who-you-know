class LinkedInService
  def initialize(api_key)
    @api_key = api_key
  end

  def get_linkedin_id
    response = get_id
    body = JSON.parse(response.body)
    body["id"]
  end

  private
    def conn
      Faraday.new(url: 'https://api.linkedin.com') do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end

    def get_id
      conn.get('/v2/me/') do |request|
        request.headers['Host'] = 'api.linkedin.com'
        request.headers['Connection'] = 'Keep-Alive'
        request.headers['Authorization'] = "Bearer #{@api_key}"
      end
    end
end
