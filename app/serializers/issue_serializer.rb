class IssueSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :status
end
