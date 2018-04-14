class Retry
  class Log < ::Log
    def tag!(tags)
      tags << :retry
      tags << :library
      tags << :verbose
    end
  end
end
