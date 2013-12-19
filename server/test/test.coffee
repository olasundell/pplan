request = require("supertest")
https = require("https")
fs = require("fs")
path = require("path")
express = require("express")
app = require(__dirname + "/../app.js")
describe "GET /programmes", ->
	it "respond with json", (done) ->
		request(app).get("/programmes").set("Accept", "application/json").expect(200).end (err, res) ->
			return done(err)	if err
			done()

		done()


