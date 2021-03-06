async = require('async')
appconfig = require("../config/appconfig").appconfig

unless String::trim then String::trim = -> @replace /^\s+|\s+$/g, ""

exports.sendJSONPResponse = (request,response,responseObj) ->
	callbackFunction = request.query.jsonp || request.query.callback
	if callbackFunction
		response.set('Content-Type', 'application/javascript');
		response.send("#{callbackFunction}(#{JSON.stringify(responseObj)})")
	else
		response.send(responseObj)

exports.sendError = (response, msg, err) ->
	errMsg = if err then ' = ' + err else ''
	console.log msg + errMsg
	response.status(400).send error: msg + errMsg

exports.base64EncodedCompleteUrl = (req) ->
	fullUrl = req.protocol + '://' + req.get('host') + req.originalUrl
	return new Buffer(fullUrl).toString('base64')

exports.uniqueId = (length=8) ->
  id = ""
  id += Math.random().toString(36).substr(2) while id.length < length
  id.substr 0, length



				

