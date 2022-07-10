namespace eval dynvars {
    # main configuration array
    variable conf_vars
    # the unevaluated (raw) values are stored in a shadow array
    variable conf_vars_shadow
}

proc dynvars::init {} {
    variable conf_vars
    variable conf_vars_shadow
    array set conf_vars {}
    array set conf_vars_shadow {}
    
    set ns [namespace current]
    namespace eval :: [list trace add variable ${ns}::conf_vars read ${ns}::conf_read]
    namespace eval :: [list trace add variable ${ns}::conf_vars write ${ns}::conf_write]

    puts "namespace eval :: [list trace add variable ${ns}::conf_vars write ${ns}::conf_write]"
    puts "added traces for ns ${ns}"
}

proc dynvars::conf_read { ary key op } {
    variable conf_vars
    variable conf_vars_shadow
    # upon read, we evaluate (using [subst]) the shadow variable and set
    puts "reading array $ary , key = $key"

    set rawv $conf_vars_shadow($key)

    if { ! [catch { set newv [subst -nobackslashes $rawv] }] } {
        # try with command subtitutions first
        set conf_vars($key) $newv
    } elseif { ! [catch { set newv [subst -nobackslashes -nocommands $rawv] }] } {
        # back off to variables only
        set conf_vars($key) $newv
    }


}

proc dynvars::conf_write { ary key op } {
    puts "writing array $ary , key = $key"
    # keep shadow var in sync with updates
    variable conf_vars
    variable conf_vars_shadow
    set conf_vars_shadow($key) $conf_vars($key)
}
