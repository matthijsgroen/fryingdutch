class GameMetadata < ActiveRecord::Base

  belongs_to :game

  validates_url_format_of :website, :forum, :community_site, :developer_url, :allow_blank => true

end
