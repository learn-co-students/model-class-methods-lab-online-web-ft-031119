class Captain < ActiveRecord::Base
  has_many :boats

  def classifications_names
    self.boats.collect{|boat| boat.classifications}.flatten.uniq.pluck(:name)
  end

  def self.catamaran_operators
    boats = Boat.all.select{|boat| boat.classifications.pluck(:name).include?("Catamaran") && boat.captain}
    boats.collect{|boat| boat.captain}.uniq
  end

  def self.sailors
    boats = Boat.all.select{|boat| boat.classifications.pluck(:name).include?("Sailboat") && boat.captain}
    boats.collect{|boat| boat.captain}.uniq
  end

  def self.talented_seafarers
    cs1 = Captain.all.select{|captain| captain.classifications_names.include?("Sailboat")}
    cs2 = Captain.all.select{|captain| captain.classifications_names.include?("Motorboat")}
    cs = cs1 & cs2
  end

  def self.non_sailors
    Captain.all.select{|captain| !captain.classifications_names.include?("Sailboat")}
  end
end
