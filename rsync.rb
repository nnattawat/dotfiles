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
  execute_cmd "cd #{local_path} && $(which git) add ."
  unless (execute_cmd "cd #{local_path} && $(which git) diff --cached").empty?
    execute_cmd "cd #{local_path} && $(which git) config --local user.name 'nnattawat'"
    execute_cmd "cd #{local_path} && $(which git) config --local user.email 'armmer1@gmail.com'"
    execute_cmd "cd #{local_path} && $(which git) commit -m 'Changed files: #{ new_files.join(",") }'"
    execute_cmd "cd #{local_path} && $(which git) push origin master"
  end
end

def compare_and_sync(source, destination)
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

sublime_path = "/Users/nattawatnonsung/Library/Application\\ Support/Sublime\\ Text\\ 2/Packages/User/"
des_path = "/Users/nattawatnonsung/Workspace/dotfiles/"
# array of sources and distinations you want to sync
sources_destinations_mapping = [
	["/Users/nattawatnonsung/.gitconfig", des_path],
	["#{sublime_path}Default\\ \\(OSX\\).sublime-keymap", des_path],
  ["/Users/nattawatnonsung/Workspace/thebookingbutton/.git/hooks/pre-commit", des_path],
  ["/Users/nattawatnonsung/Workspace/thebookingbutton/.git/hooks/prepare-commit-msg", des_path],
  ["/Users/nattawatnonsung/.vimrc", des_path],
  ["/Users/nattawatnonsung/.tmux.conf", des_path],
  ["/Users/nattawatnonsung/.bash_profile", des_path],
  ["/Users/nattawatnonsung/Workspace/playground/rsync/rsync.rb", des_path],
  ["/Users/nattawatnonsung/Workspace/playground/jquery/Vagrantfile", des_path],
  ["/Users/nattawatnonsung/Workspace/playground/jquery/bootstrap.sh", des_path],
  ["/Users/nattawatnonsung/.atom/keymap.cson", des_path],
  ["/Users/nattawatnonsung/.atom/styles.less", des_path],
  ["/Users/nattawatnonsung/.atom/init.coffee", des_path]
]
sublime_snippets = execute_cmd "ls #{sublime_path} | grep .sublime-snippet"
sublime_snippets.split(/\n/).each do |filename|
	sources_destinations_mapping << ["#{sublime_path+filename}", des_path]
end

threads = []

sources_destinations_mapping.each do |source, destination|
  threads << Thread.new { compare_and_sync(source, destination) }
end

threads.each { |t| t.join }

