;-----------------------------------------
; Task handler
;-----------------------------------------

;-----------------------------------------
; Configuration
;-----------------------------------------
;RegSave_CCR     def     1
RegSave_A       def     1
RegSave_X       def     1
RegSave_H       def     1

TASKCOUNT       def     5

STACKLEN        def     64

#ifdef VARIABLE_SEGMENT

;-----------------------------------------
; Variables
;-----------------------------------------
#RAM
#ifdef RegSave_CCR
seged           ds      1
#endif

THTaskNum       ds      1       ; Number of currently running tasks
TaskSP          ds      2
GlobSP          ds      2
THStackAddr     ds      TASKCOUNT*2     ; Address of task stack pointers
THhx2           ds      2

#SEG1
THStack         ds      STACKLEN*TASKCOUNT      ; Task stack arrays

#endif

#ifdef CODE_SEGMENT

;-----------------------------------------
; Functions
;-----------------------------------------

; Check if number of task is not more that reserved memory
CheckTaskCount
        lda     THTaskNum
        cmp     #TASKCOUNT
        beq     CTC_ret
        bra     $               ; Intentional frozen!!! TASKCOUNT is too less.

TH_Init
        clr     THTaskNum
CTC_ret
        rts


; Start address is in H:X
CreateTask
        sthx    THhx2           ; Save start address
        ; Prepare task stack of task of THTaskNum with staff to neccessary to run
        clr     TaskSP
        clr     TaskSP+1
        ldx     THTaskNum       ;SP=&THStack[taszknum*STACKLEN]
        incx                    ;This is because stack is from higher address to lower
CT_c1
        tstx
        beq     CT_v

        lda     TaskSP+1
        add     #~STACKLEN>8
        sta     TaskSP+1

        lda     TaskSP
        adc     #STACKLEN>8
        sta     TaskSP

        decx
        bra     CT_c1
CT_v
        lda     TaskSP+1
        add     #~THStack-1>8   ; low
        sta     TaskSP+1

        lda     TaskSP
        adc     #THStack-1>8    ; high
        sta     TaskSP

        tsx
        sthx    GlobSP
        ldhx    TaskSP
        txs                     ; Switch to stack of selected task

        ; Fill up with content
        ldhx    THhx2           ; Get start address
        pshx                    ; Address low
        pshh                    ; Address high (like done by a jsr)
        clrx
#ifdef RegSave_CCR
        pshx            ;ccr
#endif
#ifdef RegSave_A
        pshx            ;a
#endif
#ifdef RegSave_X
        pshx            ;x
#endif
#ifdef RegSave_H
        pshx            ;h
#endif

        ; And back to the original stack
        tsx
        sthx    TaskSP
        ldhx    GlobSP
        txs

        ; Save stack pointer
        bsr     WrStackAddr

        ; Count number of created tasks
        inc     THTaskNum

        rts




LoSchedule
        sta     COPCTL          ; Watchdod feed
        ; PC remains on stack
        ; Save registers of stack
#ifdef RegSave_CCR
        sta     seged
        tpa
        psha
        lda     seged
#endif
        sei
#ifdef RegSave_A
        psha
#endif
#ifdef RegSave_X
        pshx
#endif
#ifdef RegSave_H
        pshh
#endif

        ; Save stack pointer
        tsx
        sthx    TaskSP
        bsr     WrStackAddr

        ; Search next task
        inc     THTaskNum
        lda     THTaskNum
        cmp     #TASKCOUNT
        bne     LS_kov
        clr     THTaskNum
LS_kov
        ; Get stack pointer of next task
        ; TaskSP = THStackAddr[THTaskNum];
        ldx     THTaskNum
        lslx                    ; *2
        clrh
        lda     THStackAddr,x   ; hi
        psha
        lda     THStackAddr+1,x ; lo
        pulh
        tax
        txs

        ; Restore registers
#ifdef RegSave_H
        pulh
#endif
#ifdef RegSave_X
        pulx
#endif
#ifdef RegSave_A
        pula
#endif
#ifdef RegSave_CCR
        sta     seged
        pula
        and     #$F7    ;Enable IT ~$08
        tap
        lda     seged
#endif
        cli

        ; Jump to saved address
        rts



StartTasks
        ; Start with first task
        clr     THTaskNum
        bra     LS_kov

;-----------------------------------------
; Subroutines
;-----------------------------------------

; THStackAddr[THTaskNum] = TaskSP;
WrStackAddr
        ldx     THTaskNum
        lslx
        clrh
        lda     TaskSP            ;Address hi
        sta     THStackAddr,x
        lda     TaskSP+1          ;Address lo
        sta     THStackAddr+1,x
        rts

#endif







