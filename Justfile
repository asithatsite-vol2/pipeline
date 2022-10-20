upload:
    rsync --filter=':- .gitignore' -avz . agmlego.com:mapshot
    rsync -v factorio.tar.xz agmlego.com:mapshot/