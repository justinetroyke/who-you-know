class CardSerializer < ActiveModel::Serializer
  attributes :id, :first_last_name, :company, :school, :job_title, :image_url, :profile_url
end
