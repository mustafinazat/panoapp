class Page < ApplicationRecord

extend FriendlyId
 friendly_id :slug_candidates, use: [:slugged, :finders]
 def slug_candidates
    [
      [id.to_s, title.to_s.to_slug.normalize(transliterations: :russian).to_s]
    ]
  end


end


