module ApiHelpersHelper
  def err_resp(msg:)
    { "error" => { "msg" => msg } }
  end

  def ok_resp(payload:)
    { "res" => payload }
  end
end
