// usefull staff that can be included in near future
// https://github.com/comerford/mongodb-scripts/

slave_states = ["STARTUP", "PRIMARY", "SECONDARY", "RECOVERING", "FATAL",
  "STARTUP2", "UNKNOWN", "ARBITER", "DOWN", "ROLLBACK"];

host = db.serverStatus().host.split('.')[0];

prompt = function() {
  var state;
  result = db.isMaster();
  if (result.ismaster) {
    state = 'M';
  } else if (result.secondary) {
    state = 'S';
  } else {
    result = db.adminCommand({replSetGetstate : 1})
    state = slave_states[result.myState];
  }
  return host + ':' + state  + ' ' + db + ' Docs:' + db.stats().objects +'> ';
}
