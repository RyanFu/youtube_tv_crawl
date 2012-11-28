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
end