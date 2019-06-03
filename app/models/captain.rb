class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    find_captains ("Catamaran")
  end

  def self.sailors
    find_captains("Sailboat")
  end

  def self.talented_seafarers
    captains_1 = find_captains("Motorboat")
    captains = []
    captains_1.each do |captain|
      captain.boats.each do |b|
        b.classifications.each do |c|
          if c.name == 'Sailboat'
            captains << captain
          end
        end
      end
    end
    captains.uniq
  end

  def self.non_sailors
    sailor_captains = find_captains("Sailboat")
    captains = []
    self.all.each do |c|
      if !sailor_captains.include?(c)
        captains << c
      end
    end
    captains.uniq
  end

  private
  def self.find_captains (boat_type)
    captains = []
    self.all.each do |captain|
      captain.boats.each do |b|
        b.classifications.each do |c|
          #binding.pry
          if c.name == boat_type
            #binding.pry
            captains << captain
            break
          end
        end
      end
    end
    captains.uniq
  end
end
