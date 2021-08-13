ENTRY(_start)

SECTIONS
{
	. = 0x10000;
	.text : { *(.text) }
	. = 0x10200;
	.bss : { *(.bss) }
}
