class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    longest = 0
    boat = nil
    self.all.each do |c|
      c.boats.each do |b|
        if b.length > longest
          longest = b.length
          boat = b
        end
      end
    end
    boat.classifications
  end
end
