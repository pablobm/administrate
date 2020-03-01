module Administrate
  class ResourcePaginator
    def initialize(resources)
      @resources = resources
    end

    def paginate(page_number:, page_size:)
      resources.page(page_number).per(page_size)
    end

    private

    attr_reader :resources
  end
end
