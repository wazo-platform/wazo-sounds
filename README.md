How to update sounds for xivo-sounds
====================================

* There are two tarballs:

   * `asterisk.tar.bz2`
   * `xivo.tar.bz2`

* Run `./fetch_sounds.sh` to get the two tarballs from mirror.xivo.io. They will be untarred in two directories:

   * `asterisk/`
   * `xivo/`

* Change the sound files you need.
* Then run `./push_sounds.sh` to make and upload two new tarballs with your modifications.
* Bump the Debian changelog:

   `dch -i`

* Finally make your commit (on master) including:

   * `debian/changelog`
   * `asterisk.tar.bz2.sha256sum`
   * `xivo.tar.bz2.sha256sum`


How to get new sounds from Asterisk upstream
============================================

* Get the two tarballs as detailed in the previous section, until you may change the sound files.
* Edit asterisk_upstream.conf to get the right version from the right place
* Run ./fetch_asterisk_upstream.sh
* Then continue the steps of the previous section
* Don't forget to git your changes to asterisk_upstream.conf
