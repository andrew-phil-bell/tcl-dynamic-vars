* Basic Tcl dynamic variables

* Purpose

For Tcl runtimes, configuration formats in Tcl are a reasonable choice.  And one or more associative arrays (Tcl's [array]) are also reasonable to bundle the configuration variables together.

One problem with configuration variables is to compose them and keep them in-sync (ie, a config variable that is a function of another config variable).  A simple example:

```
set conf_var(root_dir) /path/to/dir/
set conf_var(my_file)  $::conf_var(root_dir)/file.txt
```

This seems fine, but what if a user overrides root_dir?  Then the my_file path is not updated.

```
# User override
set conf_var(root_dir) /testing/path/

# Now what happens to conf_var(my_file)?
```

Making the variables dynamically evaluate upon read would solve this.

