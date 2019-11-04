;-----------------------------------------
; Macros
;-----------------------------------------
#LISTOFF

ldhxf   macro   par
        ldx     ~@~
        pshx
        pulh
        ldx     1+~@~
        endm

sthxf   macro   par
        stx     1+~@~
        pshh
        pulx
        stx     ~@~
        endm

req     macro       ;Return if eq
        bne     $+2+1
        rts
        endm

rlo     macro       ;Return if lo
        bhs     $+2+1
        rts
        endm

rne     macro           ;Return if not eq
        beq     $+2+1
        rts
        endm

rcc     macro           ;Return if Carry Clear
        bcs     $+2+1
        rts
        endm

rcs     macro   ;Return if Carry Set
        bcc     $+2+1
        rts
        endm



wt      macro   var     ;Wait timer
        jsr     LoSchedule
        tst     ~@~
        bne     $+2-7
        endm

sev     macro   num     ;Set EVent
        bset    ~@~&7,~@~/8+Events
        endm

cev     macro   num     ;Clear EVent
        bclr    ~@~&7,~@~/8+Events
        endm

;bec     macro   num,cimke       ;Branch if Event Clear
;        brclr   num&7,num/8+Events,cimke
;        endm

;bes     macro   num,cimke       ;Branch if Event Set
;        brset   num&7,num/8+Events,cimke
;        endm

;chval   macro   valtozo,min,max,alap
;        lda     valtozo
;        cmp     #1+max
;        bge     $+7+2
;        cmp     =(min-1)
;        ble     $+3+2
;        clc
;        bra     $+4+2
;        mov     =alap,valtozo
;        sec
;        endm

;#macro declim valtozo,min
;        psha
;        lda     valtozo
;        cmp     =min
;        bhi     $+4
;        bra     $+4
;        dec     valtozo
;        pula
;#endm
;#macro inclim valtozo,max
;        psha
;        lda     valtozo
;        cmp     =max
;        blo     $+4
;        bra     $+4
;        inc     valtozo
;        pula
;#endm
clrw    macro   val
        clr     ~@~
        clr     1+~@~
        endm
;#macro lslan x
;        pshx
;        ldx     x
;        jsr     lslen
;        pulx
;#endm
;#macro lsran x
;        pshx
;        ldx     x
;        jsr     lsren
;        pulx
;#endm
adhx    macro   par
        lda     ~1~             ;hi (4,sp lesz a rutinhivas utan)
        psha
        lda     1+~1~           ;lo (3,sp lesz a rutinhivas utan)
        psha
        jsr     addhxands
        ais     =2
        endm
adhxk   macro   par
        lda     #~1~>8        ;hi (4,sp lesz a rutinhivas utan)
        psha
        lda     #~1~&255        ;lo (3,sp lesz a rutinhivas utan)
        psha
        jsr     addhxands
        ais     =2
        endm

subhx   macro   par
        lda     ~1~     ;hi (4,sp lesz a rutinhivas utan)
        psha
        lda     ~1~+1   ;lo (3,sp lesz a rutinhivas utan)
        psha
        jsr     subhxands
        ais     =2
        endm

subhxk  macro   par
        lda     #~1~>8     ;hi (4,sp lesz a rutinhivas utan)
        psha
        lda     #~1~#255   ;lo (3,sp lesz a rutinhivas utan)
        psha
        jsr     subhxands
        ais     =2
        endm

;#macro mulhxw par        ; HX * par16 = arit32
;        pshh                    ;hi
;        pula
;        sta     arit32+2
;        stx     arit32+3        ;lo
;        mov     par,yy+2        ;hi
;        mov     par+1,yy+3      ;lo
;        jsr     szor16bit
;        ldhx    arit32+2
;        ;itt arit32-ben van az eredmeny!
;#endm
;#macro mulhxb par        ; HX * par8 = arit32
;        pshh                    ;hi
;        pula
;        sta     arit32+2
;        stx     arit32+3        ;lo
;        clr     yy+2          ;hi
;        mov     par,yy+3      ;lo
;        jsr     szor16bit
;        ldhx    arit32+2
;        ;itt arit32-ben van az eredmeny!
;#endm
;#macro mulhxk kost        ; HX * par16 = arit32
;        pshh                    ;hi
;        pula
;        sta     arit32+2
;        stx     arit32+3        ;lo
;        mov     =HIGH(kost),yy+2        ;hi
;        mov     =LOW(kost),yy+3      ;lo
;        jsr     szor16bit
;        ldhx    arit32+2
;        ;itt arit32-ben van az eredmeny!
;#endm

;#macro divhx par16        ; arit32 / par16 = HX
;        clr     yy
;        clr     yy+1
;        mov     par16,yy+2
;        mov     par16+1,yy+3
;        jsr     oszt32bit
;        ldhx    arit32+2
;#endm
;#macro divhxk kost        ; arit32 / par16 = HX
;        clr     yy
;        clr     yy+1
;        mov     =HIGH(kost),yy+2
;        mov     =LOW(kost),yy+3
;        jsr     oszt32bit
;        ldhx    arit32+2
;#endm

fwd     macro
        sta     COPCTL
        endm

;#macro StopTask
;        jsr     LoSchedule
;        bra     $-3
;#endm
;#macro jeq cim
;        bne     $+5
;        jmp     cim
;#endm
;#macro jne cim
;        beq     $+5
;        jmp     cim
;#endm
;#macro jnz cim
;        beq     $+5
;        jmp     cim
;#endm
;#macro jseq ertek,cim
;        cmp     ertek
;        beq     $+4
;        bra     $+7
;        psha
;        jsr     cim
;        pula
;#endm
;#macro breq ertek,cim
;        cmp     ertek
;        beq     cim
;#endm
;#macro brne ertek,cim
;        cmp     ertek
;        bne     cim
;#endm
;#macro clrf cim
;        psha
;        clra
;        sta     cim
;        pula
;#endm
;#macro rnz
;        beq     $+2+1
;        rts
;#endm

#LISTON

