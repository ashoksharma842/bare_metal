ENTRY(Reset_handler)

MEMORY
{
	FLASH(rx):ORIGIN =0x00000000,LENGTH =124K
	SRAM(rwx):ORIGIN =0x20000000,LENGTH =16K
}

SECTIONS
{
	.text :
	{
		*(.isr_vetor)
		*(.text)
		*(.rodata)
		_etext = .;
	}>FLASH
	.data :
	{
		_sdata = .;
		*(.data)
		_edata = .;
	}>SRAM AT> FLASH
	.bss :
	{
		_sbss = .;
		*(.bss)
		_ebss = .;
	}>SRAM
}