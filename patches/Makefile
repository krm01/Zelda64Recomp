# TODO set these when the makefile is called
DECOMP_PATH := ../lib/indigo
BASE_ELF := ../lib/indigo/zelda_ocarina_mq_dbg.elf

TARGET := patches.elf

CC      := clang
LD      := ld.lld
OBJCOPY := llvm-objcopy

CFLAGS   := -target mips -mips2 -mabi=32 -O2 -G0 -mno-abicalls -mno-odd-spreg -mno-check-zero-division \
			-fomit-frame-pointer -ffast-math -fno-unsafe-math-optimizations -fno-builtin-memset \
			-Wall -Wextra -Wno-incompatible-library-redeclaration -Wno-unused-parameter -Wno-unknown-pragmas -Wno-unused-variable -Wno-missing-braces -Wno-unsupported-floating-point-opt
CPPFLAGS := -nostdinc -D_LANGUAGE_C -DMIPS -I dummy_headers -I $(DECOMP_PATH)/include -I $(DECOMP_PATH)/src -I $(DECOMP_PATH)/assets -I../lib/rt64/include
LDFLAGS  := -nostdlib -T patches.ld -T syms.ld --just-symbols=$(BASE_ELF) --allow-multiple-definition -Map patches.map
BINFLAGS := -O binary --remove-section=.bss --remove-section=.pad --remove-section=.text

C_SRCS := __dummy.c #$(wildcard *.c)
C_OBJS := $(C_SRCS:.c=.o)
C_DEPS := $(C_SRCS:.c=.d)

DATABIN := $(TARGET:.elf=.bin)

$(DATABIN): $(TARGET)
	$(OBJCOPY) $(BINFLAGS) $(TARGET) $@

$(TARGET): $(C_OBJS) patches.ld syms.ld
	$(LD) $(C_OBJS) $(LDFLAGS) -o $@

$(C_OBJS): %.o : %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $< -MMD -MF $(@:.o=.d) -c -o $@

clean:
	rm -rf $(C_OBJS) $(TARGET) $(DATABIN)

-include $(C_DEPS)

.PHONY: clean
