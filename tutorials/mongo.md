# Mongodb sheet

## backup

  sudo cp -rf /var/lib/mongo/* .

## restore

  cd /var/lib/mongo/
  sudo service mongod stop
  sudo rm -rf * # delete current db
  sudo cp -rf /<src>/* .
  sudo chown -R mongod.mongod *
  sudo service mongod start

## service

  # sudo rm -rf /var/lib/mongo/mongod.lock
  sudo service mongod restart

## log

  tail -f /var/log/mongodb/mongod.log
