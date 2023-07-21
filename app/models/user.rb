class User < ApplicationRecord
  # Attributes: firstName, lastName, email, password
  has_many :advertisement

  validates :firstName, presence: true
  validates :lastName, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  validate :custom_name_validation

  def custom_name_validation
    unless valid_name?(firstName)
      errors.add(:firstName, 'is invalid')
    end

    unless valid_name?(lastName)
      errors.add(:lastName, 'is invalid')
    end
  end

  def valid_name?(string)
    return false unless string.present?
    return false unless string.is_a?(String)
    return false if string.length > 40
    return false if string.match?(/\A-|-\z/)
    return false unless string.match?(/\A(?:[A-Z][a-z]*|-?[А-ЯҐЄІЇ][а-яґєії]*)(?:-[A-Z][a-z]*|-?[А-ЯҐЄІЇ][а-яґєії]*)*\z/)
    return true
  end
end
