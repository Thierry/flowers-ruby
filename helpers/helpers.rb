def update(c, id, params)
  object = c.get(id) or raise "Cannot find #{c.to_s.downcase}"
  object.maj(params) or raise "Error updating #{c.to_s.downcase}"
  object.to_json
end
