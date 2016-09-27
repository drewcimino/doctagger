class Document < ActiveRecord::Base
  has_many :tags, dependent: :destroy
  has_attached_file :original_document

  validates :original_document, :provided_tags, presence: true
  validates_attachment_file_name :original_document, matches: [/docx\z/,/doc\z/]
  validates_attachment_size :original_document, in: 0..1.megabytes

  after_save :parse_original_document_content
  after_save :populate_tags

  def parse_original_document_content
    parsed_doc = Docx::Document.open(original_document.path)
    update_column :content, parsed_doc.paragraphs.map(&:text).join(' ')
  end

  def populate_tags
    tags.destroy_all
    self.tags = Tag.create(tag_list.map { |tag| tag_matches(tag) }.flatten)
  end

  def tag_matches(tag_phrase)
    scan_text    = content.dup
    matched_tags = []

    while match_data = scan_text.match(/([\.\?\!])?[^\.\?\!]*#{tag_phrase}[^\.\?\!]*[\.\?\!]*[^\.\?\!]*[\.\?\!]*/i)
      matched_tags << { label: tag_phrase, context: match_data[0].sub(/^[\.\?\!]/,'').strip }
      scan_text.sub! /#{tag_phrase}/i, ''
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
