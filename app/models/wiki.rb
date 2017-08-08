class Wiki < ApplicationRecord
  belongs_to :user, optional: true
  has_many :wiki_collaborators
  has_many :collaborators, through: :wiki_collaborators, source: :user
end
