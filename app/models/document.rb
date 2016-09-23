class Document < ActiveRecord::Base
  validates :provided_tags, :content, presence: true

  def tag_matches(tag_phrase)
    scan_text    = content.dup
    matched_tags = []

    while match_data = scan_text.match(/([\.\?\!])?[^\.\?\!]*#{tag_phrase}[^\.\?\!]*[\.\?\!]*[^\.\?\!]*[\.\?\!]*/i)
      matched_tags << { label: tag_phrase, context: match_data[0].sub(/^[\.\?\!]/,'').strip }
      scan_text.sub! /#{tag_phrase}/, ''
    end

    matched_tags
  end
end
