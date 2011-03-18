atom_feed(:schema_date => "#{Time.now.strftime("%Y-%m-%dT%H:%M:%SZ")}", :root_url => "#{people_finder_url}/feeds/survivor_updates.atom?title=#{@title}") do |feed|
  feed.title "#{app_name} - #{@status} updates Atom feed"
  feed.updated @survivor_updates.first.created_at unless @survivor_updates.empty?
  feed.updated Time.now if @survivor_updates.empty?

  for survivor_update in @survivor_updates
    feed.entry(survivor_update, :url => "#{people_finder_url}/survivor_updates/#{survivor_update.id}") do |entry|
      entry.title survivor_update.survivor.formatted_name
      entry.content survivor_update.feed_description, :type => 'html'

      entry.author do |author|
        author.name "#{survivor_update.survivor.user.profile.formatted_name}"
        author.name "Unknown user" if survivor_update.user.nil?
      end
    end
  end
end