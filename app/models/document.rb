class Document < ActiveRecord::Base
  has_many :tags, dependent: :destroy

  validates :provided_tags, :content, presence: true
  after_save :populate_tags#, if: :provided_tags_changed?

  def populate_tags
    tags.destroy_all
    self.tags = Tag.create(tag_list.map { |tag| tag_matches(tag) }.flatten)
  end

  def tag_matches(tag_phrase)
    scan_text    = content.dup
    matched_tags = []

    while match_data = scan_text.match(/([\.\?\!])?[^\.\?\!]*#{tag_phrase}[^\.\?\!]*[\.\?\!]*[^\.\?\!]*[\.\?\!]*/i)
      matched_tags << { label: tag_phrase, context: match_data[0].sub(/^[\.\?\!]/,'').strip }
      scan_text.sub! /#{tag_phrase}/, ''
    end

    matched_tags
  end

  def tag_frequency
    tag_list.map { |tag| { label: tag, count: tags.where(label: tag).count } }
  end

  def tag_list
    provided_tags.split(',').map(&:strip)
  end
end
