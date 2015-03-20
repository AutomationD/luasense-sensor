
######################################################################
# User configuration
######################################################################
# Luatool & port - using env. variables
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
LUATOOL=${ROOT_DIR}/tools/luatool.py
ESP_PORT=/dev/tty.usbserial-A98RJP5T
BAUD_RATE=9600

######################################################################
# End of user config
######################################################################
LUA_FILES := app/cli.lua app/setup.lua app/httptiny.lua app/app.lua app/init.lua

# Print usage
usage:
	@echo "make upload_app       to upload app files only"
	@echo "make upload           to upload all"

compile: $(LUA_FILES)
	$(foreach f, $^, ${LUATOOL} --src $(f) --dest $(notdir $(f)) -b ${BAUD_RATE} -p ${ESP_PORT};)

# Upload app lua files
upload_app: $(LUA_FILES)
	$(foreach f, $^, ${LUATOOL} --src $(f) --dest $(notdir $(f)) -b ${BAUD_RATE} -p ${ESP_PORT};)
	#@echo Making $@ $?
	# @echo short $(notdir $?)
	#@echo $(LUA_FILES)
	#${LUATOOL} -f $? -t $(notdir $?) -p ${ESP_PORT}

# Upload all
upload: upload_app