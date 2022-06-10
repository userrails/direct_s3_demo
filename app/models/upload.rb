class Upload < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  validates :file, presence: true

  def expiring_url seconds_to_expiry = 20
    bucket = Aws::S3::ExtractsBucket.new
    bucket.presigner.presigned_url :get_object, bucket: ENV["S3_BUCKET"], key: file.key, expires_in: seconds_to_expiry
  end
end
