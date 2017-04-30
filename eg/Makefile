.DUMMY: setup run run.sync debug

all: setup run

make setup:
	npm install
	npm install -u ../

run:
	HUBOT_RIVESCRIPT_BRAIN=".." HUBOT_RIVESCRIPT_UTF8=1 \
		./bin/hubot

run.sync:
	HUBOT_RIVESCRIPT_BRAIN=".." HUBOT_RIVESCRIPT_UTF8=1 HUBOT_RIVESCRIPT_SYNC=1 \
		./bin/hubot

debug:
	HUBOT_RIVESCRIPT_BRAIN=".." HUBOT_RIVESCRIPT_DEBUG=1 HUBOT_RIVESCRIPT_UTF8=1 \
		./bin/hubot
