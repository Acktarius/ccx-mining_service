# ccx-mining_service
**LINUX ONLY**

generate,install/enable/disable ccx-mining service for CCX-BOX, to be use in conjonction with Conceal Assistant

## installation
### "manually"
* place ms.png in `~/icons`
* place m-s_script.desktop in `~/.local/share/applications`
* place the remaining files in `/opt/conceal-toolbox/mining_service` folder
* `sudo chmod 755 mining_s.sh`

### using deb file
you are encouraged to import key and verify signature :

`gpg --keyserver hkp://keyserver.ubuntu.com --search-key A1F4A52C`

`gpg --verify ccx-mining_service_v*.deb.sig`

right click on the deb file, open with software installer

* logout, login, Mining Service icon should now be available
