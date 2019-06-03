class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five
    self.first(5)
  end

  def self.dinghy
    self.where("length <?", 20)
  end

  def self.ship
    self.where("length >=?", 20)
  end

  def self.last_three_alphabetically
    self.order(name: :desc).first(3)
  end

  def self.without_a_captain
    self.all.select{|b| b.captain_id == nil}
  end

  def self.sailboats
    sailboats = []
    self.all.each do |b|
      b.classifications.each do |c|
        if c.name == "Sailboat"
          sailboats << b
          break
        end
      end
    end
    sailboats
  end

  def self.with_three_classifications
    self.all.select {|b| b.classifications.size == 3}
  end
end
