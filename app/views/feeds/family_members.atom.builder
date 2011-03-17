atom_feed(:schema_date => "#{Time.now.strftime("%Y-%m-%dT%H:%M:%SZ")}", :root_url => "#{haiti_quake_survivors_url}/feeds/family_members.atom") do |feed|
  feed.title "#{app_name} - #{@user.profile.formatted_name}'s family members Atom feed"
  feed.updated @family_members.first.created_at unless @family_members.empty?
  feed.updated Time.now if @family_members.empty?
  
  for family_member in @family_members
    feed.entry(family_member.survivor, :url => "#{haiti_quake_survivors_url}/survivors/#{family_member.survivor.id}") do |entry|
      entry.title family_member.survivor.profile.full_name
      entry.content family_member.survivor.feed_description, :type => 'html'
      
      entry.author do |author|
        author.name "#{family_member.survivor.profile.formatted_name}"
      end
    end
  end
end