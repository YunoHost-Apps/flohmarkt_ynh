#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# replace '/' by nothing for the path
if [ "$path" == '/' ]; then url_path=''; else url_path=$path; fi
# directory flohmarkts software is installed to
flohmarkt_install="/opt/${id}/${domain}${url_path}/src"
# diretory the venv for flohmarkt is installed to
flohmarkt_venv_dir="/opt/${id}/${domain}${url_path}/venv"

#=================================================
# PERSONAL HELPERS
#=================================================

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
