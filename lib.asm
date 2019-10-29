;-----------------------------------------
; Library functions
;-----------------------------------------

; hx = hx + a  (word)
addhxanda
        psha            ;save A
        txa             ;x (op1 lo)
        add     1,sp    ;+ (op2 lo)
        tax             ;store to X (op1 lo)

        pshh            ;h (op1 hi)
        pula            ; ----||----
        adc     #0      ;add carry
        psha            ;store to H (op1 hi)
        pulh            ; ----||----            
        
        pula            ;restore A
        rts

;Addition of two 16bits
addhxands
        ;lo-k
        txa
        add     3,sp
        tax
        ;hi-k
        pshh
        pula
        adc     4,sp
        psha
        pulh
        rts

;Subtraction of two 16bits
subhxands
        ;lo-k
        txa
        sub     3,sp
        tax
        ;hi-k
        pshh
        pula
        sbc     4,sp
        psha
        pulh
        rts


