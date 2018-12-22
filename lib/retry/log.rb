class Retry
  class Log < ::Log
    def tag!(tags)
      tags << :retry
    end
  end
end
