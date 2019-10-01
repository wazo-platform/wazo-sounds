#!/bin/bash
# Copyright 2015-2019 The Wazo Authors  (see the AUTHORS file)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>

# This script is used to keep up to date wazo-sounds directories, used only for
# digium
#   * get source tarballs
#   * extract tarballs, correct rights is needed
#   * create tarball with all datas

. ./asterisk_upstream.conf

clean_tmp_dir () {
    # clean tmp_dir
    if [ -d $tmp_dir ]; then
        rm -rf $tmp_dir
    fi
}

prepare_temp_dir () {
    tmp_dir=$1
    echo "Prepare build directory $tmp_dir"
    clean_tmp_dir
    mkdir -p $tmp_dir/tarballs
    rsync -av asterisk wazo $tmp_dir/ --exclude=wazo/wav/wazo-son.ods > /dev/null 2>&1
}

get_tarball () {
    filename=$1
    tarball_url=$2
    tarball_dest=$3

    if [ ! -f $tarball_dest ]; then
        echo "Get tarball $filename"
        wget -nv -T10 -t3 -O $tarball_dest $tarball_url
    fi
}

extract_digium_data () {
    tarball=$1
    language=$2

    case $language in
        "en") dest_dir="en_US";;
        "es") dest_dir="es_ES";;
        "fr") dest_dir="fr_CA";;
        *) echo "Error this language is not used"; exit 1;;
    esac
    tarball_path="asterisk/wav/$dest_dir"
    mkdir $tarball_path

    echo "extract $tarball on $tarball_path"
    tar xvzf $tarball -C $tarball_path
    # overriden by pf-asterisk-prompts-wazo
    if [ $language = "fr" ] || [ $language = "en" ]; then
        find $tarball_path -name "conf-adminmenu.wav" -delete
    fi
    echo "asterisk/wav/$dest_dir is up-to-date"
}

wazo_sounds_version=${ast_version}

tmp_dir='tmp'

prepare_temp_dir $tmp_dir

# Prepare Digium sounds archive
for language in $ast_languages; do
    tmp_tarballs_path="$tmp_dir/tarballs"
    filename="${ast_tarball_prefix}-${language}-wav-${ast_version}.tar.gz"
    tarball_url="$ast_base_url/$filename"
    tarball="$tmp_tarballs_path/$filename"
    get_tarball $filename $tarball_url $tarball
    extract_digium_data $tarball $language
done
