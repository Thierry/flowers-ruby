class BaseModel
  def update_attributes(attributes)
    attributes.each {|attribute, value| self.write_attribute(attribute, value)}
    if self.new_record # if never saved save.
      save
    else # update attributes if we have saved.
      run_callbacks(:save) do
        update! do |u|
          attributes.each {|attribute, value| u.set attribute => self.read_attribute(attribute)}
        end
      end
    end
    self
  end

  def self.get!(id)
    self.find(id) or raise "Can't find object"
  end

  def self.get(id)
    self.find(id)
  end

  def self.maj(id,params)
    obj = self.get(id) or raise "Cannot find object"
    obj.maj(params)
  end

  def maj(params)
    self.update_attributes(params)
  end
end
