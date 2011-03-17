class FamilyMember < ActiveRecord::Base
  const_set 'MOTHER', 'Mother' unless defined? MOTHER
  const_set 'FATHER', 'Father' unless defined? FATHER
  const_set 'GRANDMOTHER', 'Grandmother' unless defined? GRANDMOTHER
  const_set 'GRANDFATHER', 'Grandfather' unless defined? GRANDFATHER
  const_set 'WIFE', 'Wife' unless defined? WIFE
  const_set 'HUSBAND', 'Husband' unless defined? HUSBAND
  const_set 'DAUGHTER', 'Daughter' unless defined? DAUGHTER
  const_set 'SON', 'Son' unless defined? SON
  const_set 'BROTHER', 'Brother' unless defined? BROTHER
  const_set 'SISTER', 'Sister' unless defined? SISTER
  const_set 'AUNT', 'Aunt' unless defined? AUNT
  const_set 'UNCLE', 'Uncle' unless defined? UNCLE
  const_set 'COUSIN', 'Cousin' unless defined? COUSIN

  const_set 'RELASHIONSHIPS', [MOTHER, FATHER, GRANDMOTHER, GRANDFATHER, WIFE, HUSBAND, DAUGHTER,
                               SON, BROTHER, SISTER, AUNT, UNCLE, COUSIN] unless defined? RELASHIONSHIPS

  belongs_to :user
  belongs_to :survivor

  acts_as_solr :fields => [:name, :relashionship, :description]
end