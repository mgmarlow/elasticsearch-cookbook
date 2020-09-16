require 'elasticsearch'
require 'elasticsearch/dsl'
require 'json'
require 'open-uri'

require 'megacorp/search_client'
require 'megacorp/indexer'
require 'megacorp/search_service'

module Megacorp
  module_function

  def seed_employees
    indexer.index_employees
  end

  def seed_advice
    indexer.index_advice
  end

  def search(body)
    search_service.execute_search(body)
  end

  def indexer
    @indexer || Indexer.new
  end

  def search_service
    @search_service ||= SearchService.new
  end
end
