def execute_cmd cmd, silient=true
  puts "Executing: #{cmd}" unless silient
  output = %x(#{cmd})
  unless $? == 0
    raise 'The shell script returns error'
  else
    puts "#{output} \n" unless silient
    output
  end
end

def list_new_files source, destination
	output = execute_cmd "rsync -avzi --dry-run #{source} #{destination}"
  output.split(/\n/).inject([]) do |mem, line|
  	if line.empty?
  		return mem
  	elsif !line.include? '... done'
  		mem << line.split(' ').drop(1).join(' ')
  	end
		mem
  end
end

def syn_files source, destination
	execute_cmd "rsync -avzi #{source} #{destination}"
end

def push_to_git new_files, local_path
  execute_cmd "cd #{local_path} && git add ."
  unless (execute_cmd "cd #{local_path} && git diff --cached").empty?
    execute_cmd "cd #{local_path} && git commit -m 'Changed files: #{ new_files.join(",") }'"
    execute_cmd "cd #{local_path} && git push  origin master"
  end
end

sublime_path = "~/Library/Application\\ Support/Sublime\\ Text\\ 2/Packages/User/"
dropbox_path = "~/Dropbox/backup-scripts/"
# array of sources and distinations you want to sync
sources_destinations_mapping = [
	["~/.gitconfig", dropbox_path],
	["#{sublime_path}Default\\ \\(OSX\\).sublime-keymap", dropbox_path],
  ["~/Workspace/thebookingbutton/.git/hooks/pre-commit", dropbox_path],
  ["~/.vimrc.after", dropbox_path],
  ["/Users/nattawatnonsung/Workspace/playground/rsync/rsync.rb", dropbox_path]
]
sublime_snippets = execute_cmd "ls #{sublime_path} | grep .sublime-snippet"
sublime_snippets.split(/\n/).each do |filename|
	sources_destinations_mapping << ["#{sublime_path+filename}", dropbox_path]
end
sources_destinations_mapping.each do |source, destination|
	new_files = list_new_files source, destination
	puts "\nSynce from #{source} to #{destination}"
	if new_files.empty?
		puts "Nothing changes from the last sync"
	else
		puts "Sync file(s):"
		new_files.each{|file| puts "\t#{file}"}
		syn_files source, destination
    push_to_git new_files, destination
	end
end
