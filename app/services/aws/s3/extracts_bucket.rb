require 'aws-sdk-s3'

module Aws
  module S3
    class ExtractsBucket
      def self.put_object(*args)
        new.bucket.put_object(*args)
      end

      def self.objects
        new.bucket.objects
      end

      def bucket
        Aws::S3::Bucket.new(bucket_name, client: client)
      end

      def presigner
        signer = Aws::S3::Presigner.new({ client: client })
      end

      private

      def client
        Aws::S3::Client.new(
          credentials: credentials,
          region: ENV["AWS_REGION"]
        )
      end

      def credentials
        Aws::Credentials.new(
          ENV["AWS_ACCESS_KEY_ID"],
          ENV["AWS_SECRET_ACCESS_KEY"]
        )
      end

      def bucket_name
        ENV["S3_BUCKET"] || "bucket-export-demo-#{Rails.env}"
      end
    end
  end
end
