var pg = require('pg');
var conString = "postgres://pplan:pplan@localhost:5432/pplan";

exports.list = function (req, res) {
    var client = new pg.Client(conString);
    client.connect();

    var query = client.query("SELECT * FROM program", function(err, result) {
        res.send(result.rows);
    });
}

exports.view = function (req, res) {

    var client = new pg.Client(conString);
    client.connect();

    var query = client.query("SELECT * FROM program WHERE pid = " + req.params.id, function(err, result) {
        if(err) {
            return console.error('error running query', err);
        }
        res.send(result.rows);
    });
}
