require 'csv'

module CsvParserHelper
  def parse_models_from_csv model_name, csv_data
    model_hashes = []
    parsed_cvs = CSV.parse csv_data
    parsed_cvs.each do |tokens|
      case model_name
      when 'Location' : model_hashes << create_location_hash(tokens)
      when 'Survivor' : model_hashes << create_survivor_hash(tokens)
      end
    end
    model_hashes
  end
  
  protected
  
  # :name => 'Pacot',
  # :nickname => 'Pacot',
  # :street1 => 'Grand Rue',
  # :street2 => '',
  # :city => 'Port-au-Prince',
  # :country => 'Haiti',
  # :kind => 'Region',
  # :web_site_url => '',
  # :picture_url => '',
  # :description => ''
  def create_location_hash tokens
    location_hash = {}
    
    location_hash[:name] = tokens[0] unless tokens[0].nil?
    location_hash[:nickname] = tokens[1] unless tokens[1].nil?
    location_hash[:street1] = tokens[2] unless tokens[2].nil?
    location_hash[:street2] = tokens[3] unless tokens[3].nil?
    location_hash[:city] = tokens[4] || 'Port-au-Prince'
    location_hash[:country] = tokens[5] || 'Haiti'
    location_hash[:kind] = tokens[6] || 'Region'
    location_hash[:web_site_url] = tokens[7].strip unless tokens[7].nil?
    location_hash[:picture_url] = tokens[8].strip unless tokens[8].nil?
    location_hash[:description] = tokens[9] unless tokens[9].nil?
    
    location_hash
  end
  
  # :status => 'Missing',
  # :salutation => 'Mr',  
  # :first_name => 'Test', 
  # :middle_name => '', 
  # :last_name => 'Test', 
  # :suffix => '', 
  # :nickname => 'test', 
  # :location => '', 
  # :citizen_of => 'Haiti', 
  # :mobile_phone => '',  
  # :home_phone => '', 
  # :work_phone => '', 
  # :confirmed => '', 
  # :confirmation_source => '', 
  # :description => ''
  def create_survivor_hash tokens
    survivor_hash = {}
    
    survivor_hash[:status] = tokens[0] unless tokens[0].nil?
    survivor_hash[:salutation] = tokens[1] unless tokens[1].nil?
    survivor_hash[:first_name] = tokens[2] unless tokens[2].nil?
    survivor_hash[:middle_name] = tokens[3] unless tokens[3].nil?
    survivor_hash[:last_name] = tokens[4] unless tokens[4].nil?
    survivor_hash[:suffix] = tokens[5] unless tokens[5].nil?
    survivor_hash[:nickname] = tokens[6] unless tokens[6].nil?
    survivor_hash[:location] = tokens[7] unless tokens[7].nil?
    survivor_hash[:citizen_of] = tokens[8] || 'Haiti'
    survivor_hash[:mobile_phone] = tokens[9] unless tokens[9].nil?
    survivor_hash[:home_phone] = tokens[10] unless tokens[10].nil? 
    survivor_hash[:work_phone] = tokens[11] unless tokens[11].nil?
    survivor_hash[:confirmed] = tokens[12] unless tokens[12].nil?
    survivor_hash[:confirmation_source] = tokens[13] unless tokens[13].nil?
    survivor_hash[:description] = tokens[14] unless tokens[14].nil?
    
    survivor_hash
  end
end