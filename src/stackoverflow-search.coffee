# Description
#   Search on Stack Overflow via Hubot.
#
# Configuration:
#   HUBOT_STACK_OVERFLOW_API_KEY - Obtained from http://stackapps.com/apps/oauth/register
#
# Commands:
#   hubot so me <query> - Searches Stack Overflow for the query and returns top 3 results.

module.exports = (robot) ->
  
  robot.respond /(?:stackoverflow|so)(?: me)? (.*)/i, (res) ->
    unless process.env.HUBOT_STACK_OVERFLOW_API_KEY
      return msg.send "You must configure the HUBOT_STACK_OVERFLOW_API_KEY environment variable"
    query = msg.match[1]
    api_key = process.env.HUBOT_STACK_OVERFLOW_API_KEY
    url = "https://api.stackexchange.com/2.2/search/advanced?key=#{api_key}&pagesize=3&order=desc&sort=relevance&q=#{query}&site=stackoverflow&filter=default"
    robot.http("https://api.stackexchange.com/2.2/search/advanced")
      .query({
        key: api_key,
        pagesize: 3,
        order: 'desc',
        sort: 'relevance',
        site: 'stackoverflow',
        filter: 'default',
        q: query
      })
      .get() (err, res, body) ->
        answers = JSON.parse(body).items

        unless answers? && answers.length > 0
          return msg.send "Sorry. No results for \"#{query}\"."

        video  = msg.random videos
        msg.send "https://www.youtube.com/watch?v=#{video.id.videoId}"


