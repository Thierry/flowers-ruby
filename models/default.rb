module Updater
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
  end
end
class BaseModel
  include Updater

  def self.get(id)
    puts "call to selfget with id #{id}"
    self.find(id)
  end

  def get(id)
    puts "call to get with id #{id}"
    self.find(id)
  end

  def maj(params)
    self.update_attributes(params)
  end
end
