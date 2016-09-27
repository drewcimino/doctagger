### README

This application accepted uploaded doc(x) files and parses out all the content into taggable Document records.

It runs on Ruby 2.3.1, Rails 4.2.6, and Postgres.

### Setup

Is pretty standard. Clone the repo, then:

* `rake db:create` to set up your db
* `rake db:migrate` to make sure you've got the most recent schema
* `rspec` to make sure everything's working : )

### TODO

* Add Paperclip to Document for uploading files

* Add doc(x) parsing for populating Document#content from PaperClip attachments

* Switch to acts-as-taggable-on. It makes searching and sorting by tag very simple and has several features that would scale the Document tagging system much more efficiently, but we can cross that bridge when we get there.

* Fix Document#tag_match to not remove each tag as it's found. There's an issue if a single sentence contains th tag-phrase twice - the first sentence of the context for the second tag will have the tag-phrase that was targeted by the first tag missing. Do this by rewriting content parser to break up the whole document into sentences, and then for each sentence, create a Tag `sentence.scan(/tag_phrase/).count` times.
