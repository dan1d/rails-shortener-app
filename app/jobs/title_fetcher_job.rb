class TitleFetcherJob < ApplicationJob
  queue_as :urgent
  discard_on SocketError
  
  def perform(*args)
    url = args.first
    url.update!(title: fetch_title(url.long_url))
  end

  def fetch_title(url)
    Net::HTTP.get(URI(url)) =~ /<title>(.*?)<\/title>/
    $1
  end
end
