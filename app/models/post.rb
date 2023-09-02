class Post < ApplicationRecord
    extend FriendlyId
    validates :title, presence: true, length: { minimum: 5, maximum: 50 }
    validates :body, presence: true
    belongs_to :user
    has_many :comments, dependent: :destroy

    has_rich_text :body
    has_one :content, class_name: 'ActionText::RichText', as: :record, dependent: :destroy
  
    has_noticed_notifications model_name: 'Notification'
    has_many :notifications, through: :user

    friendly_id :title, use: %i[slugged history finders]

    def self.ransackable_attributes(auth_object = nil)
      ["title", "body", "user_email", "user_name"] 
    end
    
    def self.ransackable_associations(auth_object = nil)
      ["user", "comments", "notifications"] 
    end

    def should_generate_new_friendly_id?
      title_changed? || slug.blank?
    end
end