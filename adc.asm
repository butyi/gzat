;-----------------------------------------
; Analogue Digital Converter module handler and task
;-----------------------------------------

;-----------------------------------------
; Variables
;-----------------------------------------
#ifdef VARIABLE_SEGMENT

ADC_CHAN_NUM    equ     6

adc_chan        ds      1
adc_vals        ds      ADC_CHAN_NUM*2  ; Word for every channel

#endif

#ifdef CODE_SEGMENT

;-----------------------------------------
; Constants
;-----------------------------------------
adc_chnlst
        db      0,1,2,3,5,6

;-----------------------------------------
; Interrupt Vectors
;-----------------------------------------
adc_org
        org     Vadc            ; ADC IT entry
        dw      ADC_IT
        org     adc_org

;-----------------------------------------
; Functions
;-----------------------------------------
ADC_Init
        lda     #ADIV_8+ADC_RIGHT       ; ADC clock register   (cgmxclk/8 appr. 1Mhz)
        sta     ADCLK
        lda     #AIEN           ; Interrupt mode and continuous
        ora     adc_chnlst      ; Start with first channel
        sta     ADSCR

        mov     #30,adc_timer   ; Pull up task timer

        lda     ADRH
        lda     ADRL
        clr     adc_chan
	
	rts

ADC_IT
        ; Save H
        pshh

        ; Store converted value into adc_vals array, Channels are 10 bit long.
        clrh
        ldx     adc_chan
        lslx			; *2 , because data is 2 bytes long
        lda     ADRH
        sta     adc_vals,x        
        lda     ADRL
        sta     adc_vals+1,x        

        ; Search next channel (adc_chan++)
        lda     adc_chan
        inca
        cmp     #ADC_CHAN_NUM
        blo     ADC_IT_1
        clra
ADC_IT_1
        sta     adc_chan
        tax
        clrh
        lda     adc_chnlst,x	; Read channel index fron config array, because channels are not in order on this hardware
        ora     #AIEN           ; ADSCR = adc_chan | AIEN
        sta     ADSCR

        ; That's all, restore H
        pulh
        
        ; Exit from interrupt
        rti

ADC_Task
        jsr     LoSchedule

        ; Check if timer elapsed
        tst     adc_timer
        bne     ADC_Task

        ; Time elapsed, pull up timer
        mov     #30,adc_timer

;        ; Print out ADC values
;        clrh
;        clrx
;ADC_Task_1
;        lda     adc_vals,x
;        jsr     sciputb
;        incx
;        txa
;        cmp     #ADC_CHAN_NUM*2
;        blo     ADC_Task_1
;        lda     #$0a
;        bsr     sciputc

        ; Again
        bra     ADC_Task



#endif

