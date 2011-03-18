atom_feed(:schema_date => "#{Time.now.strftime("%Y-%m-%dT%H:%M:%SZ")}", :root_url => "#{people_finder_url}/feeds/survivors.atom") do |feed|
  feed.title "#{app_name} - Atom feed"
  feed.updated @survivors.first.created_at unless @survivors.empty?
  feed.updated Time.now if @survivors.empty?

  for survivor in @survivors
    feed.entry(survivor, :url => "#{people_finder_url}/survivors/#{survivor.id}") do |entry|
      entry.title survivor.profile.full_name
      entry.content survivor.feed_description, :type => 'html'

      entry.author do |author|
        author.name "#{survivor.profile.formatted_name}"
      end
    end
  end
end