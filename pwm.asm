;-----------------------------------------
; Pulse Width Modulation signal generation
;-----------------------------------------

#ifdef VARIABLE_SEGMENT
;-----------------------------------------
; Configuration
;-----------------------------------------

;-----------------------------------------
; Macros
;-----------------------------------------


;-----------------------------------------
; Variables
;-----------------------------------------
T1CH0_RAM       ds      2       ; RAM mirror of duty

#endif

#ifdef CODE_SEGMENT
;-----------------------------------------
; Interrupt Vectors
;-----------------------------------------
pwm_org
        org     Vtpm1ch0
        dw      T1CH0_IT
        org     pwm_org

;-----------------------------------------
; Functions
;-----------------------------------------
PWM_Init
        ;TimerInit
        mov     #TSTOP|TRST|PS_0,T1SC
        clrx
        stx     T1CH0H
        stx     T1CH0L
        decx
        stx     T1MODH          ; 122Hz, 16bit
        stx     T1MODL
        mov     #CHxIE|MSxA|TOVx|ELSx_2,T1SC0
        bclr    5,T1SC

        clr     T1CH0_RAM
        clr     T1CH0_RAM+1

        rts

        ;timer interrupt fills the real registers to prevent faulty PWM pulses
T1CH0_IT
        mov     T1CH0_RAM,T1CH0H
        mov     T1CH0_RAM+1,T1CH0L
        bclr    7,T1SC0
        rti

#endif
