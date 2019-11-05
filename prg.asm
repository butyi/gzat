;-----------------------------------------
; GZAT - Application Template for MC68HC908GZ60
;  [Janos BENCSIK 2019.07.30.]
;-----------------------------------------



#include "gz60.asm"             ; Load microcontroller specific register definitions

;-----------------------------------------
; VARIABLES
;-----------------------------------------
#RAM
VARIABLE_SEGMENT def 1

#include "tly08.asm"            ; Task handler
#include "tbm.asm"              ; Time Base Module
#include "adc.asm"              ; Analogue Digital Converter
#include "can.asm"              ; CAN
#include "pwm.asm"              ; Pulse Width Modulation

#undef VARIABLE_SEGMENT

        org     Vreset
        dw      entry

stack_top       equ     $43F    ; 64 byte stack reserved for bootloader

;-----------------------------------------
; CODE
;-----------------------------------------
#XROM
prg_start
;-----------------------------------------
; INCLUDES
;-----------------------------------------
CODE_SEGMENT def 1

#include "mac.asm"              ; Useful macros
#include "lib.asm"              ; Library functions
#include "tly08.asm"            ; Task handler
#include "led.asm"              ; Debug LED flasher task
#include "sci.asm"              ; UART serial communication
#include "tbm.asm"              ; Time Base Module
#include "adc.asm"              ; Analogue Digital Converter
#include "can.asm"              ; CAN
#include "pwm.asm"              ; Pulse Width Modulation

#undef CODE_SEGMENT

;-----------------------------------------
; Main
;-----------------------------------------
entry
        sei

        ; Init Stack
        ldhx    #stack_top
        txs

        ; Init IO ports
        jsr     Led_Init

        ; Init Modules
        jsr     TBM_Init
        jsr     TH_Init
        jsr     SCI_Init
        jsr     ADC_Init
        jsr     CAN_Init
        bsr     PWM_Init

        ; Create tasks
        ldhx    #Led_Task       ; Blink debug LED
        jsr     CreateTask
        ldhx    #SCI_Task       ; Echo and reset for download
        jsr     CreateTask
        ldhx    #ADC_Task       ; Print out ASC values on SCI
        jsr     CreateTask
        ldhx    #CAN_Task       ; CAN Echo and print out CAN messages on SCI
        jsr     CreateTask

        ; Check if number of task is not more that reserved memory
        jsr     CheckTaskCount

        ; Tasks can be started
        jsr     StartTasks


;-----------------------------------------
; Functions
;-----------------------------------------



end_prg         equ     $
prg_len         equ     end_prg-prg_start


