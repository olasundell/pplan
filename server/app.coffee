
###
Module dependencies.
###
express = require("express")
routes = require("./routes")
user = require("./routes/user")
programme = require("./routes/programme")
event = require("./routes/event")
episode = require("./routes/episode")
http = require("http")
path = require("path")
app = module.exports = express()

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"
app.use express.favicon()
app.use express.logger("dev")
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use app.router
app.use require("stylus").middleware(path.join(__dirname, "public"))
app.use express.static(path.join(__dirname, "public"))

# development only
app.use express.errorHandler()	if "development" is app.get("env")
app.get "/", routes.index
app.get "/users", user.list
app.get "/programmes", programme.list
app.get "/programme/:id", programme.view
app.get "/events", event.list
app.get "/event/:id", event.view
app.get "/episodes", episode.list
app.get "/episode/:id", episode.view
http.createServer(app).listen app.get("port"), ->
	console.log "Express server listening on port " + app.get("port")

