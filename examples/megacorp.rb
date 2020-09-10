require 'elasticsearch'
require 'json'

require_relative 'megacorp/client'
require_relative 'megacorp/indexer'

module Megacorp
  module_function

  def seed_employees
    Indexer.new.index_employees
  end
end

Megacorp.seed_employees
