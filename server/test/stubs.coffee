sinon = require("sinon")
pg = require("pg")

beforeEach ->
	this.sandbox = sinon.sandbox.create()
	this.sandbox.stub(pg, "Client").returns({
		"connect": ->
		"query": (queryStr, func) ->
			response = { rows: ['one', 'two', 'three']}
			func(null, response)
	})

afterEach ->
	this.sandbox.restore()
