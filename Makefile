BOOTLOADER := bootloader.asm
OUT := bootloader.bin

FMT := raw

all: 
	nasm -f bin $(BOOTLOADER) -o $(OUT)
	qemu-system-x86_64 -drive format=$(FMT),file=$(OUT)

clean:
	rm -r $(OUT)
