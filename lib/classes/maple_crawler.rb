# encoding: utf-8
class MapleCrawler
  include Crawler

  def parse_dramas area
    nodes = @page_html.css(".yearSorting li")
    nodes.each do |node|
      year = node.css("h2").text
      links = node.css("a")
      links.each do |link|
        url = "http://www.maplestage.com" + link[:href]
        # puts url
        crawler = MapleCrawler.new
        crawler.fetch url
        crawler.parse_drama(year,area)
      end
    end
  end

  def parse_drama(year,area)
    
    a = Area.find_by_name(area)

    title = @page_html.css("h1.title").text
    titles = title.split("/")
    titles.each{|title| title.strip!}
    body_node = @page_html.css(".show_body")
    pic_url = body_node.css("p img")[0][:src]
    summary = body_node.css("p")[2] if body_node.css("p")[2]
    summary = body_node.css("p")[1] if (body_node.css("p")[1] && (summary.blank?)) 
    summary = body_node.css("p")[0] if (body_node.css("p")[0] && (summary.blank?)) 
    puts @page_url + "  do not have summary" unless summary
    
    intro = summary.to_html
    # intro = intro.gsub("<p>","")
    # intro = intro.gsub("</p>","")
    # intro = intro.gsub("<b>","")
    # intro = intro.gsub("</b>","")
    intro = intro.gsub("<br>","\n")
    n = Nokogiri::HTML(intro)
    intro = n.text
    # brs = body_node.css("text")
    # actors = ""
    # directors = ""
    # intro = ""
    
    # index = summary.index("編劇")
    # intro = summary[0..index]  if index
    # index_directors = summary.index("导演")
    # intro = summary[0..index_directors]  if intro.blank? if index_directors
    # index_actors = summary.index("演出")
    # intro = summary[0..index_actors]  if intro.blank? if index_actors
    
    # if index_actors
    #   actors = summary[index_actors..summary.length]
    #   actors = actors.split(":")[1].strip
    # end

    # if index_actors && index_directors
    #   directors = summary[index_directors..index_actors-1]
    #   directors = directors.split(":")[1].strip
    # end

    # arrays.each do |text|
    #   if text.include?("演出")
    #     actors = text
    #     actors = actors.split(":")[1]
    #   end
    #   if text.include?("导演")
    #     directors = text
    #     directors = directors.split(":")[1]
    #   end
    # end

    drama = Drama.find_by_name(titles[0])
    drama = Drama.new unless drama
    drama.name = titles[0]
    drama.name_en = titles[1]
    drama.poster_url = pic_url
    drama.introduction = intro
    drama.release_date = year
    # drama.actors = actors
    # drama.directors = directors
    drama.link = @page_url
    drama.area = a
    drama.save

    puts " drama : #{drama.name} #{drama.name_en} #{drama.poster_url} #{drama.introduction} #{drama.release_date} #{drama.area.name} #{drama.directors} #{drama.actors}"
  end

  def parse_ep drama
    shows = @page_html.css(".shows .show a")
    title = shows.text    
    shows.each do |show|
      ep = Ep.find_by_title(show.text)
      ##### 
      # next if ep
      #####
      ep = Ep.new unless ep
      ep.title = show.text
      ep.drama = drama
      next unless /第(\d*)集/ =~ ep.title
      ep.num = $1
      ep.save
      puts "ep: #{ep.title} #{ep.drama.name}"
      url = show[:href]
      crawler = MapleCrawler.new
      crawler.fetch url
      crawler.parse_source(ep)
    end   
  end

  def parse_source ep

    ep.youtube_sources.each{|s| s.delete}
    
    if @page_html.css(".video_ids").present?
      id_text = @page_html.css(".video_ids").text

      ids = id_text.split(",")
      ids.each do |id|
        source = YoutubeSource.new
        source.ep = ep
        source.link = "http://www.youtube.com/watch?v=" + id
        source.save
        puts "ids source: #{source.link} #{source.ep.title}"
      end
    elsif @page_html.css(".tmp_controls a").present?
      nodes = @page_html.css(".tmp_controls a")
      nodes.each do |node|
        source = YoutubeSource.new
        source.ep = ep
        source.link = node[:href]
        source.save
        puts "tmp_controls source: #{source.link} #{source.ep.title}"
      end
    elsif @page_html.css(".videoGroup iframe").present?
      nodes = @page_html.css(".videoGroup iframe")
      nodes.each do |node|
        source = YoutubeSource.new
        source.ep = ep
        source.link = node[:src]
        source.save
        puts "video group source: #{source.link} #{source.ep.title}"
      end
    elsif @page_html.css("#WATPlayerInstance").present?
      nodes = @page_html.css("#WATPlayerInstance")
      nodes.each do |node|
        src = node[:data]
        /swf2\/(.*)/ =~ src
        src = "http://www.wat.tv/embedframe/" + $1
        source = YoutubeSource.new
        source.ep = ep
        source.link = src
        source.save
        puts "wat source: #{source.link} #{source.ep.title}"
      end
    elsif @page_html.css(".node_body iframe").present?
      node = @page_html.css(".node_body iframe")[0]
      source = YoutubeSource.new
      source.ep = ep
      src = node[:src]
      if src.index("youtube")
        /embed\/(.*)/ =~ src
        ($1.index("/")) ? (src = $1[0..$1.index("?")-1]) : (src = $1)
        src = "http://www.youtube.com/watch?v=" + src
      end
      source.link = src
      source.save
      puts "iframe source: #{source.link} #{source.ep.title}"
    elsif @page_html.css("center embed").present?
      nodes = @page_html.css("center embed")

      if @page_html.css("center object").present?
        nodes = @page_html.css("center object")
        nodes.each do |node|
          html_text = node.to_html
          if (html_text.index('youtube') | html_text.index('mediaservices'))
            source = YoutubeSource.new
            source.ep = ep
            source.embed_text = html_text
            source.save
            source.link = "106.187.51.230:8000/videos/#{source.id}"
            source.save
            puts "source: #{source.link} #{source.ep.title}"
          else
            save_maple ep
          end
        end
      else
        nodes.each do |node|
          html_text = node.to_html
          if (html_text.index('pptv')|html_text.index('youtube'))
            source = YoutubeSource.new
            source.ep = ep
            source.embed_text = html_text
            source.save
            source.link = "106.187.51.230:8000/videos/#{source.id}"
            source.save
            puts "source: #{source.link} #{source.ep.title}"
          end
        end
    else
      save_maple ep
    end
  end

  def save_maple ep
    source = YoutubeSource.new
    source.ep = ep
    source.link = @page_url
    source.save
    puts "source: #{source.link} #{source.ep.title}"
  end

end