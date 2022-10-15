mods:
	rsync -avz --progress --rsync-path="sudo -u amp rsync" agmlego.com:/home/amp/.ampdata/instances/space-factory/factorio/config/mods/ $@/
		rm piocu-pause-instead-of-catching-up_*

# Don't do this much. It uses a lot of bandwidth
saves:
	rsync -avz --progress --rsync-path="sudo -u amp rsync" agmlego.com:/home/amp/.ampdata/instances/space-factory/factorio/config/saves/ $@/

factorio.tar.xz:
	python3 ./gui-download.py
