;-----------------------------------------
; Time Base Module handler
;-----------------------------------------

;-----------------------------------------
; Variables
;-----------------------------------------
#ifdef VARIABLE_SEGMENT

#RAM

first_timer

#include "timers.asm"

last_timer

#endif


#ifdef CODE_SEGMENT

;-----------------------------------------
; Interrupt vectors
;-----------------------------------------
tbm_org
        org     Vtim
        dw      TBM_IT
        org     tbm_org

;-----------------------------------------
; Functions
;-----------------------------------------
TBM_Init
	; TMBCLKSEL is set to 1, so longer timings will be active
	; Divider 262144 needs TBR2-TBR0 = 010b with TMBCLKSEL=1.
	;   this will result 32.768ms timing with with 8MHz CGMXCLK
        mov     #TBON_+TBR1_+TBIE_,TBCR ; switch on, set TBR1_ and enable interrupt

        ; Clear all timers
        ldx     #last_timer-first_timer ; Load number of used timers
        clrh
TBM_I_c        
        clr     first_timer-1,x
        dbnzx   TBM_I_c

        rts



TBM_IT
; Go through on all timers and decrement if not zero
        ldx     #last_timer-first_timer ; Load number of used timers
        clrh
TBM_IT_c        
        tst     first_timer-1,x
        beq     TBM_IT_nodec
        dec     first_timer-1,x
TBM_IT_nodec
        dbnzx   TBM_IT_c
        
        bset    TACK.,TBCR
        rti



#endif

