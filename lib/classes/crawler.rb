module Crawler
  
  require 'nokogiri'
  require 'open-uri'
  
  attr_accessor :page_url, :page_html
  
  def fetch url
    @page_url = url
    @page_html = get_page(@page_url)   
  end

  def fetch_without_encode_url url
    @page_url = url
    @page_html = get_page_without_encode(@page_url)   
  end

  def post_fetch url, option
    @page_url = url
    url = URI.parse(url)
    resp, data = Net::HTTP.post_form(url, option)
    @page_html = Nokogiri::HTML(resp.body)
  end

  def get_page_without_encode url
    ecode_url = url
    body = ''
   begin
      open(ecode_url){ |io|
          body = io.read
      }
   rescue
   end
    doc = Nokogiri::HTML(body)
  end
  
  def get_page url
    # url = url.gsub(/\s+/, "")ex
    if /node\/\d*\/(.*)\// =~ url
      str = $1
      query_str = {:q => str}.to_query.gsub("q=","")
      url = url[0..url.index(str)-1] + query_str
    end

    ecode_url = URI.encode(url)
    body = ''

   begin
      open(ecode_url){ |io|
          body = io.read
      }
   rescue
    
    
   end
    doc = Nokogiri::HTML(body)

  end

  
  def get_item_href dns, src
    if (/^\/\// =~ src)
      src = "http:" + src
    elsif (/^\// =~ src)
      src = dns + src
    elsif (/\.\./ =~ src)
      src = dns + src[2..src.length]
    else
      src 
    end
  end
  
  def parse_dns
    url_scan = @page_url.scan(/.*?\//)
    dns = url_scan[0] + url_scan[1] + url_scan[2]
  end

  
end