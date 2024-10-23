class Url < ApplicationRecord
    validates :original_url, presence: true, format: URI::regexp(%w[http https])
    validates :short_code, uniqueness: true
    
    before_create :generate_short_code
    after_initialize :set_default_access_count
  
    def generate_short_code
      self.short_code ||= SecureRandom.urlsafe_base64(6)
    end
  
    def set_default_access_count
      self.access_count ||= 0
    end
  end
  