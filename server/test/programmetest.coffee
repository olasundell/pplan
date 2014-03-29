request = require("supertest")
https = require("https")
fs = require("fs")
path = require("path")
express = require("express")
app = require(__dirname + "/../app")
sinon = require("sinon")
pg = require("pg")
assert = require("assert")
should = require("should")

describe "GET /programmes", ->
	it "respond with json", (done) ->
		request(app).get("/programmes").set("Accept", "application/json").expect(200).end (err, res) ->
			throw err if err
		done()

	it "response should contain stuff", (done) ->
		request(app).get("/programmes").set("Accept", "application/json").expect(200).end (err, res) ->
			throw err if err
			res.text.should.containDeep('one')
		done()

