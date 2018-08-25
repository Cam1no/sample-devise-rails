module ImageHelper
  extend ActiveSupport::Concern

  included do
    has_many_attached :images
    scope :with_eager_loaded_image, -> { eager_load(images_attachments: :blob) }
    scope :with_preloaded_image, -> { preload(images_attachments: :blob) }
    scope :with_included_image, -> { includes(images_attachments: :blob) }
  end

  def service_urls
    images.map(&:service_url)
  end
end
