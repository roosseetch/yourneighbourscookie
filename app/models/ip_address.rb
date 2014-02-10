class IpAddress
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Mongoid::MultiParameterAttributes
  include Mongoid::Attributes::Dynamic

  # store_in collection: "ipaddr", database: "hosts"
  store_in collection: "ipaddrs", database: "hosts"

  paginates_per 10

  field :ip_src, type: String
  field :http_host, type: String
  field :http_cookie, type: Array

  require 'csv'

  def self.import_h(file)
    CSV.foreach(file.path, {col_sep: "\t", :quote_char => "№", headers: true}) do |row|
      if self.where(ip_src: row['ip.src'], http_host: row['http.host']).exists?

        cookie_hash_update(row['ip.src'], row['http.host'], row['http.cookie'])

      else
        @ip_host_url = new(ip_src: row['ip.src'], http_host: row['http.host'])
        @ip_host_url.save(validate: false)

        cookie_hash_update(row['ip.src'], row['http.host'], row['http.cookie'])

      end
      # debugger
    end
  end

  def self.import_s(file)
    CSV.foreach(file.path, {col_sep: "\t", :quote_char => "№", headers: true}) do |row|
      if self.where(ip_src: row['ip.src'], http_host: row['http.host']).exists?

        cookie_str_update(row['ip.src'], row['http.host'], row['http.cookie'])

      else
        @ip_host_url = new(ip_src: row['ip.src'], http_host: row['http.host'])
        @ip_host_url.upsert

        cookie_str_update(row['ip.src'], row['http.host'], row['http.cookie'])

      end
      # debugger
    end
  end

  private
    def self.string_to_hash(str)
      str.split(/; /).inject(Hash.new{|h,k|h[k]=''}) do |h, s|
        k,v = s.split('=', 2)
        k = k.gsub('.','[dot]')
        k += '1'  if k == 'id'|| k == '_id'
        h[k] = v
        # h
        h.symbolize_keys!
      end
    end

  private
    def self.cookie_hash_update(row_ip_src, row_http_host, row_http_cookie)
      if row_http_cookie
        @ip_host_url = self.where(ip_src: row_ip_src, http_host: row_http_host)

        string_to_hash(row_http_cookie).each do |a|
          # debugger
          @ip_host_url.add_to_set(Hash[*a])
        end
      end
    end

  private
    def self.cookie_str_update(row_ip_src, row_http_host, row_http_cookie)
      if row_http_cookie
        @ip_host_url = self.where(ip_src: row_ip_src, http_host: row_http_host)

        row_http_cookie.split(/; /).each do |s|
          # debugger
          @ip_host_url.add_to_set(http_cookie: s)
        end
      end
    end

  def self.csv_header
    "frame_time,ip_src,ip_dst,http_host,http_request_uri,http_cookie".split(',')
  end

end
