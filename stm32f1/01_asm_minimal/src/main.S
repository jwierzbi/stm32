/*
 * Minimal example of assembly program.
 *
 * This program does nothing beside setting up a stack pointer, jumping to a
 * reset handler and going into infinite loop.
 *
 * Target MCU: STM32f103RB
 *
 * Memory:
 *     0x08000000 - 0x08020000 flash (128KB)
 *     0x20000000 - 0x20005000 ram   (20KB)
 */

    .syntax unified @ we're using new unified ARM syntax
    .cpu cortex-m3  @ selects target process (same as command line -mcpu)
    .thumb          @ we're using thumb instruction set

/* ----- define constant ---------------------------------------------------- */

    /* Initial value of the stack pointer. The RAM memory starts at 0x20000000
     * has size of 20KB. This stack is placed 256 (0x100) bytes after the
     * beginning of the ram memory.
     * Stack grows down towards 0x20000000. */
    .equ STACK_TOP, 0x20000100

/* ----- header ------------------------------------------------------------- */

    /* Default linker script requires this symbol to be present. Directive
     * .global exports this symbol so it's visible outside of this module. */
    .global _start

    /* This is a initialisation value for the stack. Boot process picks up this
     * value in the very beginning and sets up the stack pointer to this
     * address. */
    .word STACK_TOP

    /* Next word in a memory after stack address must be a reset handler
     * address. During boot process processor picks up this value and jumps
     * to it and by that starting code execution. */
    .word _Reset_Handler

    /* Since Cortex-M processors operate only in thumb mode all of the branch
     * addresses must have the LSb set. This indicates to the processor that
     * the mode is indeed thumb. Cleared LSb means that we're operating
     * in ARM mode which is not supported by Cortex-M architecture and would
     * cause and exception. */
    .type _Reset_Handler, function

/* ----- program ------------------------------------------------------------ */

    /* Beginning of the code section. In this case it's located just after
     * the reset handler address (0x00000004) so at 0x00000008. This is not
     * a rule (if the exception vector table was set up the code would be
     * placed after it). */
    .text

_start:
_Reset_Handler:
    /* code goes here */

loop:
    nop                     @ do nothing (no operation)
    b loop                  @ jump back to 'loop' label

    /* End of program. */
    .end

/* ----- end of program ----------------------------------------------------- */
