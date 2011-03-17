require 'roxml'
require 'common'

module PfifXmlParserHelper #:nodoc:
  class PfifNoteData #:nodoc:
    include ROXML
    include Common::Creatable
    
    xml_name 'pfif:note'
    
    xml_text :pfif_note_record_id, 'pfif:note_record_id'
    xml_text :pfif_entry_date, 'pfif:entry_date'
    xml_text :pfif_author_name, 'pfif:author_name'
    xml_text :pfif_author_email, 'pfif:author_email'
    xml_text :pfif_author_phone, 'pfif:author_phone'
    xml_text :pfif_source_date, 'pfif:source_date'
    xml_text :pfif_found, 'pfif:found'
    xml_text :pfif_email_of_found_person, 'pfif:email_of_found_person'
    xml_text :pfif_phone_of_found_person, 'pfif:phone_of_found_person'
    xml_text :pfif_last_known_location, 'pfif:last_known_location'
    xml_text :pfif_text, 'pfif:text'
  end
  
  class PfifPersonData #:nodoc:
    include ROXML
    include Common::Creatable
    
    xml_name 'pfif:person'
    
    xml_text :pfif_person_record_id, 'pfif:person_record_id'
    xml_text :pfif_entry_date, 'pfif:entry_date'
    xml_text :pfif_author_name, 'pfif:author_name'
    xml_text :pfif_author_email, 'pfif:author_email'
    xml_text :pfif_author_phone, 'pfif:author_phone'
    xml_text :pfif_source_name, 'pfif:source_name'
    xml_text :pfif_source_date, 'pfif:source_date'
    xml_text :pfif_source_url, 'pfif:source_url'
    xml_text :pfif_first_name, 'pfif:first_name'
    xml_text :pfif_last_name, 'pfif:last_name'
    xml_text :pfif_home_city, 'pfif:home_city'
    xml_text :pfif_home_state, 'pfif:home_state'
    xml_text :pfif_home_neighborhood, 'pfif:home_neighborhood'
    xml_text :pfif_home_street, 'pfif:home_street'
    xml_text :pfif_home_zip, 'pfif:home_zip'
    xml_text :pfif_photo_url, 'pfif:photo_url'
    xml_text :pfif_other, 'pfif:other'
    
    xml_object :notes, PfifNoteData, ROXML::TAG_ARRAY
  end
  
  class PfifData #:nodoc:
    include ROXML
    include Common::Creatable
    
    xml_name 'pfif:pfif'
    
    xml_attribute :xmlns_pfif, 'xmlns:pfif'
    xml_attribute :xmlns_xsi, 'xmlns:xsi'
    xml_attribute :xsi_schemaLocation, 'xsi:schemaLocation'
    
    xml_object :persons, PfifPersonData, ROXML::TAG_ARRAY
  end
end