# Description:
#   Provides a RiveScript chatbot for Hubot. This bot will respond to all
#   messages directed at it by using a RiveScript brain.
#
# Dependencies:
#   "rivescript": "^1.13.0"
#
# Configuration:
#   HUBOT_RIVESCRIPT_BRAIN -  The path to a folder containing RiveScript files
#       (with the *.rive file extensions).
#   HUBOT_RIVESCRIPT_PREFIX - If you don't want your Hubot to answer all
#       messages using RiveScript, set this string to be a prefix, e.g. with
#       the value "rs" a user must say "hubot rs hello" for the bot to answer
#       their "hello" message.
#   HUBOT_RIVESCRIPT_UTF8  - Boolean to enable UTF-8 mode, 1 or 0, default 1
#
# Commands:
#   hubot [rs] <message> - Retrieve a response from RiveScript.
#
# Author:
#   Noah Petherbridge, https://github.com/kirsle

RiveScript = require "rivescript"

module.exports = (robot) ->

  if robot.brain?.data?
      rivedata = robot.brain.data.rivescript ?= {}

  # Configuration parameters.
  brain  = process.env.HUBOT_RIVESCRIPT_BRAIN or "./brain"
  prefix = if process.env.HUBOT_RIVESCRIPT_PREFIX then "#{process.env.HUBOT_RIVESCRIPT_PREFIX}\\s+" else "\\s*"
  utf8   = "#{process.env.HUBOT_RIVESCRIPT_UTF8}" is "1" or false

  # The matcher regexp.
  regexp = new RegExp("#{prefix}(.*)", "i")

  # Initialize the RiveScript brain.
  @bot = new RiveScript({
    utf8: utf8
  })
  
  @bot.loadDirectory(brain, ->
    rivebot = @bot
    rivebot.sortReplies()

    # Load user variables from hubot brain into rivebot, when ready
    robot.brain.on 'loaded', =>
      rivedata = robot.brain.data.rivescript ?= {}
      rivebot.setUservars user, data for user, data of rivedata

    robot.respond regexp, (res) ->
      reply = bot.reply(res.message.user.name, res.match[1])
      if reply
        res.send reply
        # Save user variables to hubot brain
        rivedata[res.message.user.name] = rivebot.getUservars(res.message.user.name)
        
  , (err) ->
    console.error "Couldn't load RiveScript replies: #{err}"
  )
