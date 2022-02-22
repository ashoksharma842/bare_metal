#include <stdint.h>

#define SRAM_START	0x2000000
#define SRAM_SIZE	(16U * 1024U)
#define SRAM_END	(SRAM_START + SRAM_SIZE)

#define STACK_START	SRAM_END

extern uint32_t _etext;
extern uint32_t _edata;
extern uint32_t _sdata;
extern uint32_t _ebss;
extern uint32_t _sbss;

int main (void);
void Reset_handler(void);
void NMI_handler(void)	__attribute__((weak, alias("Default_handler")));

uint32_t vectors[] __attribute__ ((section (".isr_vector"))) = {
	STACK_START,
	(uint32_t)&Reset_handler,
	(uint32_t)&NMI_handler
	
};

void Default_handler(void)
{
	while(1);
}
void Reset_handler(void)
{
	uint32_t size = &_edata - &_sdata;
	
	uint8_t *pDst = (uint8_t*)&_sdata;
	uint8_t *pSrc = (uint8_t*)&_etext;
	
	for(uint32_t i=0; i < size; i++){
		*pDst++ = *pSrc++;
	}
	
	size = &_ebss - &_sbss;
	pDst = (uint8_t*)_sbss;
	// pSrc = (uint8_t*)_ebss;
	for(uint32_t i=0; i < size; i++){
		*pDst++ = *pSrc++;
	}

	main();
}