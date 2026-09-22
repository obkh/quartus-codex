#include "system.h"
#include "io.h"
#include "altera_avalon_pio_regs.h"
#include "altera_avalon_timer_regs.h"

/* Active-low seven-segment codes, bits [6:0] = g,f,e,d,c,b,a. */
static const unsigned char digit_segments[9] = {
    0x40, /* 0 */
    0x79, /* 1 */
    0x24, /* 2 */
    0x30, /* 3 */
    0x19, /* 4 */
    0x12, /* 5 */
    0x02, /* 6 */
    0x78, /* 7 */
    0x00  /* 8 */
};

static void wait_one_second(void)
{
    /* Hardware period is configured to 1000 ms in Platform Designer. */
    IOWR_ALTERA_AVALON_TIMER_STATUS(INTERVAL_TIMER_BASE, 0);
    IOWR_ALTERA_AVALON_TIMER_CONTROL(
        INTERVAL_TIMER_BASE,
        ALTERA_AVALON_TIMER_CONTROL_CONT_MSK |
        ALTERA_AVALON_TIMER_CONTROL_START_MSK);

    while ((IORD_ALTERA_AVALON_TIMER_STATUS(INTERVAL_TIMER_BASE) &
            ALTERA_AVALON_TIMER_STATUS_TO_MSK) == 0) {
        /* Poll the interval timer. */
    }

    IOWR_ALTERA_AVALON_TIMER_STATUS(INTERVAL_TIMER_BASE, 0);
}

int main(void)
{
    unsigned int digit = 0;

    for (;;) {
        IOWR_ALTERA_AVALON_PIO_DATA(HEX0_BASE, digit_segments[digit]);
        wait_one_second();
        digit = (digit == 8) ? 0 : digit + 1;
    }
}
