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
        ldhx    #300
        sthx    T1CH0
        sthx    T1CH0_RAM
        lda     #$FF
        sta     T1MODH          ; 122Hz, 16bit
        sta     T1MODL
        mov     #CHxIE|MSxA|TOVx|ELSx_2,T1SC0
        bclr    5,T1SC
        rts

        ;timer interrupt fills the real registers to prevent faulty PWM pulses
T1CH0_IT
        pshh
        ldhx    T1CH0_RAM
        sthx    T1CH0
        bclr    7,T1SC0         ; Clear interrupt flag
        pulh
        rti

PWM_Task
        jsr     LoSchedule

        sei
        ldhx    T1CH0_RAM
        aix     #-1
        sthx    T1CH0_RAM
        cli

        bra     PWM_Task





#endif
