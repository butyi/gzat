;-----------------------------------------
; CAN handling
;-----------------------------------------

#ifdef VARIABLE_SEGMENT
;-----------------------------------------
; Configuration
;-----------------------------------------

MESSAGE2SCI     equ     1

;-----------------------------------------
; Macros
;-----------------------------------------
        ;       7       6       5       4       3       2       1       0
        ; 0     ID28    ID27    ID26    ID25    ID24    ID23    ID22    ID21
        ; 1     ID20    ID19    ID18    SRR(=1) IDE(=1) ID17    ID16    ID15
        ; 2     ID14    ID13    ID12    ID11    ID10    ID9     ID8     ID7
        ; 3     ID6     ID5     ID4     ID3     ID2     ID1     ID0     RTR

; Phys to Log ID converter macro (move from macro parameter to can_id)
LD_CAN_ID       macro   id      ; id is like 0x19FE110B
        mreq    1:CAN ID must be defined in macro LD_CAN_ID
        lda     #~1~>21&0xFF
        sta     can_id

        ;  A transmitter shall only send recessive SRR bits + IDE bit.
        lda     #~1~>13&0xE0|0x18
        ora     #~1~>15&0x07
        sta     can_id+1

        lda     #~1~>7&0xFF
        sta     can_id+2

        lda     #~1~<1&0xFE
        sta     can_id+3

        endm

; Phys to Log ID converter macro (compare between macro parameter and can_id)
CMP_CAN_ID      macro   id      ; id is like 0x19FE110B
        mreq    1:CAN ID must be defined in macro CMP_CAN_ID
        lda     #~1~>21&0xFF
        cmp     can_id
        bne     $+2+0x12

        lda     #~1~>13&0xE0|0x08       ; 0x08 IDE
        ora     #~1~>15&0x07
        cmp     can_id+1
        bne     $+2+0x0A

        lda     #~1~>7&0xFF
        cmp     can_id+2
        bne     $+2+0x04

        lda     #~1~<1&0xFE
        cmp     can_id+3

        endm

;-----------------------------------------
; Variables
;-----------------------------------------

#XRAM
can_buff_len    equ     14
can_message     ds      can_buff_len    ; Structure is same as in uC
can_id          equ     can_message
can_data        equ     can_message+4
can_dlc         equ     can_message+12
can_prio        equ     can_message+13

#endif

#ifdef CODE_SEGMENT

;-----------------------------------------
; Functions
;-----------------------------------------

; Initialize CAN module with
; - Baud rate 250k
; - 29bit ID
; - fully open acceptance filter
CAN_Init
        ; CAN Module Control Register 0
        lda     CMCR0
        ora     #SFTRES         ; Soft reset=1 to allow writing all registers
        sta     CMCR0

        ; CAN Module Control Register 1
        clra
        sta     CMCR1           ; Clock source= CGMXCLK/2

        ; CAN Bus Timing Register 0
        lda     #SJW_2+BR_250   ; Synchronization jump width 1 Tq clock cycle
        sta     CBTR0

        ; CAN Bus Timing Register 1
        lda     #$14            ; (TSEG2(2) | TSEG1(5))
        sta     CBTR1

        ; CAN Identifier Acceptance Control Register
        lda     #IDAM_32        ; One 32 bit acceptance filter    (r/w)
        sta     CIDAC

        ; CAN Identifier Acceptance Registers
        clra
        sta     CIDAR0
        sta     CIDAR1
        sta     CIDAR2
        sta     CIDAR3

        ; CAN Identifier Mask Registers
        lda     #$FF
        sta     CIDMR0
        sta     CIDMR1
        sta     CIDMR2
        sta     CIDMR3

        ; CAN Module Control Register 0
        lda     CMCR0
        and     #$FE            ; Soft reset=0
        sta     CMCR0

        ; CAN Receiver Interrupt Enable Register
        clra
        sta     CRIER           ; No interrupt enabled

        ; Pull up timer
        mov     #150,can_timer

        rts

; Check if CAN message was received. Carry bit shows boolean retorn value. If received, carry is set, can_message contains the message.
CAN_getm
        lda     CRFLG
        and     #RXF
        beq     CAN_getm_nm

        ; Save CAN buffer in RAM
        clrh
        ldx     #can_buff_len+1
