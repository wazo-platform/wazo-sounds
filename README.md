How to update sounds for wazo-sounds
====================================

* There are two tarballs:

   * `asterisk.tar.bz2`
   * `wazo.tar.bz2`

* Run `./fetch_sounds.sh` to get the two tarballs from mirror.wazo.community. They will be untarred in two directories:

   * `asterisk/`
   * `wazo/`

* Change the sound files you need.
* Then run `./push_sounds.sh` to make and upload two new tarballs with your modifications.
* Finally make your commit (on master) including:

   * `asterisk.tar.bz2.sha256sum`
   * `wazo.tar.bz2.sha256sum`


How to get new sounds from Asterisk upstream
============================================

* Get the two tarballs as detailed in the previous section, until you may change the sound files.
* Edit asterisk_upstream.conf to get the right version from the right place
* Run ./fetch_asterisk_upstream.sh
* Then continue the steps of the previous section
* Don't forget to git your changes to asterisk_upstream.conf

