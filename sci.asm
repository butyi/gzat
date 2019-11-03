;-----------------------------------------
; Serial Communication interface
;-----------------------------------------


;-----------------------------------------
; Strings
;-----------------------------------------
hexakars        
        db      '0123456789ABCDEF'

welcome fcs     'HC908GZ60 Application Template (github.com/butyi/gzat)',$0a



;-----------------------------------------
; Macros
;-----------------------------------------
putk    macro   char
        lda     #~1~
        jsr     sciputc
        endm

putn    macro
        lda     #$0A
        jsr     sciputc
        endm

;-----------------------------------------
; Functions
;-----------------------------------------
; Initialize SCI controller 57600 with 8Mhz Xtal
SCI_Init
        clr     SCC3
        mov     #SCBR_PD_1+SCBR_BD_1,SCBR
        mov     #$26,SCPSC
        mov     #ENSCI_,SCC1
        mov     #TE_+RE_,SCC2
        rts

SCI_Task
        ldhx    #welcome
        bsr     sciputs
SCI_T_c
        jsr     LoSchedule
        bsr     scigetc         ; Read character from serial port
        bcc     SCI_T_c
        cmp     #$1C            ; Download trigger character
        bne     SCI_Echo
        bra     $               ; Endless loop to force reset
SCI_Echo
        bsr     sciputc
        bra     SCI_T_c


; Prints a byte in hexa format from A.
sciputb
        pshh                    ; Save registers
        pshx
        psha
        nsa                     ; First upper 4 bits
        and     #$F
        tax
        clrh
        lda     hexakars,x
        bsr     sciputc
        lda     1,sp            ; Next lower 4 bits
        and     #$F
        tax
        clrh
        lda     hexakars,x
        bsr     sciputc
        pula                    ; Restore registers
        pulx
        pulh
        rts

; Tries to read character from SCI. Carry bit shows if there is received character in A or not.
scigetc
        brclr   5,SCS1,gc_nothing ; SCRF = 1 ?
        lda     SCDR
        sec                     ; RX info in carry bit
        rts
gc_nothing
        clc
        rts

; Prints a string. String address is in H:X.
sciputs
        lda     ,x
        beq     scips_v
        bsr     sciputc
        aix     #1
        bra     sciputs
scips_v
        rts


; Prints a character from A.
sciputc
        jsr     LoSchedule
        brclr   7,SCS1,sciputc  ; wait to send out the previous character
        sta     SCDR            ; also SCTE is cleared here
        rts


