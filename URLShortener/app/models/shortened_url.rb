# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :integer
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, uniqueness: true, presence: true
  validates :long_url, uniqueness: true, presence: true
  validates :submitter_id, presence: true

  def self.random_code
    SecureRandom.urlsafe_base64
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = self.random_code
    ShortenedUrl.create!(submitter_id: user.id, short_url: short_url, long_url: long_url)
  end

  belongs_to :submitter,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: 'User'

  has_many :visits,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: 'Visit'

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visits.where("created_at > ?", 10.minutes.ago).select(:user_id).uniq.count
  end
end
