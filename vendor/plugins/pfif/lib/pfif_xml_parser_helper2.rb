require 'roxml'

module PfifXmlParserHelper2 #:nodoc:
  class PfifNoteData #:nodoc:
    include ROXML
    include Common::Creatable
    
    xml_name 'pfif:note'
    
    xml_accessor :pfif_note_record_id, :from => 'pfif:note_record_id'
    xml_accessor :pfif_entry_date, :from => 'pfif:entry_date'
    xml_accessor :pfif_author_name, :from => 'pfif:author_name'
    xml_accessor :pfif_author_email, :from => 'pfif:author_email'
    xml_accessor :pfif_author_phone, :from => 'pfif:author_phone'
    xml_accessor :pfif_source_date, :from => 'pfif:source_date'
    xml_accessor :pfif_found, :from => 'pfif:found'
    xml_accessor :pfif_email_of_found_person, :from => 'pfif:email_of_found_person'
    xml_accessor :pfif_phone_of_found_person, :from => 'pfif:phone_of_found_person'
    xml_accessor :pfif_last_known_location, :from => 'pfif:last_known_location'
    xml_accessor :pfif_text, :from => 'pfif:text'
  end
  
  class PfifPersonData #:nodoc:
    include ROXML
    include Common::Creatable
    
    xml_name 'pfif:person'
    
    xml_accessor :pfif_person_record_id, :from => 'pfif:person_record_id'
    xml_accessor :pfif_entry_date, :from => 'pfif:entry_date'
    xml_accessor :pfif_author_name, :from => 'pfif:author_name'
    xml_accessor :pfif_author_email, :from => 'pfif:author_email'
    xml_accessor :pfif_author_phone, :from => 'pfif:author_phone'
    xml_accessor :pfif_source_name, :from => 'pfif:source_name'
    xml_accessor :pfif_source_date, :from => 'pfif:source_date'
    xml_accessor :pfif_source_url, :from => 'pfif:source_url'
    xml_accessor :pfif_first_name, :from => 'pfif:first_name'
    xml_accessor :pfif_last_name, :from => 'pfif:last_name'
    xml_accessor :pfif_home_city, :from => 'pfif:home_city'
    xml_accessor :pfif_home_state, :from => 'pfif:home_state'
    xml_accessor :pfif_home_neighborhood, :from => 'pfif:home_neighborhood'
    xml_accessor :pfif_home_street, :from => 'pfif:home_street'
    xml_accessor :pfif_home_zip, :from => 'pfif:home_zip'
    xml_accessor :pfif_photo_url, :from => 'pfif:photo_url'
    xml_accessor :pfif_other, :from => 'pfif:other'
    
    xml_accessor :notes, :as => [PfifNoteData]
  end
  
  class PfifData #:nodoc:
    include ROXML
    include Common::Creatable
    
    xml_name 'pfif:pfif'
    
    xml_accessor :xmlns_pfif, :from => '@xmlns:pfif'
    xml_accessor :xmlns_xsi, :from => '@xmlns:xsi'
    xml_accessor :xsi_schemaLocation, :from => '@xsi:schemaLocation'
    
    xml_accessor :persons, :as => [PfifPersonData]
  end
end