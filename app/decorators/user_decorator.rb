class UserDecorator < Draper::Decorator
  delegate_all

  def image
    object.image || 'no_picture.png'
  end
end
