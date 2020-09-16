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

    def index_advice
      fetch_advice.each do |slip|
        search_client.index(
          id: slip["id"],
          index: 'advice',
          body: {
            text: slip["advice"]
          }
        )
      end
    end

    def employees
      @employees ||= JSON.parse(File.read('./examples/megacorp/employees.json'))
    end

    def fetch_advice
      threads = (1..10).map do
        Thread.new do
          data = URI.parse('https://api.adviceslip.com/advice').read
          JSON.parse(data)["slip"]
        end
      end

      threads.map(&:value)
    end
  end
end
