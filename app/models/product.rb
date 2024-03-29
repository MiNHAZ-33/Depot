class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|jpeg|png)\z/i,
    message: "must be a URL for GIF, JPG, JPEG or PNG"
  }

  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_items

  private
  def ensure_not_referenced_by_any_line_items
    unless line_items.empty?
      errors.add(:base, 'Line items present')
      throw :abort
    end
  end

end
