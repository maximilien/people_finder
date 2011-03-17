require 'pfif_xml_parser_helper'

module PfifDbHelper
  include PfifXmlParserHelper
  
  def domain_root_url
    "haiti-survivors.org"
  end
  
  def generate_persons pfif_xml
    pfif_data = parse_pfif pfif
    persons = []
    pfif_data.persons.each do |pfif_person_data|
      person = create_person pfif_person_data
      pfif_person_data.notes.each do |pfif_note_data|
        person.notes << create_note(pfif_person_data, pfif_note_data)
      end
      persons << person
    end
    persons
  end
  
  protected
  
  def create_note pfif_person_data, pfif_note_data
    #TODO complete
  end
  
  def create_person pfif_person_data
    #TODO complete
  end
  
  def generate_pfif_xml persons
    pfif = PfifData.create :xmlns_pfif => 'http://zesty.ca/pfif/1.1',
                           :xmlns_xsi => 'http://www.w3.org/2001/XMLSchema-instance',
                           :xsi_schemaLocation => 'http://zesty.ca/pfif/1.1 http://zesty.ca/pfif/1.1/pfif-1.1.xsd',
                           :persons => create_pfif_persons(persons)
    pfif.to_xml
  end
  
  def create_pfif_persons persons
    persons.collect {|person| create_pfif_persons(person)}
  end
  
  def create_pfif_notes notes
    notes.collect {|note| create_pfif_notes(note)}
  end
  
  def create_pfif_person person
    PfifPersonData.create :pfif_person_record_id => "#{domain_root_url}/person.#{person.id}",
                          :pfif_entry_date => "#{person.entry_date.strftime(fmt='%Y-%m-%dT%H-%M-%SZ')}",
      :pfif_author_name => person.author_name,
      :pfif_author_email => person.author_email,
      :pfif_author_phone => person.author_phone,
      :pfif_source_name => person.source_name,
      :pfif_source_date => "#{person.source_date.strftime(fmt='%Y-%m-%dT%H-%M-%SZ')}",
      :pfif_source_url => person.source_url,
      :pfif_first_name => person.first_name,
      :pfif_last_name => person.last_name,
      :pfif_home_city => person.home_city,
      :pfif_home_state => person.home_state,
      :pfif_home_neighborhood => person.home_neighborhood,
      :pfif_home_street => person.home_street,
      :pfif_home_zip => person.home_zip,
      :pfif_photo_url => person.photo_url,
      :pfif_other => person.other,
      :notes => create_pfif_notes(person.notes)
  end
  
  def create_pfif_note note
    PfifNoteData.create :pfif_note_record_id => "#{domain_root_url}/note.#{note.id}",
      :pfif_entry_date => "#{note.entry_date.strftime(fmt='%Y-%m-%dT%H-%M-%SZ')}",
      :pfif_author_name => note.author_name,
      :pfif_author_email => note.author_email,
      :pfif_author_phone => note.author_phone,
      :pfif_source_date => "#{note.source_date.strftime(fmt='%Y-%m-%dT%H-%M-%SZ')}",
      :pfif_found => note.found,
      :pfif_email_of_found_person => note.email_of_found_person,
      :pfif_phone_of_found_person => note.phone_of_found_person,
      :pfif_last_known_location => note.last_known_location,
      :pfif_text => note.text
  end
end