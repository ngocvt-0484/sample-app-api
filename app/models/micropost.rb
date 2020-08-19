class Micropost < ApplicationRecord
  MICROPOSTS_PARAMS_PERMIT = %i(content image).freeze

  belongs_to :user
  has_one_attached :image

  delegate :name, to: :user, prefix: true

  validates :user_id, presence: true
  validates :content, presence: true,
            length: {maximum: Settings.validations.post.content_length}
  validates :image,
            content_type: {in: Settings.validations.post.content_type_image},
            size: {less_than: Settings.validations.post.size_image.megabytes}

  scope :by_created_at, ->{order created_at: :desc}
  scope :by_user, ->(ids){where user_id: ids}

  def display_image
    image.variant resize_to_limit: [Settings.validations.post.width_size,
                                    Settings.validations.post.height_size]
  end
end
