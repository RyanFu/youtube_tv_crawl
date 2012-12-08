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
    intro = intro.gsub("<br>","\n")
    n = Nokogiri::HTML(intro)
    intro = n.text

    drama = Drama.find_by_name(titles[0])
    puts " drama : #{drama.name} #{drama.name_en} #{drama.poster_url} #{drama.introduction} #{drama.release_date} #{drama.area.name} #{drama.directors} #{drama.actors}" if drama
    return if drama
    
    return if discard_dramas titles[0]

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

  def discard_dramas title
    discard = %w(愛情闖進門 第8號當舖 大兵日记 華麗的挑戰 媳婦是怎樣煉成的 武則天祕史 紫禁驚雷 歡喜婆婆俏媳婦 金大班的最后一夜 李小龍傳奇 子夜 宮心計 鹿鼎記 順藤而上的你 需要浪漫 美味人生 傻瓜媽媽 女人的色彩 再見老婆 闭嘴家族 新妓生傳 豪門之路 對我說謊試試 鵲橋兄弟們 真心給我一滴淚 女人的香氣 我的愛在我身 光与影 守護老闆 惡作劇之吻\(韓版\) 檢察官公主 麵包王金卓求 檢察官公主 愛情的代價 燦爛的遺產 使的誘惑 千億寵愛在一身 我的野蠻王妃 愛情正在直播 愛在哈佛 城市獵人 兄妹契約 千次的吻 白戶修的事件簿 家政婦三田 深夜食堂 我和明星的99天 咩妹的完美執 很想見你 原来是美男啊 美丽人生 秘密花園 兄妹情深　蛋糕上的草莓 雙頭犬 絕對達令\(日版\) 上鎖的房間 不需要愛情的夏天 西洋古董 魔女的條件 一吻定情)
    discard << "Dream High 2"
    discard.each do |t|
      return true if title.index(t)
    end
    return false
  end

  def parse_ep drama
    shows = @page_html.css(".shows .show a")
    title = shows.text    
    shows.each do |show|
      ep = Ep.find_by_title(show.text)
      ##### 
      next if ep
      #####
      ep = Ep.new unless ep
      ep.title = show.text
      ep.drama = drama
      next unless /第(\d*)/ =~ ep.title
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
        source.link = youtube_link(node[:href])
        source.save
        puts "tmp_controls source: #{source.link} #{source.ep.title}"
      end
    elsif @page_html.css(".videoGroup iframe").present?
      nodes = @page_html.css(".videoGroup iframe")
      nodes.each do |node|
        source = YoutubeSource.new
        source.ep = ep
        source.link = youtube_link(node[:src])
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
      nodes = @page_html.css(".node_body iframe")

      nodes.each do |node|
        source = YoutubeSource.new
        source.ep = ep
        src = node[:src]
        if src.index("youtube")
          /embed\/(.*)/ =~ src
          ($1.index("/")) ? (src = $1[0..$1.index("?")-1]) : (src = $1)
          src = "http://www.youtube.com/watch?v=" + src
        end
        source.link = youtube_link(src)
        source.save
        puts "iframe source: #{source.link} #{source.ep.title}"
      end
    elsif @page_html.css("center embed").present?
      nodes = @page_html.css("center embed")
      
      video_flag = false
      if @page_html.css("center object").present?
        nodes = @page_html.css("center object")
        nodes.each do |node|
          html_text = node.to_html
          if (html_text.index('youtube') || html_text.index('mediaservices'))
            video_flag = true
            source = YoutubeSource.new
            source.ep = ep
            source.embed_text = html_text
            source.save
            source.link = "http://106.187.51.230:8000/videos/#{source.id}"
            source.save
            puts "source: #{source.link} #{source.ep.title}"
          end
        end
      else
        nodes.each do |node|
          html_text = node.to_html
          if (html_text.index('pptv') || (html_text.index('youtube') && !(html_text.index('enablejsapi'))) || html_text.index('macromedia'))
            video_flag = true
            source = YoutubeSource.new
            source.ep = ep
            source.embed_text = html_text
            source.save
            source.link = "http://106.187.51.230:8000/videos/#{source.id}"
            source.save
            puts "source: #{source.link} #{source.ep.title}"
          elsif (html_text.index('share.vrs.sohu') || html_text.index('player.56.com'))
            video_flag = true
            source = YoutubeSource.new
            source.ep = ep
            source.link = node[:src]
            source.save
            puts "embed video source: #{source.link} #{source.ep.title}"
          end
        end
      end

      save_maple ep unless video_flag
    elsif @page_html.css("center iframe").present?
      nodes = @page_html.css("center iframe")
      nodes.each do |node|
        source = YoutubeSource.new
        source.ep = ep
        source.link = youtube_link(node[:src])
        source.save
        puts "center iframe source: #{source.link} #{source.ep.title}"
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

  def youtube_link link
    if index = (/v=/ =~ link)
      v = link[index+2..index+12]
      "http://www.youtube.com/watch?v=" + v
    else
      link
    end
  end
end