CAN_getm_1
        lda     CRXBUF-1,x
        sta     can_message-1,x
        dbnzx   CAN_getm_1

        ; Mask our SRR to accept any value of SRR
        ;  Receivers shall accept recessive or dominant SRR bits.
        lda     can_id+1
        and     #$EF
        sta     can_id+1

        ; Clear Rx Buffer flag by writing 1 to register
        lda     #$FF
        sta     CRFLG

#ifdef MESSAGE2SCI
        ; Print message on SCI
        @putk   'R'
        jsr     msg2sci
#endif
        sec                     ; return value: new message available
        rts
CAN_getm_nm                     ; No message received
        clc
        rts

; Transmit a CAN message. Message data to be prepared in can_message.
CAN_putm
        ; Wait for previous message is sent to be CAN buffer empty
        lda     CTFLG
        and     #TXE0
        bne     CAN_putm_ok
        jsr     LoSchedule
        bra     CAN_putm
CAN_putm_ok

        ; Copy data from RAM to CAN buffer
        clrh
        ldx     #can_buff_len+1
CAN_putm_1
        lda     can_message-1,x
        sta     CTXBUF0-1,x
        dbnzx   CAN_putm_1

        ; Clear Transmitter Buffer 0 Empty flag by writing 1 to register
        lda     #TXE0
        sta     CTFLG

#ifdef MESSAGE2SCI
        ; Print message on SCI
        @putk   'S'
        bsr     msg2sci
#endif
        rts

; Recovery CAN in case of busoff
CAN_recov
        lda     CRFLG
        and     #BOFFIF
        beq     CAN_noboff
        jsr     CAN_Init
CAN_noboff
        rts


; Sends a message every 1s and received messages are printed on SCI
CAN_Task
        jsr     LoSchedule

        bsr     CAN_recov

        tst     can_timer       ; Check timer
        beq     CAN_Task_sm     ; Send message when time expired

        bsr     CAN_getm        ; Read CAN message
        bcc     CAN_Task        ; No message received
        ; Check message ID
        @CMP_CAN_ID     0x18FE110B
        bne     CAN_Task        ; Not this message received

        ; Here handle message $19FE110B
        ;  Send same data back with different ID to test LD_CAN_ID macro
        @LD_CAN_ID     0x0CEE222F
        clra
        sta     can_data
        sta     can_data+1
        bsr     CAN_putm

        bra     CAN_Task

CAN_Task_sm
        ; Pull up timer
        mov     #61,can_timer

        ; Transmit a test message
;        @LD_CAN_ID     0x1CE0C0B0
;        clr     can_data
;        clr     can_data+1
;        clr     can_data+2
;        clr     can_data+3
;        clr     can_data+4
;        clr     can_data+5
;        clr     can_data+6
;        clr     can_data+7
;        bsr     CAN_putm

        bra     CAN_Task

#ifdef MESSAGE2SCI
msg2sci
        @putk   ' '

        lda     can_id+0
        lsra
        lsra
        lsra
        jsr     sciputb

        lda     can_id+0
        lsla
        lsla
        lsla
        lsla
        lsla
        and     #$E0
        psha
        lda     can_id+1
        lsra
        lsra
        lsra
        and     #$1C
        ora     1,sp
        sta     1,sp
        lda     can_id+1
        lsra
        and     #$03
        ora     1,sp
        ais     #1
        jsr     sciputb

        lda     can_id+1
        rora
        rora
        and     #$80
        psha
        lda     can_id+2
        lsra
        and     #$7F
        ora     1,sp
        ais     #1
        jsr     sciputb

        lda     can_id+2
        rora
        rora
        and     #$80
        psha
        lda     can_id+3
        lsra
        and     #$7F
        ora     1,sp
        ais     #1
        jsr     sciputb
        @putk   ' '

        lda     can_data+0
        jsr     sciputb
        lda     can_data+1
        jsr     sciputb
        lda     can_data+2
        jsr     sciputb
        lda     can_data+3
        jsr     sciputb
        lda     can_data+4
        jsr     sciputb
        lda     can_data+5
        jsr     sciputb
        lda     can_data+6
        jsr     sciputb
        lda     can_data+7
        jsr     sciputb
        @putn
        rts
#endif

#endif

