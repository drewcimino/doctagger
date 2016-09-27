class Document < ActiveRecord::Base
  has_many :tags, dependent: :destroy
  has_attached_file :original_document

  validates :original_document, :provided_tags, presence: true
  validates_attachment_file_name :original_document, matches: [/docx\z/,/doc\z/]
  validates_attachment_size :original_document, in: 0..1.megabytes

  after_save :parse_original_document_content
  after_save :populate_tags

  # One or more non-stop characters followed by one or more stop character (.?!)
  SINGLE_SENTENCE_REGEX = /[^\.\?\!]+[\.\?\!]/.freeze

  def parse_original_document_content
    parsed_doc = Docx::Document.open(original_document.path)
    update_column :content, parsed_doc.paragraphs.map(&:text).join(' ')
  end

  def populate_tags
    self.tags = Tag.create(tag_list.map { |tag| tag_matches(tag) }.flatten)
  end

  def tag_matches(tag_phrase)
    matched_tags = []
    sentences    = content.scan(SINGLE_SENTENCE_REGEX).map(&:strip)

    sentences.each_with_index do |sentence, sentence_position|
      sentence.scan(tag_phrase).count.times do
        matched_tags << { label: tag_phrase, context: "#{sentence} #{sentences[sentence_position + 1]}"}
      end
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
