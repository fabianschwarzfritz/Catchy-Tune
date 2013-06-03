module TracksHelper
  module ParamsExtensions
    def entity_params
      self.reject { |key,| key == 'file' }
    end
  end
end
