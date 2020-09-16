module Megacorp
  class Indexer
    include SearchClient

    attr_accessor :employees

    def index_employees
      employees.each_with_index do |employee, i|
        search_client.index(
          id: i,
          index: 'employee',
          body: employee
        )
      end
    end

    def employees
      @employees ||= JSON.parse(File.read('./examples/megacorp/employees.json'))
    end
  end
end
