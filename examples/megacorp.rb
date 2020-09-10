require 'elasticsearch'
require 'json'

require 'megacorp/client'
require 'megacorp/indexer'

module Megacorp
  module_function

  def seed_employees
    Indexer.new.index_employees
  end
end
