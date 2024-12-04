# +======================================+
# | Makefile utility to create libraries |
# +======================================+

# Include configuration file
include ../Source/makefile.config

# Get a list of modules
MODULE_LIST= etc

# Get environment details
ENV= $(PLAT)

# Create a list of targets
MODULE_A= etc
ENV_A= env
ALL_A= $(MODULE_A) $(ENV_A)

# Directory information
SOURCE_DIR= ../Source

MODULE_DIR=$(SOURCE_DIR)
MODULE_DIRS= $(foreach mod,$(MODULE_LIST),$(MODULE_DIR)/$(mod))
ENV_DIR= $(SOURCE_DIR)/env/$(ENV)

# +====================+
# | Begin targets      |
# +====================+

# Create phony targets
.PHONY: $(MODULE_DIRS)

# Default action: build file and executable
default: build executable

# Compilation rules for modules
$(MODULE_DIRS):
	@cd $@; make EXTCXXFLAGS="-DARCH=\\\"$(ARCH)\\\" -DARCH_$(ARCH)" --no-print-directory

# Environment compilation rules
env:
	@cd $(ENV_DIR); make EXTCXXFLAGS="-DARCH=\\\"$(ARCH)\\\" -DARCH_$(ARCH)" --no-print-directory

# Build rules
build: $(MODULE_DIRS) env

# Actually creating an executable
executable:
	@echo "Creating executable..."
	@$(LD) $(LDFLAGS) -Wl,--start-group $(foreach a_a,$(ALL_A),bin/lib$(a_a).a) -Wl,--end-group $(LDFLAGS)
	@echo "Done."

# Get binary sizes
size:
	@echo "Binary sizes for $(ARCH) architecture:"
	@size -G -x bin/lib* -t | grep -E "TOTALS|filename"

# Clean out each directory
clean: $(patsubst %,%.clean,$(notdir $(MODULE_DIRS))) $(ENV_DIR).clean
	rm -f a.out a.exe bin/*

%.clean:
	@cd ../Source/$(patsubst %.clean,%,$@); make clean --no-print-directory
	@rm -f /mnt/v/lib/memmap*
