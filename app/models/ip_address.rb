class IpAddress
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "hosts", database: "ipaddr"

  def self.import!(file_path, {headers: :first_row})
    columns = []
    instances = []
    CSV.foreach(file_path) do |row|
      if columns.empty?
        # We dont want attributes with whitespaces
        columns = row.collect { |c| c.downcase.gsub(' ', '_') }
        next
      end

      instances << create!(build_attributes(row, columns))
    end
    instances
  end

  private

  def self.build_attributes(row, columns)
    attrs = {}
    columns.each_with_index do |column, index|
      attrs[column] = row[index]
    end
    attrs
  end

  def self.csv_header
    "ip.src,ip.dst,http.host,http.request.uri,http.cookie".split(',')
  end
end
