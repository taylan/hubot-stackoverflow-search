# Description
#   Search on Stack Overflow via Hubot.
#
# Configuration:
#   HUBOT_STACK_OVERFLOW_API_KEY - Obtained from http://stackapps.com/apps/oauth/register
#
# Commands:
#   hubot so me <query> - Searches Stack Overflow for the query and returns top 3 results.

request = require('request')
zlib = require('zlib')
api_key = process.env.HUBOT_STACK_OVERFLOW_API_KEY

handle_response = (msg, req, query) ->
  gunzip = zlib.createGunzip()
  json = "";

  gunzip.on('data', (data) ->
      json += data.toString()
  );

  gunzip.on('end', () ->
      results = JSON.parse(json).items
      handle_search_results(msg, query, results)
  );

  req.pipe(gunzip)

do_search = (msg, query) ->
  req = request.get({
    url: "https://api.stackexchange.com/2.2/search/advanced",
    qs: {
      key: api_key,
      pagesize: 3,
      order: 'desc',
      sort: 'relevance',
      site: 'stackoverflow',
      filter: 'default',
      q: query
    },
    headers: {accept: "application/json", 'Accept-Encoding': 'gzip'}
  })
  if req.error
    msg.send "Error while doing request"
    return msg.send req.error
  handle_response(msg, req, query)

handle_search_results = (msg, query, results) ->
  unless results? && results.length > 0
    return msg.send "Sorry. No results for \"#{query}\"."

  msg.send "Here are the top 3 results for \"#{query}\" on Stack Overflow:"
  msg.send ""
  print_result(msg, result, index) for result, index in results

print_result = (msg, result, index) ->
  msg.send("#{index+1}. #{result.title}:")
  msg.send(result.link)
  msg.send("")

module.exports = (robot) ->
  
  robot.respond /(?:stackoverflow|so)(?: me)? (.*)/i, (msg) ->
    unless process.env.HUBOT_STACK_OVERFLOW_API_KEY
      return msg.send "You must configure the HUBOT_STACK_OVERFLOW_API_KEY environment variable"

    query = msg.match[1]
    do_search(msg, query)
