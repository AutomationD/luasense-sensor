
######################################################################
# User configuration
######################################################################
# Luatool & port - using env. variables
ROOT_DIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
LUATOOL=${ROOT_DIR}/tools/luatool.py
NODEMCU_UPLOADER=${ROOT_DIR}/tools/nodemcu-uploader.py
ESP_PORT=/dev/tty.usbserial-A98RJP5T
BAUD_RATE=9600

######################################################################
# End of user config
######################################################################

LUA_FILES := app/cli.lua app/app.lua app/main.lua app/setup.lua app/httptiny.lua
LC_FILES := app/lc/cli.lc app/lc/app.lc app/lc/main.lc app/lc/setup.lc app/lc/httptiny.lc
INIT_FILES := init.lua

# Print usage
usage:
	@echo "make upload_app       to upload app files only"
	@echo "make upload           to upload all"

format:
	${NODEMCU_UPLOADER} -b ${BAUD_RATE} -p ${ESP_PORT} file format

compile: format $(LUA_FILES)
	$(foreach f, $^, ${NODEMCU_UPLOADER} -b ${BAUD_RATE} -p ${ESP_PORT} compile $(f):$(notdir $(f)) -r ;)
	mkdir -p app/lc/ && mv *.lc app/lc/

# Upload app lua files
upload_app: $(LUA_FILES)
  $(foreach f, $^, ${NODEMCU_UPLOADER} -b ${BAUD_RATE} -p ${ESP_PORT} upload $(f):$(notdir $(f)) -c -r ;)
	#${NODEMCU_UPLOADER} --verbose -b ${BAUD_RATE} -p ${ESP_PORT} upload $(foreach f, $^,$(f):$(notdir $(f))) -c;

upload_init: $(INIT_FILES)
  $(foreach f, $^, ${NODEMCU_UPLOADER} -b ${BAUD_RATE} -p ${ESP_PORT} upload $(f):$(notdir $(f));)
	#${NODEMCU_UPLOADER} -b ${BAUD_RATE} -p ${ESP_PORT} upload $(foreach f, $^,-f $(f) -d $(notdir $(f)));
  #${NODEMCU_UPLOADER} --verbose -b ${BAUD_RATE} -p ${ESP_PORT} upload $(foreach f, $^,$(f):$(notdir $(f)));
  
upload_app_lc: $(LC_FILES)
	$(foreach f, $^, ${NODEMCU_UPLOADER} -b ${BAUD_RATE} -p ${ESP_PORT} upload $(f):$(notdir $(f));)
	#${NODEMCU_UPLOADER} -b ${BAUD_RATE} -p ${ESP_PORT} upload $(foreach f, $^,-f $(f) -d $(notdir $(f)));
  #${NODEMCU_UPLOADER} --verbose -b ${BAUD_RATE} -p ${ESP_PORT} upload $(foreach f, $^,$(f):$(notdir $(f)));


# Upload all
upload: upload_app upload_init
build: compile upload_app_lc upload_init