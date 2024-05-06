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
# just in case we append $app to make it really unique
# this filename is used for logfile name and systemd.service name
flohmarkt_filename="${flohmarkt_filename//[^A-Za-z0-9._-]/_}_${app}"
#
# directory flohmarkts software is installed to
# contains ./venv and ./src as sub-directories
flohmarkt_install="/opt/${id}/${domain}/${url_path}"
flohmarkt_venv_dir="${flohmarkt_install}/venv"
flohmarkt_app_dir="${flohmarkt_install}/app"
# directory containing logfiles
flohmarkt_log_dir="/var/log/${id}/${flohmarkt_filename}"
# filename for logfiles - ¡ojo! if not ends with .log will be interpreted
# as a directory by ynh_use_logrotate
# https://github.com/YunoHost/issues/issues/2383
flohmarkt_logfile="${flohmarkt_log_dir}/${app}.log"
# flohmarkt data_dir follows the naming convention above
# its saved to settings during install
flohmarkt_data_dir="/home/yunohost.app/${flohmarkt_filename}"

## old filenames before 0.00~ynh5 - for reference and needed to
# migrate (see below)
flohmarkt_old_install="$install_dir/$app/"
flohmarkt_old_venv_dir="$install_dir/venv"
flohmarkt_old_log_dir="/var/log/$app/"
flohmarkt_old_logfile="$app"
flohmarkt_old_service="$app"

#=================================================
# PERSONAL HELPERS
#=================================================

# move files and directories to their new places
flohmarkt_ynh_upgrade_path_ynh5() {
  # flohmarkt and couchdb are already stopped in upgrade script
  # move install_dir
  # move venv_dir
  # move data_dir
  # move systemd.service
  # move logfiles
  # update settings for above
  
  false
  # there's still some work open - see above
}

# to follow the naming convention including information about domain
# and path we do create the data_dir here and save it during install 
# to the settings of this flohmarkt instance
flohmarkt_ynh_create_data_dir() {
  mkdir -p $data_dir
  chown $app: $data_dir
  chmod 750 $data_dir
}

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
