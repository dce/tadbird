require 'json'

class JSONStore
  def initialize(file)
    @filename = file

    @data = if File.exists? @filename
      JSON.parse(File.open(@filename).read)
    else
      {}
    end
  end

  def save
    File.open(@filename, "w") do |file|
      file << @data.to_json
    end
  end

  def method_missing(method, *args, &block)
    @data.send(method, *args, &block)
  end
end