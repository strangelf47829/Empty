# +========================================+
# | BBP Compilation makefile utility       |
# |                                        |
# | Author: Rafael de Bie, 2024            |
# | Contact: 2107628bie@zuyd.nl            |
# +========================================+

# +========================================+
# | Licensing information can be found in  |
# | this directory                         |
# +========================================+


# Calling without args sets the environment, and then builds the binary
default: env setup build

help:
	@echo "Run (make man pages) and read the manual to receive help."

version:
	@echo version 1.1.1.1

.PHONY: build

# +========================================+
# | Set up the environment here            |
# +========================================+

env:
	@chmod 775 config/Platforms/guess.sh Source/g++errOutput.sh
	@mkdir -p build/bin

# +========================================+
# | The setup target sets the platform     |
# | specific stuff.                        |
# +========================================+

setup:
	@cd config/Platforms; ./guess.sh

# +========================================+
# | The build command actually builds the  |
# | libraries and whatnots                 |
# +========================================+

build:
	@cd build; make --no-print-directory

# +========================================+
# | Clean returns everything to how it was |
# +========================================+

clean:
	@cd build; make clean --no-print-directory

# +========================================+
# | Cross compilation debug tools          |
# +========================================+

gdb-host:
	qemu-arm -L /usr/arm-linux-gnueabihf -g 1234 build/a.out

gdb-remote:
	gdb-multiarch --ex="set arch armv5te" --ex="set sysroot /usr/arm-linux-gnueabihf/" --ex="target remote localhost:1234" --ex="break main" build/a.out

# +========================================+
# | Make all targets (binaries and docs)   |
# +========================================+

all:
	cd ./samples; make all;
	make docs

# +========================================+
# | Make documentation                     |
# +========================================+

docs: doxygen sphinx

doxygen:
	cd config; doxygen doxygen.cfg

sphinx:
	cd config/sphinx; make html

# +========================================+
# | Clear everything (binaries and docs)   |
# +========================================+

full-clean:
	cd ./build; make clean_all
	cd ./doc/doxygen/; rm -r html; rm -r latex; rm -r xml
	cd ./doc/sphinx/; rm -r html; rm -r doctrees
