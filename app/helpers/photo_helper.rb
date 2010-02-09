module PhotoHelper

  def latlng_map_url(photo)
    return "" unless photo.lat_lng

    # http://code.google.com/apis/maps/documentation/staticmaps/
    lat_lng = photo.lat_lng.join(',')
    opts = {
      :center => lat_lng,
      :maptype => 'roadmap',
      :markers => "color:red|label:A|#{lat_lng}",
      :size => "300x150",
      :zoom => '14',
      :sensor => "false",
      :key => Geokit::Geocoders::google 
    }

    "http://maps.google.com/maps/api/staticmap?" + 
      opts.map {|k,v| "#{k}=#{url_escape(v)}"}.join('&')
  end

  def latlng_map_link_url(photo)
    return "" unless photo.lat_lng

    lat_lng = photo.lat_lng.join(',')
    opts = {
      :center => lat_lng,
      :q => lat_lng,
      :maptype => 'roadmap',
      :zoom => '14',
    }

    "http://maps.google.com/maps?" + 
      opts.map {|k,v| "#{k}=#{url_escape(v)}"}.join('&')
  end

private

  def url_escape(string)
    string.gsub(/([^ a-zA-Z0-9_.-]+)/n) do
      '%' + $1.unpack('H2' * $1.size).join('%').upcase
    end.tr(' ', '+')
  end

  def url_unescape(string)
    string.tr('+', ' ').gsub(/((?:%[0-9a-fA-F]{2})+)/n) do
      [$1.delete('%')].pack('H*')
    end
  end
end
