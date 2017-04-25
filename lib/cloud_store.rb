class CloudStore
  class Substitute < StandardError; end

  def self.included(cls)
    cls.extend Configure
  end

  def upload(file)
    destination = ::File.absolute_path("tmp/files/#{DateTime.now.strftime('%Y%m%d%H%M%S%L')}-#{::File.basename(file)}")

    begin
      ::FileUtils.cp file, destination
      return [true, {address: destination}]
    rescue => error
      return [false, {error: error.message}]
    end
  end


  def self.configure(receiver)
    instance = new
    receiver.cloud_store = instance
    instance
  end
end
