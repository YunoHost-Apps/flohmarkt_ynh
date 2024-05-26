#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

## new filenames starting 0.00~ynh5
# make a filename/service name from domain/path
if [[ "$path" == /* ]]; then 
  url_path="${path:1}"
fi
if [[ "__${url_path}__" == '____' ]]; then
  flohmarkt_filename="$domain"
else
  flohmarkt_filename="$domain-${url_path}"
fi
# this filename is used for logfile name and systemd.service name
# and for symlinking install_dir and data_dir
flohmarkt_filename="${YNH_APP_ID}_${flohmarkt_filename//[^A-Za-z0-9._-]/_}"
# directory flohmarkts software is installed to
# contains ./venv and ./src as sub-directories
flohmarkt_install="$install_dir"
flohmarkt_sym_install="$( dirname $flohmarkt_install )/$flohmarkt_filename"
flohmarkt_venv_dir="${flohmarkt_install}/venv"
flohmarkt_app_dir="${flohmarkt_install}/app"
# directory containing logfiles
flohmarkt_log_dir="/var/log/${app}"
flohmarkt_sym_log_dir="/var/log/${flohmarkt_filename}"
# filename for logfiles - ¡ojo! if not ends with .log will be interpreted
# as a directory by ynh_use_logrotate
# https://github.com/YunoHost/issues/issues/2383
flohmarkt_logfile="${flohmarkt_log_dir}/app.log"
# flohmarkt data_dir
flohmarkt_data_dir="$data_dir"
flohmarkt_sym_data_dir="$( dirname $flohmarkt_data_dir )/$flohmarkt_filename"

## old filenames before 0.00~ynh5 - for reference and needed to
# migrate (see below)
flohmarkt_old_install="/opt/flohmarkt"
flohmarkt_old_venv_dir="${flohmarkt_old_install}/venv"
flohmarkt_old_app_dir="${flohmarkt_old_install}/flohmarkt"
flohmarkt_old_log_dir="/var/log/flohmarkt/"
flohmarkt_old_service="flohmarkt"

#=================================================
# PERSONAL HELPERS
#=================================================

# debug output
flohmarkt_debug=0
flohmarkt_print_debug() {
    if [[ $flohmarkt_debug -eq 1 ]]; then echo "$*"; fi
}

# Redisgn of ynh_handle_getopts_args for flohmarkt to be tested as `flohmarkt_ynh_handle_getopts_args`
# Internal helper design to allow helpers to use getopts to manage their arguments
#
# [internal]
#
# example: function my_helper()
# {
#     local -A args_array=( [a]=arg1= [b]=arg2= [c]=arg3 )
#     local arg1
#     local arg2
#     local arg3
#     ynh_handle_getopts_args "$@"
#
#     [...]
# }
# my_helper --arg1 "val1" -b val2 -c
#
# usage: ynh_handle_getopts_args "$@"
# | arg: $@    - Simply "$@" to tranfert all the positionnal arguments to the function
#
# This helper need an array, named "args_array" with all the arguments used by the helper
#   that want to use ynh_handle_getopts_args
# Be carreful, this array has to be an associative array, as the following example:
# local -A args_array=( [a]=arg1 [b]=arg2= [c]=arg3 )
# Let's explain this array:
# a, b and c are short options, -a, -b and -c
# arg1, arg2 and arg3 are the long options associated to the previous short ones. --arg1, --arg2 and --arg3
# For each option, a short and long version has to be defined.
# Let's see something more significant
# local -A args_array=( [u]=user [f]=finalpath= [d]=database )
#
# NB: Because we're using 'declare' without -g, the array will be declared as a local variable.
#
# Please keep in mind that the long option will be used as a variable to store the values for this option.
# For the previous example, that means that $finalpath will be fill with the value given as argument for this option.
#
# Also, in the previous example, finalpath has a '=' at the end. That means this option need a value.
# So, the helper has to be call with --finalpath /final/path, --finalpath=/final/path or -f /final/path, 
# the variable $finalpath will get the value /final/path
# If there's many values for an option, -f /final /path, the value will be separated by a ';' $finalpath=/final;/path
# For an option without value, like --user in the example, the helper can be called only with --user or -u. $user 
# will then get the value 1.
#
# To keep a retrocompatibility, a package can still call a helper, using getopts, with positional arguments.
# The "legacy mode" will manage the positional arguments and fill the variable in the same order than they are given 
# in $args_array. e.g. for `my_helper "val1" val2`, arg1 will be filled with val1, and arg2 with val2.

# Positional parameters (used to be the only way to use ynh_handle_getopts_args once upon a time) can be 
# used also:
# 
# '--'          start processing the rest of the arguments as positional parameters
# $legacy_args  The arguments positional parameters will be assign to
#               Needs to be composed of array keys of args_array. If a key for a predefined variable
#               is used multiple times the assigned values will be concatenated delimited by ';'.
#               If the long option variable to contain the data is predefined as an array (e.g. using
#               `local -a arg1` then multiple values will be assigned to its cells.
#               If the last positional parameter defined in legacy_args is defined as an array all 
#               the leftover positional parameters will be assigned to its cells.
#               (it is named legacy_args, because the use of positional parameters was about to be
#               deprecated before the last re-design of this sub)
#
# Requires YunoHost version 3.2.2 or higher.
flohmarkt_ynh_handle_getopts_args() {
    # Manage arguments only if there's some provided
    set +o xtrace # set +x
    if [ $# -eq 0 ]; then
      ynh_print_warn --message="ynh_handle_getopts_args called without arguments"
      return
    fi

    # Store arguments in an array to keep each argument separated
    local arguments=("$@")

    # For each option in the array, reduce to short options for getopts (e.g. for [u]=user, --user will be -u)
    # And built parameters string for getopts
    # ${!args_array[@]} is the list of all option_flags in the array (An option_flag is 'u' in [u]=user, user is a value)
    local getopts_parameters=""
    local option_flag=""
    ## go through all possible options and replace arguments with short versions
    flohmarkt_print_debug "arguments = '${arguments[@]}"
    flohmarkt_print_debug "args_array = '${!args_array[@]}'"
    for option_flag in "${!args_array[@]}"; do
        flohmarkt_print_debug "option_flag = $option_flag"
        # Concatenate each option_flags of the array to build the string of arguments for getopts
        # Will looks like 'abcd' for -a -b -c -d
        # If the value of an option_flag finish by =, it's an option with additionnal values. (e.g. --user bob or -u bob)
        # Check the last character of the value associate to the option_flag
        flohmarkt_print_debug "compare to '${args_array[$option_flag]: -1}'"
        if [ "${args_array[$option_flag]: -1}" = "=" ]; then
            # For an option with additionnal values, add a ':' after the letter for getopts.
            getopts_parameters="${getopts_parameters}${option_flag}:"
        else
            getopts_parameters="${getopts_parameters}${option_flag}"
        fi
        flohmarkt_print_debug "getopts_parameters = ${getopts_parameters}"
        # Check each argument given to the function
        local arg=""
        # ${#arguments[@]} is the size of the array
        ## for one possible option: look at each argument supplied:
        for arg in $(seq 0 $((${#arguments[@]} - 1))); do
            flohmarkt_print_debug "arg = '$arg', argument = '${arguments[arg]}'"
            # Replace long option with = (match the beginning of the argument)
            arguments[arg]="$(printf '%s\n' "${arguments[arg]}" | sed "s/^--${args_array[$option_flag]}/-${option_flag}/")"
            flohmarkt_print_debug "sed - printf '%s\n' \"${arguments[arg]}\" | sed \"s/^--${args_array[$option_flag]}/-${option_flag} /\""
            flohmarkt_print_debug "arg = '$arg', argument = '${arguments[arg]}'"
            # And long option without = (match the whole line)
            arguments[arg]="$(printf '%s\n' "${arguments[arg]}" | sed "s/^--${args_array[$option_flag]%=}$/-${option_flag}/")"
            flohmarkt_print_debug "sed - printf '%s\n' \"${arguments[arg]}\" | sed \"s/^--${args_array[$option_flag]%=}$/-${option_flag} /\""
            flohmarkt_print_debug "arg = '$arg', argument = '${arguments[arg]}'"
        done
        flohmarkt_print_debug "arguments = '${arguments[@]}'"
    done
    flohmarkt_print_debug '================= end first loop ================='
    
    # Parse the first argument, return the number of arguments to be shifted off the arguments array
    # The function call is necessary here to allow `getopts` to use $@
    parse_arg() {
        flohmarkt_print_debug "========= parse_arg started ======== , arguments='$@', getopts_parameters: '$getopts_parameters'"
        for ME in "$@"; do
          flohmarkt_print_debug "  '$ME'"
        done
        # Initialize the index of getopts
        OPTIND=1
        # getopts will fill $parameter with the letter of the option it has read.
        local parameter=""
        getopts ":$getopts_parameters" parameter || true
        flohmarkt_print_debug "after getopts - parameter='$parameter', OPTIND='$OPTIND', OPTARG='$OPTARG'"

        if [ "$parameter" = "?" ]; then
            ynh_die --message="Invalid argument: -${OPTARG:-}"
            flohmarkt_print_debug "Invalid argument: -${OPTARG:-}"
            exit 255
        elif [ "$parameter" = ":" ]; then
            ynh_die --message="-$OPTARG parameter requires an argument."
            echo "-$OPTARG parameter requires an argument."
            exit 255
        else
            # Use the long option, corresponding to the short option read by getopts, as a variable
            # (e.g. for [u]=user, 'user' will be used as a variable)
            # Also, remove '=' at the end of the long option
            # The variable name will be stored in 'option_var'
            option_var="${args_array[$parameter]%=}"
            # if there's a '=' at the end of the long option name, this option takes values
            if [ "${args_array[$parameter]: -1}" != "=" ]; then
                # no argument expected for option - set option variable to '1'
                # 'eval ${option_var}' will use the content of 'option_var'
                flohmarkt_print_debug "option_var='${option_var}', option_value='1'"
                option_value=1
                return 1
            else
                # remove leading and trailing spaces from OPTARG
                OPTARG="$( printf '%s' "${OPTARG}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
                flohmarkt_print_debug "option_var='${option_var}', OPTARG='${OPTARG}'"
                option_value="${OPTARG}"
                return 2
            fi
        fi
    }

    # iterate over the arguments: if first argument starts with a '-' feed arguments to getopts
    # if first argument doesn't start with a '-' enter mode to read positional parameters
    local argument
    local positional_mode=0 # state is getopts mode at the beginning, not positional parameters
    local positional_count=0 # counter for positional parameters
    local option_var=''   # the variable name to be filled
    # Try to use legacy_args as a list of option_flag of the array args_array
    # Otherwise, fill it with getopts_parameters to get the option_flag. 
    # (But an associative arrays isn't always sorted in the correct order...)
    # Remove all ':' in getopts_parameters, if used.
    legacy_args=${legacy_args:-${getopts_parameters//:/}}
    while [ ${#arguments} -ne 0 ]; do
        local shift_value=0
        local option_value='' # the value to be filled into ${!option_var}
        flohmarkt_print_debug '======= start while loop ======='
        argument=${arguments[0]}
        flohmarkt_print_debug "argument='$argument'"
        # if state once changed to positional parameter mode, all the rest of the arguments will
        # be interpreted in positional parameter mode even if they start with a '-'
        if [ $positional_mode == 0 ] && [ "${argument}" == '--' ];then
            flohmarkt_print_debug "found '--', start positional parameter mode"
            positional_mode=1
            shift_value=1
        elif [ $positional_mode == 0 ] && [ "${argument:0:1}" == '-' ]; then
            flohmarkt_print_debug "getopts, arguments='${arguments[@]}', starting parse_arg"
            parse_arg "${arguments[@]}"
            shift_value=$?
        else
            positional_mode=1 # set state to positional parameter mode
            flohmarkt_print_debug "positional parameter, argument='$argument'"

            # Get the option_flag from getopts_parameters by using the option_flag according to the 
            # position of the argument.
            option_flag=${legacy_args:$positional_count:1}

            # increment counter for legacy_args if still args left. If no args left check if the 
            # last arg is a predefined array and let it cells be filled. Otherwise complain and 
            # return.
            flohmarkt_print_debug "positional_counter='$positional_count', max positional_counter='$(( ${#legacy_args} -1 ))'"
            if [[ $positional_count -le $((${#legacy_args} - 1)) ]]; then
                # set counter to for next option_flag to fill
                positional_count=$((positional_count+1))
                flohmarkt_print_debug "incremented positional_counter to '$positional_count'"

                # Use the long option, corresponding to the option_flag, as a variable
                # (e.g. for [u]=user, 'user' will be used as a variable)
                # Also, remove '=' at the end of the long option
                # The variable name will be stored in 'option_var'
                option_var="${args_array[$option_flag]%=}"
            elif [[ $positional_count -ge $((${#legacy_args} - 1)) ]] && 
                ! declare -p ${option_var} | grep '^declare -a'
            then
                # no more legacy_args to fill - legacy behaviour: complain and return
                ynh_print_warn --message="Too many arguments ! \"${arguments[$i]}\" will be ignored."
                return
            else
                flohmarkt_print_debug "array found - keep going"
            fi

            # value to be assigned to ${!option_var}
            option_value=$argument

            # shift off one positional parameter
            shift_value=1
        fi

        # fill option_var with value found
        # if ${option_var} is an array, fill mutiple values as array cells
        # otherwise concatenate them seperated by ';'
        flohmarkt_print_debug "option_var '$option_var', option_value '$option_value'"
        if declare -p $option_var | grep '^declare -a ' > /dev/null; then
          # hurray it's an array
          flohmarkt_print_debug "hurray! '$option_var' is an array."
          eval ${option_var}+='("${option_value}")'
        elif [[ -z ${!option_var} ]]; then
          eval ${option_var}='"${option_value}"'
        else
          eval ${option_var}+='";${option_value}"'
        fi
        flohmarkt_print_debug "option_var '$option_var', option_value '${!option_var}'"

        # shift value off arguments array
        flohmarkt_print_debug "shifting '$shift_value' off arguments"
        arguments=("${arguments[@]:${shift_value}}")
    done

    # the former subroutine did this - no idea if it is expected somewhere
    unset legacy_args

    # re-enable trace
    set -o xtrace # set -x
}

# local copy of ynh_local_curl() to test some improvement
# https://github.com/YunoHost/issues/issues/2396
# https://codeberg.org/flohmarkt/flohmarkt_ynh/issues/51
flohmarkt_ynh_local_curl() {
# Curl abstraction to help with POST requests to local pages (such as installation forms)
#
# usage: ynh_local_curl "page" "key1=value1" "key2=value2" ...
# | arg: -l --line_match: check answer for a regex to return true
# | arg: -P --put:        PUT instead of POST, requires --data (see below)
# | arg: -H --header:     add a header to the request (can be used multiple times)
# | arg: -n --no_sleep:   don't sleep 2 seconds (background: https://github.com/YunoHost/yunohost/pull/547)
# | arg: -d --data:       data to be PUT or POSTed. Can be used multiple times.
# | arg: -L --location:   either the PAGE part in 'https://$domain/$path/PAGE' or an URI 
# | arg: -u --user:       login username (requires --password)
# | arg: -p --password:   login password
# | arg:                  URL like 'http://doma.in/path/file.ext'
# | arg: page        - positional parameter legacy version of '--page'
# | arg: key1=value1 - (Optional, POST only) legacy version of '--data' as positional parameter
# | arg: key2=value2 - (Optional, POST only) Another POST key and corresponding value
# | arg: ...         - (Optional, POST only) More POST keys and values
#
# example: ynh_local_curl "/install.php?installButton" "foo=$var1" "bar=$var2"
#   → will open a POST request to "https://$domain/$path/install.php?installButton" posting "foo=$var1" and "bar=$var2"
# example: ynh_local_curl -P --header "Accept: application/json"  -H "Content-Type: application/json" \
#   --data "{\"members\":{\"names\": [\"${app}\"],\"roles\": [\"editor\"]}}" -l '"ok":true' \
#   "http://localhost:5984/"
#   → will open a POST request to "http://localhost:5984/" adding headers with "Accept: application/json"
#     and "Content-Type: application/json" sending the data from the "--data" argument. ynh_local_curl will
#     return with an error if the servers response does not match the extended regex '"ok":true'.
#
# For multiple calls, cookies are persisted between each call for the same app.
#
# `$domain` and `$path_url` need to be defined externally if the first form for the 'page' argument is used.
#
# Requires YunoHost version 2.6.4 or higher.

    # Declare an array to define the options of this helper.
    local legacy_args=pd
    local -A args_array=( [l]=line_match= [P]=put [H]=header= [n]=no_sleep [L]=location= [d]=data= [u]=user= [p]=password= )
    local line_match
    local put
    # @@ todo if the headers contain ';' somewhere it might be a problem to split them
    # apart correctly later, because all values are stored in $header seperated by 
    # ';' like 'header1: value;header2: value'.
    # might be a good improvement to 'ynh_handle_getopts_args' to act differently if
    # e.g. $header had been defined as an array: https://stackoverflow.com/questions/14525296/how-do-i-check-if-variable-is-an-array
    local -a header 
    local no_sleep
    local location
    local user
    local password
    local -a data
    local -a curl_opt_args # optional arguments to `curl`
    # Manage arguments with getopts
    flohmarkt_ynh_handle_getopts_args "$@"

    # Define url of page to curl
    # $location contains either an URL or just a page
    local full_page_url
    if [[ "$location" =~ ^https?:// ]]; then
        # if $location starts with an http-protocol use value as a complete URL
        full_page_url="$location"
    elif [ "${path_url}" == "/" ]; then
        # if $path_url points to the webserver root just append $location to localhost URL
        full_page_url="https://localhost$(ynh_normalize_url_path $location)"
    else
        # else append $path_url and $location to localhost URL
        full_page_url="https://localhost${path_url}$(ynh_normalize_url_path $location)"
    fi
    flohmarkt_print_debug "full_page_url='$full_page_url'"

    # Concatenate data
    # POST: all elements of array $data in one string seperated by '&'
    # PUT:  all elements of $data in one string seperated by space
    local seperator='&'
    if [[ $put -eq 1 ]]; then
      seperator=' '
    fi
    join_by() { local IFS="$1"; shift; echo "$*"; }
    local P_DATA=$( join_by "$seperator" ${data[@]} )
    if [[ "$P_DATA" != '' ]]; then curl_opt_args+=('--data'); curl_opt_args+=("$P_DATA"); fi

    # prepend every element in header array with " -H "
    local seq
    while [[ $seq -lt ${#header[@]} ]]; do
      curl_opt_args+=('-H')
      curl_opt_args+=("${header[$seq]}")
      seq=$(( $seq + 1 ))
    done

    # build --user for curl 
    if [[ -n "$user" ]] && [[ -n "$password" ]]; then
      curl_opt_args+=("--user $user:$password")
    elif [[ -n "$user" ]] && [[ -z "$password" ]]; then
      ynh_die --message="user provided via '-u/--user' needs password specified via '-p/--password'"
    fi

    flohmarkt_print_debug "long string curl_opt_args='${curl_opt_args[@]}'"
    seq=0
    while [[ $seq -lt ${#curl_opt_args[@]} ]]; do
      flohmarkt_print_debug "  opt[$seq]='${curl_opt_args[$seq]}'"
      seq=$(( $seq + 1 ))
    done

    # https://github.com/YunoHost/yunohost/pull/547
    # Wait untils nginx has fully reloaded (avoid curl fail with http2) unless disabled
    if ! [[ $no_sleep == 1 ]]; then
      sleep 2
    fi

    local cookiefile=/tmp/ynh-$app-cookie.txt
    touch $cookiefile
    chown root $cookiefile
    chmod 700 $cookiefile

    # Temporarily enable visitors if needed...
    # TODO maybe there's a way to do this using --user and --password instead?
    #   would improve security
    local visitors_enabled=$(ynh_permission_has_user "main" "visitors" && echo yes || echo no)
    if [[ $visitors_enabled == "no" ]]; then
        ynh_permission_update --permission "main" --add "visitors"
    fi

    # Curl the URL
    curl --silent --show-error --insecure --location --resolve "$domain:443:127.0.0.1" \
      --header "Host: $domain" --cookie-jar $cookiefile --cookie $cookiefile \
      "${curl_opt_args[@]}" "$full_page_url" 
    flohmarkt_print_debug \
    curl --silent --show-error --insecure --location --resolve "$domain:443:127.0.0.1" \
      --header "Host: $domain" --cookie-jar $cookiefile --cookie $cookiefile \
      "${curl_opt_args[@]}" "$full_page_url" 

    # re-enable security
    if [[ $visitors_enabled == "no" ]]; then
        ynh_permission_update --permission "main" --remove "visitors"
    fi
}

# create symlinks containing domain and path for install, data and log directories
flohmarkt_ynh_create_symlinks() {
  ynh_script_progression --message="Creating symlinks..." --weight=1
  ln -s "$flohmarkt_install" "$flohmarkt_sym_install"
  ln -s "$flohmarkt_data_dir" "$flohmarkt_sym_data_dir"
  ln -s "$flohmarkt_log_dir" "$flohmarkt_sym_log_dir"
  true
}

# set file permissions and owner for installation
flohmarkt_ynh_set_permission() {
  # install dir - only root needs to write and $app reads
  chown root:$app -R "$flohmarkt_install"
  chmod g-w,o-rwx -R "$flohmarkt_install"
}

# start flohmarkt service
flohmarkt_ynh_start_service() {
  ynh_systemd_action --service_name=$flohmarkt_filename --action="start"  \
    --line_match='INFO: *Application startup complete.' --log_path="$flohmarkt_logfile" \
    --timeout=30
}

# stop flohmarkt service
flohmarkt_ynh_stop_service() {
  ynh_systemd_action --service_name=$flohmarkt_filename --action="stop"
}

# start couchdb and wait for success
flohmarkt_ynh_start_couchdb() {
  ynh_systemd_action --service_name=couchdb --action="start" --timeout=30 \
    --log_path="/var/log/couchdb/couchdb.log" \
    --line_match='Apache CouchDB has started on http://127.0.0.1'
}

# stop couchdb
flohmarkt_ynh_stop_couchdb() {
  ynh_systemd_action --service_name=couchdb --action="stop" --timeout=30 \
    --log_path="/var/log/couchdb/couchdb.log" \
    --line_match='SIGTERM received - shutting down'
}

# install or upgrade couchdb
flohmarkt_ynh_up_inst_couchdb() {
  echo "\
  couchdb couchdb/mode select standalone
  couchdb couchdb/mode seen true
  couchdb couchdb/bindaddress string 127.0.0.1
  couchdb couchdb/bindaddress seen true
  couchdb couchdb/cookie string $couchdb_magic_cookie
  couchdb couchdb/adminpass password $password_couchdb_admin
  couchdb couchdb/adminpass seen true
  couchdb couchdb/adminpass_again password $password_couchdb_admin
  couchdb couchdb/adminpass_again seen true" | debconf-set-selections
  DEBIAN_FRONTEND=noninteractive # apt-get install -y --force-yes couchdb
  ynh_install_extra_app_dependencies \
          --repo="deb https://apache.jfrog.io/artifactory/couchdb-deb/ $(lsb_release -c -s) main" \
          --key="https://couchdb.apache.org/repo/keys.asc" \
          --package="couchdb"
}

flohmarkt_ynh_dump_couchdb() {
  ../settings/scripts/couchdb-dump/couchdb-dump.sh -b -H 127.0.0.1 -d "${app}" \
    -q -u admin -p "${password_couchdb_admin}" -f "${YNH_CWD}/${app}.json"
}

flohmarkt_ynh_import_couchdb() {
  ls -l ../settings/scripts/couchdb-dump/couchdb-dump.sh ${YNH_CWD}/${app}.json
  ../settings/scripts/couchdb-dump/couchdb-dump.sh -r -c -H 127.0.0.1 -d "${app}" \
    -q -u admin -p "${password_couchdb_admin}" -f "${YNH_CWD}/${app}.json"
}

flohmarkt_ynh_delete_couchdb_user() {
  # https://codeberg.org/flohmarkt/flohmarkt_ynh/issues/46 - more than one revision?
  local couchdb_user_revision=$( curl -sX GET "http://127.0.0.1:5984/_users/org.couchdb.user%3A${app}" \
    --user "admin:${password_couchdb_admin}" | jq -r ._rev )
  curl -s -X DELETE "http://127.0.0.1:5984/_users/org.couchdb.user%3A${app}?rev=${couchdb_user_revision}" \
    --user "admin:${password_couchdb_admin}"
}

flohmarkt_ynh_delete_couchdb_db() {
  curl -s -X DELETE "http://127.0.0.1:5984/${app}" --user "admin:${password_couchdb_admin}"
}

flohmarkt_ynh_create_couchdb_user() {
  curl -s -X PUT "http://127.0.0.1:5984/_users/org.couchdb.user:${app}" --user "admin:${password_couchdb_admin}"\
    -H "Accept: application/json" -H "Content-Type: application/json" \
    -d "{\"name\": \"${app}\", \"password\": \"${password_couchdb_flohmarkt}\", \"roles\": [], \"type\": \"user\"}"
  # @@ check answer something like
  # {"ok":true,"id":"org.couchdb.user:flohmarkt","rev":"35-9865694604ab384388eea0f978a6e728"}
}

flohmarkt_ynh_couchdb_user_permissions() {
  curl -s -X PUT "http://127.0.0.1:5984/${app}/_security" --user "admin:${password_couchdb_admin}"\
    -H "Accept: application/json" -H "Content-Type: application/json" \
    -d "{\"members\":{\"names\": [\"${app}\"],\"roles\": [\"editor\"]}}"

}

flohmarkt_ynh_exists_couchdb_user() {
  if [[ $( curl -sX GET "http://127.0.0.1:5984/_users/org.couchdb.user%3A${app}" \
    --user "admin:${password_couchdb_admin}" | jq .error ) == '"not_found"' ]]
  then
    false
  else
    true
  fi
}

flohmarkt_ynh_exists_couchdb_db() {
  if [[ $( curl -sX GET "http://127.0.0.1:5984/${app}" --user "admin:${password_couchdb_admin}" \
    | jq .error ) == '"not_found"' ]]
  then
    false
  else
    true
  fi
  
}

# check whether old couchdb user or database exist before creating the new ones
flohmarkt_ynh_check_old_couchdb() {
  if flohmarkt_ynh_exists_couchdb_user; then
    ynh_die --ret_code=100 --message="CouchDB user '$app' exists already. Stopping install."
  elif flohmarkt_ynh_exists_couchdb_db; then
    ynh_die --ret_code=100 --message="CouchDB database '$app' exists already. Stopping install."
  fi  
}

flohmarkt_ynh_restore_couchdb() {
  flohmarkt_ynh_check_old_couchdb

  flohmarkt_ynh_import_couchdb
  flohmarkt_ynh_create_couchdb_user
  flohmarkt_ynh_couchdb_user_permissions
}

# create venv
flohmarkt_ynh_create_venv() {
  python3 -m venv --without-pip "$flohmarkt_venv_dir"
}

# install requirements.txt in venv
flohmarkt_ynh_venv_requirements() {
  (
    set +o nounset
    source "$flohmarkt_venv_dir/bin/activate"
    set -o nounset
    set -x
    $flohmarkt_venv_dir/bin/python3 -m ensurepip
    $flohmarkt_venv_dir/bin/pip3 install -r "$flohmarkt_app_dir/requirements.txt"
  )
}

# move files and directories to their new places
flohmarkt_ynh_upgrade_path_ynh5() {
  # flohmarkt and couchdb are already stopped in upgrade script

  # move app_dir into new 'app' folder
  mv "$flohmarkt_install/flohmarkt" "$flohmarkt_app_dir"

  # yunohost seems to move the venv dir automatically, but this
  # doesn't work, because the paths inside the venv are not adjusted
  # delete the old, not working venv and create a new one:
  ynh_secure_remove --file="$flohmarkt_venv_dir"
  flohmarkt_ynh_create_venv
  flohmarkt_ynh_venv_requirements
  # remove old $install_dir
  ynh_secure_remove --file="$flohmarkt_old_install"

  # move logfile directory
  mkdir -p "$flohmarkt_log_dir"

  # remove systemd.service - will be generated newly by upgrade
  # ynh_remove_systemd_config --service="$flohmarkt_old_service"
  ynh_systemd_action --action=stop --service_name="$flohmarkt_old_service"
  ynh_systemd_action --action=disable --service_name="$flohmarkt_old_service"
  ynh_secure_remove --file="/etc/systemd/system/multi-user.target.wants/flohmarkt.service"
  ynh_secure_remove --file="/etc/systemd/system/flohmarkt.service"
  # funktioniert nicht? issue?
  #ynh_systemd_action --action=daemon-reload
  # DEBUG + systemctl daemon-reload flohmarkt
  # WARNING Too many arguments.
  systemctl daemon-reload
  # unit flohmarkt is automatically appended and therefor this fails:
  #ynh_systemd_action --action=reset-failed
  systemctl reset-failed
 
  # create symlinks
  ln -s "$flohmarkt_install" "$flohmarkt_sym_install"
  ln -s "$flohmarkt_data_dir" "$flohmarkt_sym_data_dir"
}

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
