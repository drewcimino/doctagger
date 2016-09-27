### README

This application accepted uploaded doc(x) files and parses out all the content into taggable Document records.

It runs on Ruby 2.3.1, Rails 4.2.6, and Postgres.

### Setup

Is pretty standard. Clone the repo, then:

* `rake db:create` to set up your db
* `rake db:migrate` to make sure you've got the most recent schema
* `rspec` to make sure everything's working : )

### TODO

Add .doc parsing for populating Document#content from PaperClip attachments

* Switch to acts-as-taggable-on. It makes searching and sorting by tag very simple and has several features that would scale the Document tagging system much more efficiently, but we can cross that bridge when we get there.
