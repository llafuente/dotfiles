# install esp32


* File> Preferences
* In Additional Board Manager URLs Add: https://dl.espressif.com/dl/package_esp32_index.json
* Tools > Board > Boards Manager
* search: ESP32 and install


# recompile a library

* Edit -> preferences
* check: show verbose output [x] Compilation
* Compile and search where its compiling, something like:

  > C:\Users\llafuente\AppData\Local\Temp\arduino_build_329573\libraries\

* Remove all files from those folders, it will compile them again
