# 
# Helper module to facilitate Facbooker integration
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: http://goo.gl/s9uhf
#

module FacebookerHelper
  INVALID_CHARS = ["," , ".", "'", "`", "[", "]", "{", "}", "(", ")"]
  REPLACED_CHARS= {"," => " ", "." => " ", "[" => "-", "]" => "-", "{" => "-", "}" => "-", 
                   "(" => "-", ")" => "-", "'" => "_", "`" => "_"}
  
  def _fb_share_button class_param, params={}
    return %{<fb:share-button class='#{class_param}' href='#{params[:href]}'/>} if class_param == :url
    fbml = "<fb:share-button class='#{class_param}'>"
    params[:metas].each {|meta| fbml += meta_fbml meta[:name], meta[:content]}
    params[:links].each {|link| fbml += link_fbml link[:rel], link[:href]}
    fbml += "</fb:share-button>"
  end
  
  private
  
  def meta_fbml name, content
    %{<meta name='#{metaize name}' content='#{metaize content}'/>}
  end
  
  def link_fbml rel, href
    %{<link rel='#{rel}' href='#{href}'/>}
  end
  
  def metaize content
    INVALID_CHARS.each do |invalid_char|
      content.gsub! invalid_char, REPLACED_CHARS[invalid_char]
    end
    content
  end
end