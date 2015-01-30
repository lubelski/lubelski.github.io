express = require('express')

app = express()

app.get '/assets/main.js', (req, res) ->
  res.sendfile "build/main.js"

app.get '/assets/libs.js', (req, res) ->
  res.sendfile "build/libs.js"

app.get '/assets/main.css', (req, res) ->
  res.sendfile "build/main.css"

app.get '/images/pond.jpg', (req, res) ->
  res.sendfile "images/pond.jpg"

app.get '/*', (req, res) ->
  res.sendfile "index.html"

app.listen(3008)
