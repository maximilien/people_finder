atom_feed(:schema_date => "#{Time.now.strftime("%Y-%m-%dT%H:%M:%SZ")}", :root_url => "#{haiti_quake_survivors_url}/feeds/friends.atom") do |feed|
  feed.title "#{app_name} - #{@user.profile.formatted_name}'s friends Atom feed"
  feed.updated @friends.first.created_at unless @friends.empty?
  feed.updated Time.now if @friends.empty?
  
  for friend in @friends
    feed.entry(friend.survivor, :url => "#{haiti_quake_survivors_url}/survivors/#{friend.survivor.id}") do |entry|
      entry.title friend.survivor.profile.full_name
      entry.content friend.survivor.feed_description, :type => 'html'
      
      entry.author do |author|
        author.name "#{friend.survivor.profile.formatted_name}"
      end
    end
  end
end