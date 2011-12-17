class ParameterError < Exception
  def initialize msg,parameter,value
    msg= "msg[#{msg}]/parameter[#{parameter}]/value[#{value}]"
    super msg
  end
end

