require 'elasticsearch'
require 'elasticsearch/dsl'
require 'json'

require 'megacorp/search_client'
require 'megacorp/indexer'
require 'megacorp/search_service'

module Megacorp
  module_function

  def seed_employees
    Indexer.new.index_employees
  end

  def search_service
    @search_service ||= SearchService.new
  end
end
