cmake_minimum_required(VERSION 3.10.0)

# problems
# 1/ ESP32 HUB75 library isn't found on first pass
# 2/ recursing into library when adding include paths
# 3/ file_opts and build_opt.h are being manually cranked
# 4/ can we switch to string(JSON) in place of the json parser
# 5/ filesystem creation for esp32 seems broken
# 6/ arduino version evaluation doesn't work anymore
#    - do we care about the version?
# 7/ library search path is wrong

set(ARDUINO_BOARD "Waveshare ESP32-S3-RGB-Matrix [esp32.waveshare_esp32_s3_rgb_matrix]")
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_LIST_DIR}/cmake/Arduino-toolchain.cmake)
set(ARDUINO_LIBRARIES_SEARCH_PATHS_EXTRA "$ENV{HOME}/Documents/Arduino")

project(spotify LANGUAGES CXX VERSION 1.0.0)

add_executable(hello_world main.cpp)

target_link_arduino_libraries(hello_world PRIVATE
    core
    ESP32_HUB75_LED_MATRIX_PANEL_DMA_Display
    FastLED
)

# note: it looks like maintainers don't do a particularly bang-up job of declaring
# library dependencies, so we can't rely on this. 
target_link_arduino_libraries(ESP32_HUB75_LED_MATRIX_PANEL_DMA_Display PUBLIC Adafruit_GFX)
# this one should be automatic, but the cmake scripts go by the folder name rather than the 
# name in the library.properties file. The actual dependency is 'Adafruit GFX Library' which
# depends on 'Adafruit BusIO'. The space is, obviously, problematic. 

# it's debatable whether a fix is actually viable. 
target_link_arduino_libraries(Adafruit_GFX PUBLIC Adafruit_BusIO)
target_link_arduino_libraries(core PUBLIC Hash)

# I would like to change this model if possible - makes more sense to have a find_library 
# analog, and have target_link_libraries() act as normal. 

# find_arduino_library(
#     identifier
#     [HINTS ...]
#     [PATHS ...]
# )

# find_package(arduino_core)

#target_enable_arduino_upload(hello_world)