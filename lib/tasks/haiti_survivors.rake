#
# Copyright (C) 2007 IBM Corporation
# San Jose, CA USA
#

require 'rake/gempackagetask'
require File.dirname(__FILE__) + '/../../config/haiti_survivors'

namespace :haiti_survivors do
  GEM_SPEC = Gem::Specification.new do |s|
    s.name = 'haiti_survivors'
    s.version = "#{VERSION_STRING}"
    s.summary = %{This RoR Facebook application allows quick updates and info on survivors of the January 12th, 2010 earthquake in Haiti.}
    s.authors = 'IBM Research - Almaden'
    s.email = 'maxim@us.ibm.com'
    s.homepage = 'http://apps.facebook.com/haiti_quake_survivors/'
    
    s.add_dependency "capistrano", "= 1.4.1"
    s.add_dependency "cgi_multipart_eof_fix", "= 2.1"
    s.add_dependency "curb", "= 0.3.2"
    s.add_dependency "fastthread", "= 1.0"
    s.add_dependency "ferret", "= 0.11.4"
    s.add_dependency "gem_plugin", "= 0.2.2"
    s.add_dependency "hpricot", "= 0.6"
    s.add_dependency "icalendar", "= 1.1.0"
    s.add_dependency "mongrel", "= 1.1.5"
    s.add_dependency "multi", "= 0.1"
    s.add_dependency "needle", "= 1.3.0"
    s.add_dependency "net-sftp", "= 1.1.0"
    s.add_dependency "net-ssh", "= 1.1.2"
    s.add_dependency "rails", "= 2.3.2"
    s.add_dependency "rake", "= 0.7.3"
    s.add_dependency "ruby-debug", "= 0.10.1"
    s.add_dependency "hoe", "= 1.6.0"
    s.add_dependency "json", "= 1.1.2"
    s.add_dependency "twitter", "= 0.8.0"
    s.add_dependency "bitly", "= 0.4.0"
    
    # Test files
    s.test_files = FileList['test/**/*']
    
    # Models, Controllers, Helpers, and Views files
    apis_files = FileList['app/apis/**/*']
    data_files = FileList['app/data/**/*']
    models_files = FileList['app/models/**/*']
    controllers_files = FileList['app/controllers/**/*']
    helpers_files = FileList['app/helpers/**/*']
    views_files = FileList['app/views/**/*']
    
    # Config files
    config_files = FileList['config/**/*']
    
    # lib files
    lib_files = FileList['lib/**/*']
    
    # DB files
    db_files = FileList['db/**/*']
    
    # Vendor plugins, rails, and other files
    vendor_files = FileList['vendor/plugins/**/*', 'vendor/rails/**/*', 'vendor/gems/**/*']
    
    # Other files
    other_files = FileList['README', 'Rakefile', 'script/**/*', 'public/**/*', 'components/**/*', 'daemon.sh', 'switch_facebooker.sh']
    
    # All other files
    s.files = apis_files + data_files + models_files + controllers_files + helpers_files + views_files + config_files + db_files + lib_files + vendor_files + other_files
  end
  
  desc "Generates the LegalTorrents gem with tasks: package, clobber_package, and repackage"
  Rake::GemPackageTask.new(GEM_SPEC) do |pkg|
    pkg.need_zip = true
    pkg.need_tar = true
  end
  
  private

  def create_files_for suffix, root_dir
    puts "Invalid environment #{suffix}" if suffix != 'local' and suffix != 'server'
    file_names = FileList["#{root_dir}/**/*"]
    ['.', '..', '.svn'].each {|dir_name| file_names.delete dir_name}
    
    puts file_names.inspect if @verbose
    file_names.each do |file_name|
      file_utils_class = @verbose ? FileUtils::Verbose : FileUtils
      file_utils_class.mv file_name, file_name.gsub("." + suffix, '') if file_name.include?(suffix)
    end
  end
end
