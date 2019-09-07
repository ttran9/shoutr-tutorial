class ShoutSearchQuery
  def initialize(term:)
    @term = term
  end

  def to_relation
    Shout.where(id: (Shout.search { fulltext term }.hits.map(&:primary_key)))
    # if we do the below, then we won't be able to do any additional queries.
    # Shout.search { fulltext term }.results
  end

  private

  attr_reader :term

end