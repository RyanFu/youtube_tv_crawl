class CrawlWorker
  include Sidekiq::Worker

  def perform(drama_id)
      drama = Drama.find(drama_id)
      c = MapleCrawler.new
      c.fetch drama.link
      c.parse_ep drama
  end
end