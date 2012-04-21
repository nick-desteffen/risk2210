class Faction
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name, type: String
  field :classification, type: String
  field :abilities, type: String
  field :starting_resources, type: String
  field :official, type: Boolean, default: true

  has_many :game_players

  slug :name
  
  attr_accessible :name, :classification, :starting_resources, :abilities, :official
  
  validates_presence_of :name, :classification, :starting_resources, :abilities
  
  def starting_resources
    read_attribute(:starting_resources).split("\n")
  end

  def self.random
    Faction.all.sample(1).first
  end

  def self.non_default
    all.reject{|faction| faction.name == "Default"}
  end
    
end
