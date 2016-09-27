### README

This application accepted uploaded doc(x) files and parses out all the content into taggable Document records.

It runs on Ruby 2.3.1, Rails 4.2.6, and Postgres.

For uploading doc files, we use a gem called DocRipper that depends on a piece of software called Antiword. If you don't have it, get it.

`brew install antiword`

### Setup

Is pretty standard. Clone the repo, then:

* `rake db:create` to set up your db
* `rake db:migrate` to make sure you've got the most recent schema
* `rspec` to make sure everything's working : )

### TODO

* Switch to acts-as-taggable-on. It makes searching and sorting by tag very simple and has several features that would scale the Document tagging system much more efficiently, but we can cross that bridge when we get there.

* Figure out if we really need .doc parsing going forward. Currently, we're using different gems for each file type. `docx` is a great gem for parsing documents with some nice semantic helpers built in (paragraphs, insert node, etc.), but it can't handle older, non-XML-based doc files. DocRipper is a convenient gem for that, but it relies on an external piece of software called Antiword, and is pretty gangster. You pass the file path into DocRipper::Rip and it throws a pile of text back at you. Effective, but a little rougher around the edges. Technically we could also use it for docx files, but we're using both for now because docx's additional capabilities will probably be useful as the functionality of the application expands.
