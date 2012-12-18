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
      crawler.fetch url
      crawler.parse_dramas area
    end
  end

  task :crawl_ep => :environment do
    dramas = Drama.all
    dramas.each do |drama|
      CrawlWorker.perform_async(drama.id)
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