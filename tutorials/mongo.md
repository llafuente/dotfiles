# Mongodb sheet

## windows installation

download: MongoDB Community Server
download: MongoDB Community compass


From an `Administrator cmd`
```
msiexec.exe /l*v mdbinstall.log  /qb /i mongodb-windows-x86_64-4.4.1-signed.msi ADDLOCAL="ServerNoService"

msiexec.exe /l*v mdbinstall.log  /qb /i mongodb-windows-x86_64-4.4.1-signed.msi ^
            ADDLOCAL="ServerService,Client" ^
            SHOULD_INSTALL_COMPASS="0"

cd C:\
md "\data\db"
# --bind_ip 0.0.0.0 # open to network
"C:\Program Files\MongoDB\Server\4.4\bin\mongod.exe" --dbpath="c:\data\db"
```

## binary backup

  sudo cp -rf /var/lib/mongo/* .

## binary restore

```bash
cd /var/lib/mongo/
sudo service mongod stop
sudo rm -rf * # delete current db
sudo cp -rf /<src>/* .
sudo chown -R mongod.mongod *
sudo service mongod start
```

## import / export database

```bash
date=$(date +'%F')
db="XXX"
for collection in `echo "show collections" | mongo digital_place --quiet`;
do
  # comment/uncomment as desired :)
  mongoexport --db "${db}" --collection "${collection}" --out "${date}_digital_place_${collection}.json"
  # mongoimport --db "${db}" --collection "${collection}" --file "${date}_digital_place_${collection}.json"
done
```

## service

    # sudo rm -rf /var/lib/mongo/mongod.lock
    sudo service mongod restart

## log

    tail -f /var/log/mongodb/mongod.log

## queries

find by array length
```js
db.xxx.find( { $where: "this.array.length > 0" } ).pretty();
```

update document with forEach/save
```js
db.xxx.find( { } ).forEach(
  function(e) {
    // mad science
    printjson(e);
    db.xxx.save(e); // NOTE: remember to match the collection!
  }
)
```

## fix string to ObjectId

```js
function toObjectId(v) {
  return v && "string" === typeof v ? ObjectId(v) : v;
}

db.collection.find( { } ).forEach(
  function(e) {
    print(e._id);
    e.field = toObjectId(e.field);
    e.array = (e.array || []).map(x => toObjectId(x));
    print("done");

    db.collection.save(e);
  }
)
```
