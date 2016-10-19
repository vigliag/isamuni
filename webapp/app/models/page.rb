class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :user, foreign_key: "owner_id"

  def self.companies
    where(kind: Page::kinds[:company])
  end

  def self.communities
    where(kind: Page::kinds[:community])
  end

  def fb_id
    /www.facebook.com\/(\w+)/.match(fbpage)&.[](1)
  end

  def pic
    if fb_id
      "http://graph.facebook.com/#{fb_id}/picture"
    else
      nil
    end
  end

  def as_json(options={})
    super(only: [:id, :name, :description, :contacts, :links])
  end

  enum kind: [ :company, :community ]
  validates :name, presence: true
end
