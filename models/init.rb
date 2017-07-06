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

  require_relative 'user.rb'
  require_relative 'account.rb'
  require_relative 'flower.rb'
  require_relative 'petal.rb'

