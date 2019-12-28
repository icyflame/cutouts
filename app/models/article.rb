class Article < ActiveRecord::Base
  belongs_to :user
  validates :link, :quote, presence: true
  validates :link, format: { with: URI::regexp, message: "field must be a valid URL: Include http or https in the URL." }
  default_scope { order(created_at: :desc) }
  enum visibility: [ :open, :unlisted, :closed ]

  # This function has become long and complicated because of 
  # a complex migration from the ActiveRecord serialized version of
  # arrays (stored as YAML) back to a normal comma-separated string
  def tags_array
    # http://stackoverflow.com/a/17641383/2080089
    return self.tags.split(',').uniq.map(&:strip)
  end

  def self.terms_query input
    "LOWER(quote) like LOWER('%#{input}%')
                 or LOWER(author) like LOWER('%#{input}%')
                 or LOWER(link) like LOWER('%#{input}%') 
                 or LOWER(tags) like LOWER('%#{input}')"
  end

  def self.search input
    return where(terms_query input)
  end

  def self.tags_query tags
    q1 = [ ]
    for i in tags
      q1.push "LOWER(tags) LIKE LOWER('%#{i}%')"
    end
    q1 = q1.join(" and ")
    return q1
  end

  def self.searchForTags tags
    return where(tags_query tags)
  end

  def self.searchForTagsAndTerms tags, terms
    q1 = tags_query tags
    q2 = terms_query terms

    return where("#{q1} and (#{q2})")
  end
end
