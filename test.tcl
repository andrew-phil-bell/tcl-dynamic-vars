source dynvars.tcl

::dynvars::init

set ::dynvars::conf_vars(root_dir) "/my/path"
set ::dynvars::conf_vars(my_file) {$::dynvars::conf_vars(root_dir)/file.txt}

# my_file is composed of root_dir
puts "my_file = $::dynvars::conf_vars(my_file)"

set ::dynvars::conf_vars(root_dir) "/my/testing/path"

# change of root_dir dynamically updates my_file
puts "my_file = $::dynvars::conf_vars(my_file)"
