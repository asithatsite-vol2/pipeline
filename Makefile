mods:
	rsync -avz --rsync-path="sudo -u amp rsync" agmlego.com:/home/amp/.ampdata/instances/space-factory/factorio/config/mods/ $@/

# Don't do this much. It uses a lot of bandwidth
saves:
	rsync -avz --rsync-path="sudo -u amp rsync" agmlego.com:/home/amp/.ampdata/instances/space-factory/factorio/config/saves/ $@/

factorio.tar.xz:
	python3 ./gui-download.py
