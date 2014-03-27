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

stub = ""

before ->
	stub = sinon.stub(pg, "Client").returns({
		"connect": ->
			console.log("Connecting...")
		"query": (queryStr, func) ->
			console.log(queryStr)
			func(null, { rows: ['one', 'two', 'three']})
	})

after ->
	stub.restore()

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

