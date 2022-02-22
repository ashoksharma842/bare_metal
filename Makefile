CC = arm-none-eabi-gcc
MECH = cortex-m0
CFLAGS = -c -mthumb -mcpu=$(MECH) -O0 -Wall 
SPECS = -specs=nosys.specs
LDFLAGS = -nostdlib -T mylinker.ld -Wl,-Map=final.map
all:main.o strtup.o final.elf

#main.o : main.c gpio.c clk.c system_NUC230_240.c
main.o : main.c
	$(CC) $(CFLAGS) -o $@ $^

strtup.o : strtup.c
	$(CC) $(CFLAGS) -o $@ $^


final.elf: main.o strtup.o
	$(CC) $(LDFLAGS) -o $@ $^

embed : main.o gpio.c clk.c system_NUC230_240.c
	$(CC) $(CFLAGS) -o $@ $^
	
objdump : 
	arm-none-eabi-objdump.exe -d >log

clean :
	-rm *.o
