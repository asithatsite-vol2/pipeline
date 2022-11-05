upload:
    rsync --filter=':- .gitignore' -avz . agmlego.com:mapshot
    rsync --progress -v factorio.tar.xz agmlego.com:mapshot/