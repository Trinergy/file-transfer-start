class CloudStore
  class Error < RuntimeError; end

  def self.included(cls)
    cls.extend Configure
  end

  def upload(file)
    # Call to AWS
    return [true, {address: "https://aws_s3/bucket_id/${file.path}"}] #[false, {error: "invalid file type"}]
  end


  def self.configure(receiver)
    instance = new
    receiver.cloud_store = instance
    instance
  end
end
