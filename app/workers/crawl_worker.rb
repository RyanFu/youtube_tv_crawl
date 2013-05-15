class CrawlWorker
  include Sidekiq::Worker

  def perform(drama_id)
    begin
    #  drama = Drama.find(drama_id)
    #  c = MapleCrawler.new
    #  c.fetch drama.link
    #  c.parse_ep drama
    rescue
      puts "sidekiq error drama : #{drama_id}"
    end
  end
end