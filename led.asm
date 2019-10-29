;-----------------------------------------
; Debug LED handler - Flashes the debug LED
;-----------------------------------------


#ifdef CODE_SEGMENT

;-----------------------------------------
; Configuration
;-----------------------------------------
LEDDDR  EQU     DDRC
LEDPORT EQU     PTC
LEDBIT  EQU     5
LEDMASK EQU     $20


;-----------------------------------------
; Macros
;-----------------------------------------
LEDINIT macro
        bset    LEDBIT,LEDDDR
        endm 

LEDNEG  macro
        lda     LEDPORT
        eor     LEDMASK
        sta     LEDPORT
        endm 

LEDOFF  macro
        bclr    LEDBIT,LEDPORT
        endm

LEDON   macro
        bset    LEDBIT,LEDPORT
        endm


;-----------------------------------------
; Functions
;-----------------------------------------

Led_Init
        @LEDINIT
        @LEDON
        rts

Led_Task
        bsr     LoSchedule

        ; Check if timer elapsed
        tst     led_timer
        bne     Led_Task

        ; Elapsed, pull up timer again for half sec
        mov     #15,led_timer

        ; Toggle LED
        @LEDNEG

        ; Again
        bra     Led_Task

#endif


