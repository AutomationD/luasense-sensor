
######################################################################
# User configuration
######################################################################
# Luatool & port - using env. variables
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
LUATOOL=${ROOT_DIR}/tools/luatool.py
NODEMCU_UPLOADER=${ROOT_DIR}/tools/nodemcu-uploader.py
ESP_PORT=/dev/tty.usbserial-A98RJP5T
BAUD_RATE=9600

######################################################################
# End of user config
######################################################################
LUA_FILES := app/cli.lua app/main.lua app/setup.lua app/httptiny.lua app/app.lua
INIT_FILES := app/init.lua

# Print usage
usage:
	@echo "make upload_app       to upload app files only"
	@echo "make upload           to upload all"

compile: $(LUA_FILES)
	#$(foreach f, $^, ${LUATOOL} --src $(f) --dest $(notdir $(f)) -b ${BAUD_RATE} -p ${ESP_PORT};)
	# $(foreach f, $^, ${NODEMCU_UPLOADER}-b ${BAUD_RATE} -p ${ESP_PORT} upload -f $(f) -d $(notdir $(f)) -c)



# Upload app lua files
upload_init: $(INIT_FILES)
	${NODEMCU_UPLOADER} -b ${BAUD_RATE} -p ${ESP_PORT} upload $(foreach f, $^,-f $(f) -d $(notdir $(f)));

upload_app: $(LUA_FILES)
	#$(foreach f, $^, ${NODEMCU_UPLOADER} -b ${BAUD_RATE} -p ${ESP_PORT} upload -f $(f) -d $(notdir $(f)) -c;)
	${NODEMCU_UPLOADER} -b ${BAUD_RATE} -p ${ESP_PORT} upload $(foreach f, $^,-f $(f) -d $(notdir $(f))) -c;
	#${NODEMCU_UPLOADER} -b ${BAUD_RATE} -p ${ESP_PORT} upload $(foreach f, $^, -f $(f) -d $(notdir $(f))) -c;


	#@echo Making $@ $?
	# @echo short $(notdir $?)
	#@echo $(LUA_FILES)
	#${LUATOOL} -f $? -t $(notdir $?) -p ${ESP_PORT}

# Upload all
upload: upload_app upload_init