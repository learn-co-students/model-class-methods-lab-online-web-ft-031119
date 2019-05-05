class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.all[0,5]
  end

  def self.dinghy
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length >= 20")
  end

  def self.last_three_alphabetically
    Boat.all.sort_by{|boat| boat.name}[-3,Boat.all.count].reverse
  end

  def self.without_a_captain
    Boat.where(captain: [nil,""])
  end

  def self.sailboats
    Boat.all.select{|boat| boat.classifications.pluck(:name).include?("Sailboat")}
  end

  def self.with_three_classifications
    Boat.all.select{|boat| boat.classifications.count == 3}
  end

end
