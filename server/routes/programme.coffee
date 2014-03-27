pg = require("pg")
conString = "postgres://pplan:pplan@localhost:5432/pplan"
exports.list = (req, res) ->
	client = new pg.Client(conString)
	client.connect()
	query = client.query("SELECT * FROM program ORDER BY pid", (err, result) ->
		return console.error("error running query", err)	if err
		res.send result.rows
	)

exports.view = (req, res) ->
	client = new pg.Client(conString)
	client.connect()
	query = client.query("SELECT * FROM program WHERE pid = " + req.params.id, (err, result) ->
		return console.error("error running query", err)	if err
		res.send result.rows
	)
