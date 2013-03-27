# encoding: utf-8
namespace :crawl do
  task :crawl_drama => :environment do
    urls = {
      "台灣" => "http://www.maplestage.com/drama/tw/",
      "大陸" => "http://www.maplestage.com/drama/ch/",
      "韓國" => "http://www.maplestage.com/drama/kr/",
      "日本" => "http://www.maplestage.com/drama/jp/"
    }
    urls.each do |area,url|
      crawler = MapleCrawler.new
      #crawler.fetch url until ((crawler.page_html != nil) && (crawler.page_html.css(".yearSorting li") != nil))
      # puts "crawl_drama: " + url
      (1..100).each do |i|
        # puts i.to_s
        crawler.fetch url
        break if ((crawler.page_html != nil) && (crawler.page_html.css(".yearSorting li")[0] != nil))
      end

      crawler.parse_dramas area
    end
  end

  task :crawl_ep => :environment do
    dramas = Drama.all
    dramas.each do |drama|
      CrawlWorker.perform_async(drama.id)
    end
  end

  task :crawl_ep_single_thread => :environment do
    dramas = Drama.all
    dramas.each do |drama|
      c = MapleCrawler.new      
      #c.fetch drama.link until ((c.page_html != nil) && (c.page_html.css(".shows .show a") != nil))
      # puts "crawl_ep_single_thread: " + drama.link
      (1..100).each do |i|
        # puts i.to_s
        c.fetch drama.link
        break if ((c.page_html != nil) && (c.page_html.css(".shows .show a") != nil))
      end

      #puts "parse link: " + drama.link
      c.parse_ep drama
    end
  end

  task :regenerate_drama_eps_str => :environment do

    Ep.find_in_batches(:batch_size => 1000) do |eps|
      eps.each do |ep|
        ep.delete unless ep.num
      end
    end

    Drama.all.each do |drama|
      eps_id = Ep.where(:drama_id => drama.id).order("num ASC").map{ |e| e.num}
      str = eps_id.join(",")
      drama.eps_num_str = str
      drama.save
    end
  end
end