#!/bin/bash -x
url_path=/
domain=fl.tst
install_dir=/root/tmp/install_dir
data_dir=/root/tmp/data_dir

. /usr/share/yunohost/helpers
. /root/flohmarkt_ynh/scripts/_common.sh

# Here we now have TWO subroutines to compare:
#
# ynh_handle_getopts_args (old implementation)
# flohmarkt_ynh_handle_getopts_args (new implentation)
# 
# There shouldn't be any case in which the results of situations both can handle
# differ.
# 
# @@ TODO: write some routine that compares for a list of examples the results
#
# https://stackoverflow.com/questions/1203583/how-do-i-rename-a-bash-function describes how to
# replace an existing subroutine with an own one.
#
# idea: replace ynh_handle_getopts_args by a sub that runs old and new versions and compares
# output. Performance impact: yes. But testing made very simple by real use and optional fallback
# to old version.

flohmarkt_ynh_local_curl --location http://127.0.0.1/go_ahead -n --data blafasel -d foo -d bar -H 'header1: blafasel' --header 'header2: foobar'
#  -u admin -p bla 
# flohmarkt_ynh_local_curl -n -H '-header1' --header 'header2: bar' --header='-header3: ups' -- /path "key1=value1" "key2=value2"

# ups...
# flohmarkt_ynh_local_curl $*
