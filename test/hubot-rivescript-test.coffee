Helper = require('hubot-test-helper')
chai = require 'chai'

expect = chai.expect

helper = new Helper('../src/hubot-rivescript.coffee')

describe 'hubot-rivescript', ->
  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  it 'responds to telling it our name', ->
    # Set a timeout to give RiveScript time to initialize.
    setTimeout(->
      @room.user.say('alice', 'hubot call me Alice').then =>
        expect(@room.messages).to.eql [
          ['alice', 'hubot call me Alice']
          ['hubot', 'Alice, I will call you that from now on.']
        ]
    , 1000)

  it 'knows our name', ->
    setTimeout(->
      @room.user.say('alice', 'hubot tell me my name').then =>
        expect(@room.messages).to.eql [
          ['alice', 'hubot tell me my name']
          ['hubot', 'Your name is Alice.']
        ]
    , 1000)
