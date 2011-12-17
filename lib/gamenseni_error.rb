class GamenseniError < Exception
  attr_accessor :message
  def initialize arg
    @message = arg
  end
end
