class Post < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  belongs_to :user, class_name: "User", foreign_key: :user_id
  belongs_to :category
  belongs_to :approved, class_name: "User", foreign_key: :approved_id, optional: true

  has_many :conversations, dependent: :destroy
  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets, allow_destroy: true
  has_many :reviews, dependent: :destroy

  VALID_PHONE_REGEX = /((\+*)((0[ -]+)*|(91 )*)(\d{12}+|\d{10}+))|\d{5}([- ]*)\d{6}/

  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :phone_number, presence: true, length: { minimum: 10, maximum: 15 },
                    format: { with: VALID_PHONE_REGEX }
  validates :user_id, :category_id, :city, presence: true

  scope :yet_to_be_approved, ->{ where(approved_id: nil) }
  scope :approved, ->{ where.not(approved_id: nil) }

  settings do
    mappings dynamic: false do
      indexes :name, type: :text, analyzer: :english
      indexes :city, type: :text, analyzer: :english
      indexes :approved_id, type: :integer
    end
  end

  def self.search_approved(query)
    queries = []
    query.keys.each do |key|
      case key
      when "name"
        queries << { "match": { "name": query[key] } }
      when "city"
        queries << { "match": { "city": query[key] } }
      end
    end
   
    self.search({
      "query": {
        "bool": {
          "should": queries,
          "minimum_should_match": 1,
          "must": {
            "exists": {
             "field": "approved_id"
            }     
          }
        }
      }
    })
  end
end