```makefile
ASM = nasm
LD = ld

TARGET = hexdump
SRC = hexdump.asm
OBJ = hexdump.o

ASMFLAGS = -f elf64 -Wall -Werror -g -F dwarf

.PHONY: all clean run debug

all: $(TARGET)

$(TARGET): $(OBJ)
	$(LD) -o $@ $^

$(OBJ): $(SRC)
	$(ASM) $(ASMFLAGS) -o $@ $<

run: $(TARGET)
	./$(TARGET)

debug: $(TARGET)
	gdb ./$(TARGET)

clean:
	rm -f $(OBJ) $(TARGET)
```
