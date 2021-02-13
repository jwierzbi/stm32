#
# project: 01_minimal
#

AS=arm-none-eabi-as
LD=arm-none-eabi-ld
SIZE=arm-none-eabi-size
OBJCOPY=arm-none-eabi-objcopy
OBJDUMP=arm-none-eabi-objdump

SRCDIR := src
OUTDIR := out
objects := \
	main.o

.PHONY = all
all: $(OUTDIR)/main.elf

.PHONY = binary
binary: $(OUTDIR)/main.bin

$(OUTDIR)/main.bin: $(OUTDIR)/main.elf
	$(OBJCOPY) -Obinary $< $@

# 0x08000000 is where the flash memory starts so we're telling the linker
# to write our code under that address
$(OUTDIR)/main.elf: $(addprefix $(OUTDIR)/,$(objects))
	$(LD) -Map=$(OUTDIR)/main.map -Ttext 0x08000000 $^ -o $@
	$(OBJDUMP) -S $@ > $(OUTDIR)/list.lst
	$(SIZE) $@

$(OUTDIR)/%.o: $(SRCDIR)/%.S $(OUTDIR)
	$(AS) -Isrc -g $< -o $@

$(OUTDIR):
	mkdir -p $@

.PHONY = flash
flash: $(OUTDIR)/main.elf
	openocd \
		-s /usr/share/openocd/scripts \
		-f board/st_nucleo_f103rb.cfg \
		-c "program $< verify reset exit"

.PHONY = debug
debug: $(OUTDIR)/main.elf
	arm-none-eabi-gdb $< -tui -ex "target remote | \
		openocd -s /usr/share/openocd/scripts \
		-f board/st_nucleo_f103rb.cfg \
		-c \"gdb_flash_program enable; gdb_port pipe; log_output $(OUTDIR)/openocd.log\"" \
		-ex "monitor program $< verify" \
		-ex "monitor reset halt"

.PHONY = help
help:
	@echo "Usage:"
	@echo "  make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  (default)    builds main.elf file"
	@echo "  binary       builds main.bin binary file"
	@echo "  flash        flashes main.elf to the device"
	@echo "  debug        flashes main.elf to the device and runs GDB"
	@echo "  help         prints this help"

.PHONY = clean
clean:
	rm -rf $(OUTDIR)
