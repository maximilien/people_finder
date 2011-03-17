module SurvivorUpdateHelper  
  const_set 'PHONED', 'Phoned' unless defined? PHONED
  const_set 'EMAILED', 'Emailed' unless defined? EMAILED
  const_set 'FRIEND', 'Friend' unless defined? FRIEND
  const_set 'NEWS_MEDIA_TV', 'News media TV' unless defined? NEWS_MEDIA_TV
  const_set 'NEWS_MEDIA_RADIO', 'News media radio' unless defined? NEWS_MEDIA_RADIO
  const_set 'FACEBOOK', 'Facebook' unless defined? FACEBOOK
  const_set 'TWITTER', 'Twitter' unless defined? TWITTER
  const_set 'OTHER', 'Other' unless defined? OTHER
  const_set 'CONFIRMATION_SOURCES', [PHONED, EMAILED, FRIEND, NEWS_MEDIA_TV,
                                     NEWS_MEDIA_RADIO, FACEBOOK, TWITTER, OTHER] unless defined? CONFIRMATION_SOURCES
end
