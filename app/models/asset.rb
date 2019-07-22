class Asset < ApplicationRecord
  belongs_to :post
  has_attached_file :image, styles: { thumb: "100x100" }, keep_old_files: true

  validates_attachment_content_type :image, content_type: ["image/png","image/jpeg","image/gif"]
end