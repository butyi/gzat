;-----------------------------------------
; Microcontroller specific register definitions
;-----------------------------------------
                    #LISTOFF

;*******************************************************************************
;*            HC08GZ60 FRAMEWORK INCLUDE FILE FOR ASM8 ASSEMBLER               *
;*******************************************************************************
;*            FREEWARE, written by Janos BENCSIK  <hc08@butyi.hu>              *
;*******************************************************************************

;                    #Uses     macros.inc
;                    #Message  **********************
;                    #Message  * Target: HC908GZ60  *
;                    #Message  **********************

                    #HcsOff
                    #NoMMU                        ;MMU not available
                    #MAPOFF
                    #EXTRAON

_GZ_                def       60
FLL_FACTOR          def       256                 ;dummy to silence generic warning

;*******************************************************************************
;* Author: Janos Bencsik  <hc08@butyi.hu>
;*
;* Description: Register and bit name definitions for HC908GZ60
;*
;* Documentation: HC908GZ60 family Data Sheet for register and bit explanations
;* See CPU08 Reference Manual for explanation of equate files
;*
;* Assembler:  ASM8 by Tony G. Papadimitriou <tonyp@acm.org>
;*******************************************************************************



;       IO DEFINITIONS FOR MC68HC908GZ32/GZ48/GZ60
; ************ PORTS section ************ 
PTA                 def       $00,1                     ; port A 
PTB                 def       $01,1                     ; port B 
PTC                 def       $02,1                     ; port C 
PTD                 def       $03,1                     ; port D 
DDRA                def       $04,1                     ; data direction port A 
DDRB                def       $05,1                     ; data direction port B 
DDRC                def       $06,1                     ; data direction port C 
DDRD                def       $07,1                     ; data direction port D 
PTE                 def       $08,1                     ; port E 
DDRE                def       $0c,1                     ; data direction port E 
PTAPUE              def       $0d,1                     ; pull-up enable port A 
PTCPUE              def       $0e,1                     ; pull-up enable port C 
PTDPUE              def       $0f,1                     ; pull-up enable port D 
PTF                 def       $440,1                    ; port F 
PTG                 def       $441,1                    ; port G 
DDRF                def       $444,1                    ; data direction port F 
DDRG                def       $445,1                    ; data direction port G 
; ************ SPI section ************ 
SPCR                def       $10,1                     ; SPI control register 

SPRIE   EQU $80 ;  SPI Receiver interrupt enable
DMAS    EQU $40 ;  DMA select
SPMSTR  EQU $20 ;  SPI master
CPOL    EQU $10 ;  Clock polarity
CPHA    EQU $08 ;  Clock phase
SPWOM   EQU $04 ;  SPI wired-OR mode
SPE     EQU $02 ;  SPI enable
SPTIE   EQU $01 ;  SPI transmit interrupt enable

SPSCR               def       $11,1                     ; SPI control/status register 

SPRF    EQU $80 ;  SPI Receiver interrupt enable
ERRIE   EQU $40 ;  Error interrupt enable
OVRF    EQU $20 ;  Overflow flag
MODF    EQU $10 ;  Mode fault
SPTE    EQU $08 ;  SPI transmitter empty
MODFEN  EQU $04 ;  Mode fault enable

SPBD_2  EQU $00 ;  Baud rate master divisor 2
SPBD_8  EQU $01 ;  Baud rate master divisor 8
SPBD_32 EQU $02 ;  Baud rate master divisor 32
SPBD_128        EQU $03 ;  Baud rate master divisor 128

SPDR                def       $12,1                     ; SPI data register 
; ************ ESCI section ************ 
SCPSC               def       $09,1                     ; ESCI prescaler register 

; Prescaler Divisor (PDS)
PDS_DIV_BY_1        equ       %00000000                 ; Bypass this prescaler
PDS_DIV_BY_2        equ       %00100000
PDS_DIV_BY_3        equ       %01000000
PDS_DIV_BY_4        equ       %01100000
PDS_DIV_BY_5        equ       %10000000
PDS_DIV_BY_6        equ       %10100000
PDS_DIV_BY_7        equ       %11000000
PDS_DIV_BY_8        equ       %11100000

  ; PSSB[4:3:2:1:0] Prescaler Divisor Fine Adjust (PDFA)
PSSB_0P32           equ       %00000000                 ; 0
PSSB_1P32           equ       %00000001                 ; 0.03125
PSSB_2P32           equ       %00000010                 ; 0.0625
PSSB_3P32           equ       %00000011                 ; 0.09375
PSSB_4P32           equ       %00000100                 ; 0.125
PSSB_5P32           equ       %00000101                 ; 0.15625
PSSB_6P32           equ       %00000110                 ; 0.1875
PSSB_7P32           equ       %00000111                 ; 0.21875
PSSB_8P32           equ       %00001000                 ; 0.25
PSSB_9P32           equ       %00001001                 ; 0.28125
PSSB_10P32          equ       %00001010                 ; 0.3125
PSSB_11P32          equ       %00001011                 ; 0.34375
PSSB_12P32          equ       %00001100                 ; 0.375
PSSB_13P32          equ       %00001101                 ; 0.40625
PSSB_14P32          equ       %00001110                 ; 0.4375
PSSB_15P32          equ       %00001111                 ; 0.46875
PSSB_16P32          equ       %00010000                 ; 0.5
PSSB_17P32          equ       %00010001                 ; 0.53125
PSSB_18P32          equ       %00010010                 ; 0.5625
PSSB_19P32          equ       %00010011                 ; 0.59375
PSSB_20P32          equ       %00010100                 ; 0.625
PSSB_21P32          equ       %00010101                 ; 0.65625
PSSB_22P32          equ       %00010110                 ; 0.6875
PSSB_23P32          equ       %00010111                 ; 0.71875
PSSB_24P32          equ       %00011000                 ; 0.75
PSSB_25P32          equ       %00011001                 ; 0.78125
PSSB_26P32          equ       %00011010                 ; 0.8125
PSSB_27P32          equ       %00011011                 ; 0.84375
PSSB_28P32          equ       %00011100                 ; 0.875
PSSB_29P32          equ       %00011101                 ; 0.90625
PSSB_30P32          equ       %00011110                 ; 0.9375
PSSB_31P32          equ       %00011111                 ; 0.96875


SCIACTL             def       $0a,1                     ; ESCI arbiter control register 
AM1     EQU $80 ;  Loop mode select bit
ALOST   EQU $40 ;  Enable SCI bit
AM0     EQU $20 ;  Transmit invertion bit
ACLK    EQU $10 ;  Mode (character length) bit (0=8, 1=9)
AFIN    EQU $08 ;  Wake-up condition bit
ARUN    EQU $04 ;  Idle line type bit
AROVFL  EQU $02 ;  Parity enable bit
ARD8    EQU $01 ;  Parity bit (0=even, 1=odd)

SCIADAT             def       $0b,1                     ; ESCI arbiter control register 

SCC1                def       $13,1                     ; ESCI control register 1 

LOOPS.              def       7                         ; Loop mode select bit
ENSCI.              def       6                         ; Enable SCI bit
TXINV.              def       5                         ; Transmit invertion bit
M.                  def       4                         ; Mode (character length) bit (0=8, 1=9)
WAKE.               def       3                         ; Wake-up condition bit
ILTY.               def       2                         ; Idle line type bit
PEN.                def       1                         ; Parity enable bit
PTY.                def       0                         ; Parity bit (0=even, 1=odd)

LOOPS_              def       %10000000                 ; Loop mode select bit
ENSCI_              def       %01000000                 ; Enable SCI bit
TXINV_              def       %00100000                 ; Transmit invertion bit
M_                  def       %00010000                 ; Mode (character length) bit (0=8, 1=9)
WAKE_               def       %00001000                 ; Wake-up condition bit
ILTY_               def       %00000100                 ; Idle line type bit
PEN_                def       %00000010                 ; Parity enable bit
PTY_                def       %00000001                 ; Parity bit (0=even, 1=odd)

SCC2                def       $14,1                     ; ESCI control register 2 

SCTIE.              def       7                         ; SCI transmit interrupt enable bit
TCIE.               def       6                         ; Transmission complet interrupt enable bit
SCRIE.              def       5                         ; SCI receive interrupt enable bit
ILIE.               def       4                         ; Idle line interrupt enable bit
TE.                 def       3                         ; Transmitter enable bit
RE.                 def       2                         ; Receiver enable bit
RWU.                def       1                         ; Receiver wake-up bit
SBK.                def       0                         ; Send break bit

SCTIE_              def       %10000000                 ; SCI transmit interrupt enable bit
TCIE_               def       %01000000                 ; Transmission complet interrupt enable bit
SCRIE_              def       %00100000                 ; SCI receive interrupt enable bit
ILIE_               def       %00010000                 ; Idle line interrupt enable bit
TE_                 def       %00001000                 ; Transmitter enable bit
RE_                 def       %00000100                 ; Receiver enable bit
RWU_                def       %00000010                 ; Receiver wake-up bit
SBK_                def       %00000001                 ; Send break bit

SCC3                def       $15,1                     ; ESCI control register 3 

R8.                 def       7                         ; Received bit 8
T8.                 def       6                         ; Transmitted bit 8
DMARE.              def       5                         ; DMA receive enable bit
DMATE.              def       4                         ; DMA transfer enable bit
ORIE.               def       3                         ; Receiver overrun IT enable bit
NEIE.               def       2                         ; Receiver noise error IT enable bit
FEIE.               def       1                         ; Receiver framing error IT enable bit
PEIE.               def       0                         ; Receiver parity error IT enable bit

R8_                 def       %10000000                 ; Received bit 8
T8_                 def       %01000000                 ; Transmitted bit 8
DMARE_              def       %00100000                 ; DMA receive enable bit
DMATE_              def       %00010000                 ; DMA transfer enable bit
ORIE_               def       %00001000                 ; Receiver overrun IT enable bit
NEIE_               def       %00000100                 ; Receiver noise error IT enable bit
FEIE_               def       %00000010                 ; Receiver framing error IT enable bit
PEIE_               def       %00000001                 ; Receiver parity error IT enable bit


SCS1                def       $16,1                     ; ESCI status register 1 

SCTE.               def       7                         ; SCI transmitter empty bit
TC.                 def       6                         ; Transmission complet bit
SCRF.               def       5                         ; SCI receiver full bit
IDLE.               def       4                         ; Receiver idle bit
ORB.                def       3                         ; Receiver overrun bit
NF.                 def       2                         ; Receiver noise flag bit
FEBIT.              def       1                         ; Receiver framing error bit
PE.                 def       0                         ; Receiver parity error bit

SCTE_               def       %10000000                 ; SCI transmitter empty bit
TC_                 def       %01000000                 ; Transmission complet bit
SCRF_               def       %00100000                 ; SCI receiver full bit
IDLE_               def       %00010000                 ; Receiver idle bit
ORB_                def       %00001000                 ; Receiver overrun bit
NF_                 def       %00000100                 ; Receiver noise flag bit
FEBIT_              def       %00000010                 ; Receiver framing error bit
PE_                 def       %00000001                 ; Receiver parity error bit

SCS2                def       $17,1                     ; ESCI status register 2 

BKF     EQU $02 ;  Break flag bit
RPF     EQU $01 ;  Reception in progress flag bit

SCDR                def       $18,1                     ; ESCI data register 
SCBR                def       $19,1                     ; ESCI baud rate 

SCBR_PD_1           equ       $00                       ; Baud rate prescaling 1
SCBR_PD_3           equ       $10                       ; Baud rate prescaling 3
SCBR_PD_4           equ       $20                       ; Baud rate prescaling 4
SCBR_PD_13          equ       $30                       ; Baud rate prescaling 13
                                                       
SCBR_BD_1           equ       $00                       ; Baud rate scaling 1
SCBR_BD_2           equ       $01                       ; Baud rate scaling 2
SCBR_BD_4           equ       $02                       ; Baud rate scaling 4
SCBR_BD_8           equ       $03                       ; Baud rate scaling 8
SCBR_BD_16          equ       $04                       ; Baud rate scaling 16
SCBR_BD_32          equ       $05                       ; Baud rate scaling 32
SCBR_BD_64          equ       $06                       ; Baud rate scaling 64
SCBR_BD_128         equ       $07                       ; Baud rate scaling 128

; ************ KBD section ************ 
INTKBSCR            def       $1a,1                     ; keyboard control/status 
INTKBIER            def       $1b,1                     ; keyboard interrupt enable 
INTKBIPR            def       $448,1                    ; keyboard interrupt polarity 
; ************ TBM section ************ 
TBCR                def       $1c,1                     ; time base module control 

TBIF.               def       7
TBR2.               def       6
TBR1.               def       5
TBR0.               def       4
TACK.               def       3
TBIE.               def       2
TBON.               def       1
    
TBIF_               def       %10000000
TBR2_               def       %01000000
TBR1_               def       %00100000
TBR0_               def       %00010000
TACK_               def       %00001000
TBIE_               def       %00000100
TBON_               def       %00000010

; ************ CONFIG section ************ 
INTSCR              def       $1d,1                     ; IRQ status/control register 
CONFIG2             def       $1e,1                     ; configuration register 2 

SCIBDSRC.           def       0
OSCENINSTOP.        def       1
TMCLKSEL.           def       2
MSCANEN.            def       3

SCIBDSRC_           def       %00000001
OSCENINSTOP_        def       %00000010
TMCLKSEL_           def       %00000100
MSCANEN_            def       %00001000

CONFIG1             def       $1f,1                     ; configuration register 1 

COPRS.              def       7
LVISTOP.            def       6
LVIRSTD.            def       5
LVIPWRD.            def       4
LVI5OR3.            def       3
SSREC.              def       2
STOP.               def       1
COPD.               def       0
                   
COPRS_              def       %10000000
LVISTOP_            def       %01000000
LVIRSTD_            def       %00100000
LVIPWRD_            def       %00010000
LVI5OR3_            def       %00001000
SSREC_              def       %00000100
STOP_               def       %00000010
COPD_               def       %00000001

; ************ TIMER section ************ 
T1SC                def       $20,1                     ; timer 1 status/ctrl register 

PS_0  EQU $00   ;  Prescaler Select Bits
PS_1  EQU $01   ;  Prescaler Select Bits
PS_2  EQU $02   ;  Prescaler Select Bits
PS_3  EQU $03   ;  Prescaler Select Bits
PS_4  EQU $04   ;  Prescaler Select Bits
PS_5  EQU $05   ;  Prescaler Select Bits
PS_6  EQU $06   ;  Prescaler Select Bits
PS_7  EQU $07   ;  Prescaler Select Bits
TRST    EQU $10 ;  Timer Reset Bit
TSTOP   EQU $20 ;  Timer Stop Bit
TOIE    EQU $40 ;  Timer Overflow Interupt Enable
TOF     EQU $80 ;  Timer Overflow Flag

T1CNT               def       $21,2                     ; timer 1 counter register 
T1CNTH              def       $21,1                     ; timer 1 counter high 
T1CNTL              def       $22,1                     ; timer 1 counter low 
T1MOD               def       $23,2                     ; timer 1 modulo register 
T1MODH              def       $23,1                     ; timer 1 modulo high 
T1MODL              def       $24,1                     ; timer 1 modulo low 
T1SC0               def       $25,1                     ; timer 1 chan 0 status/ctrl 

CHxF    EQU $80 ;  Channel x Flag Bit
CHxIE   EQU $40 ;  Channel x Interupt Enable Bit
MSxB    EQU $20 ;  Mode Select B
MSxA    EQU $10 ;  Mode Select A
;       ELSx(c) ((c&3)<<2)      ;  Edge/Level Select Bits
ELSx_0 EQU $00
ELSx_1 EQU $04
ELSx_2 EQU $08
ELSx_3 EQU $0C
TOVx    EQU $02 ;  Toggle-On-Overflow Bit
CHxMAX  EQU $01 ;  Max Duty Cycle Bit

T1CH0               def       $26,2                     ; timer 1 chan 0 register 
T1CH0H              def       $26,1                     ; timer 1 chan 0 high 
T1CH0L              def       $27,1                     ; timer 1 chan 0 low 
T1SC1               def       $28,1                     ; timer 1 chan 1 status/ctrl 
T1CH1               def       $29,2                     ; timer 1 chan 1 register 
T1CH1H              def       $29,1                     ; timer 1 chan 1 high 
T1CH1L              def       $2a,1                     ; timer 1 chan 1 low 
T2SC                def       $2b,1                     ; timer 2 status/ctrl register 
T2CNT               def       $2c,2                     ; timer 2 counter register 
T2CNTH              def       $2c,1                     ; timer 2 counter high 
T2CNTL              def       $2d,1                     ; timer 2 counter low 
T2MOD               def       $2e,2                     ; timer 2 modulo register 
T2MODH              def       $2e,1                     ; timer 2 modulo high 
T2MODL              def       $2f,1                     ; timer 2 modulo low 
T2SC0               def       $30,1                     ; timer 2 chan 0 status/ctrl 
T2CH0               def       $31,2                     ; timer 2 chan 0 register 
T2CH0H              def       $31,1                     ; timer 2 chan 0 high 
T2CH0L              def       $32,1                     ; timer 2 chan 0 low 
T2SC1               def       $33,1                     ; timer 2 chan 1 status/ctrl 
T2CH1               def       $34,2                     ; timer 2 chan 1 register 
T2CH1H              def       $34,1                     ; timer 2 chan 1 high 
T2CH1L              def       $35,1                     ; timer 2 chan 1 low 
T2SC2               def       $456,1                    ; timer 2 chan 2 status/ctrl 
T2CH2               def       $457,1                    ; timer 2 chan 2 register 
T2CH2H              def       $457,1                    ; timer 2 chan 2 high 
T2CH2L              def       $458,1                    ; timer 2 chan 2 low 
T2SC3               def       $459,1                    ; timer 2 chan 3 status/ctrl 
T2CH3               def       $45A,1                    ; timer 2 chan 3 register 
T2CH3H              def       $45A,1                    ; timer 2 chan 3 high 
T2CH3L              def       $45B,1                    ; timer 2 chan 3 low 
T2SC4               def       $45C,1                    ; timer 2 chan 4 status/ctrl 
T2CH4               def       $45D,1                    ; timer 2 chan 4 register 
T2CH4H              def       $45D,1                    ; timer 2 chan 4 high 
T2CH4L              def       $45E,1                    ; timer 2 chan 4 low 
T2SC5               def       $45F,1                    ; timer 2 chan 5 status/ctrl 
T2CH5               def       $460,1                    ; timer 2 chan 5 register 
T2CH5H              def       $460,1                    ; timer 2 chan 5 high 
T2CH5L              def       $461,1                    ; timer 2 chan 5 low 
; ************ PLL section ************ 
PCTL                def       $36,1                     ; PLL control register 

PLLIE   EQU $80 ;  PLL interrupt enable bit
PLLF    EQU $40 ;  (w) PLL interrupt flag
PLLON   EQU $20 ;  PLL on bit
BCS     EQU $10 ;  Base clock select bit
PLL_E2  EQU $02 ;  E value hi
PLL_E1  EQU $01 ;  E value lo

PBWC                def       $37,1                     ; PLL bandwidth control register 

AUTOBAUD        EQU $80 ;  Automatic bandwidth control bit
LOCK    EQU $40 ;  Lock indicator bit
ACQN    EQU $20 ;  Acquisition mode bit

PMS                 def       $38,2                     ; PLL multiplier select 
PMSH                def       $38,1                     ; PLL multiplier select high 
PMSL                def       $39,1                     ; PLL multiplier select low 
PMRS                def       $3a,1                     ; PLL VCO select range 
; ************ ADC section ************ 
ADSCR               def       $3c,1                     ; A/D status/ctrl register 

COCO    EQU $80 ;  conversion completed  (AIEN==0)
IDMAS   EQU $80 ;  interrupt DMA selected
AIEN    EQU $40 ;  ADC interrupt enable
ADCO    EQU $20 ;  ADC continuous conversion
;       ADCH(c) (c)     ;  ADC channel number

ADR                 def       $3d,2                     ; A/D data register 
ADRH                def       $3d,1                     ; A/D data register high 
ADRL                def       $3e,1                     ; A/D data register low 
ADCLK               def       $3f,1                     ; A/D input clock register 

ADICLK  EQU $10 ;  ADC input clock select (0=CGMXCLK 1=PLL)
ADIV_1  EQU $00 ;  ADC clock divide ratio (1Mhz needed !)
ADIV_2  EQU $20
ADIV_4  EQU $40
ADIV_8  EQU $60
ADIV_16 EQU $80

ADC_8BIT        EQU $00
ADC_RIGHT       EQU $04
ADC_LEFT        EQU $08
ADC_LEFTS       EQU $0C

; ************ CAN section ************ 

CMCR0   EQU     $500      ;  CAN Module Control Register 0

SYNCH   EQU $10 ;  Synchronised status (r)
TLNKEN  EQU $08 ;  Timer enable (r/w)
SLPAK   EQU $04 ;  Sleep mode acknowledge (r)
SLPRQ   EQU $02 ;  Sleep request, go to internal sleep mode (r/w)
SFTRES  EQU $01 ;  Soft reset (r/w)
                                
CMCR1   EQU     $501     ;  CAN Module Control Register 1

LOOPB   EQU $04 ;  Loop back self test mode
WUPM    EQU $02 ;  Wake-up mode
CLKSRC  EQU $01 ;  Clock source
                                
CBTR0   EQU     $502    ;  CAN Bus Timing Register 0

SJW_1   EQU $00 ;  Synchronization jump width 1 Tq clock cycle
SJW_2   EQU $40 ;  Synchronization jump width 2 Tq clock cycles
SJW_3   EQU $80 ;  Synchronization jump width 3 Tq clock cycles
SJW_4   EQU $c0 ;  Synchronization jump width 4 Tq clock cycles

;  BRP(s) (s-1) ;  Baud rate prescaler [s=1..64]
BR_500  EQU     0
BR_250  EQU     1
BR_125  EQU     2
                                

CBTR1   EQU     $503     ;  CAN Bus Timing Register 1

SAMP    EQU $80         ;  Sampling (0=no, 1=3 samples)
;  TSEG2(s) ((s-1)<<4) ;  Time segment 2:  1..8  [Tq clock cycles]
;  TSEG1(s) (s-1)      ;  Time segment 1:  1..16 [Tq clock cycles]
  
CRFLG   EQU     $504     ;  CAN Receiver Flag Register

WUPIF   EQU $80 ;  Wake-up interrupt flag
RWRNIF  EQU $40 ;  Receiver warning interrupt flag
TWRNIF  EQU $20 ;  Transmitter warning interrupt flag
RERRIF  EQU $10 ;  Receiver error passive interrupt flag
TERRIF  EQU $08 ;  Transmitter error passive interrupt flag
BOFFIF  EQU $04 ;  Bus-off interrupt flag
OVRIF   EQU $02 ;  Overrun interrupt flag
RXF     EQU $01 ;  Receive buffer full interrupt flag

CRIER   EQU     $505    ;  CAN Receiver Interrupt Enable Register

WUPIE   EQU $80 ;  Wake-up interrupt enable
RWRNIE  EQU $40 ;  Receiver warning interrupt enable
TWRNIE  EQU $20 ;  Transmitter warning interrupt enable
RERRIE  EQU $10 ;  Receiver error passive interrupt enable
TERRIE  EQU $08 ;  Transmitter error passive interrupt enable
BOFFIE  EQU $04 ;  Bus-off interrupt enable
OVRIE   EQU $02 ;  Overrun interrupt enable
RXFIE   EQU $01 ;  Receive buffer full interrupt enable

CTFLG   EQU     $506    ;  CAN Transmitter Flag Register

ABTAK2  EQU $40 ;  Abort Acknowledge 2 (r)
ABTAK1  EQU $20 ;  Abort Acknowledge 1 (r)
ABTAK0  EQU $10 ;  Abort Acknowledge 0 (r)
TXE2    EQU $04 ;  Transmitter Bufer Empty 2
TXE1    EQU $02 ;  Transmitter Bufer Empty 1
TXE0    EQU $01 ;  Transmitter Bufer Empty 0

CTCR    EQU     $507     ;  CAN Transmitter Control Register

ABTRQ2  EQU $40 ;  Abort Request 2
ABTRQ1  EQU $20 ;  Abort Request 1
ABTRQ0  EQU $10 ;  Abort Request 0
TXEIE2  EQU $04 ;  Transmitter Empty Interrupt Enable 2
TXEIE1  EQU $02 ;  Transmitter Empty Interrupt Enable 1
TXEIE0  EQU $01 ;  Transmitter Empty Interrupt Enable 0

CIDAC   EQU     $508    ;  CAN Identifier Acceptance Control Register

IDAM_32         EQU     $00 ;  Single 32 bit acceptance filter (r/w)
IDAM_16         EQU     $10 ;  Two 16 bit acceptance filter    (r/w)
IDAM_8          EQU     $20 ;  Four 8 bit acceptance filter    (r/w)
IDAM_no         EQU     $20 ;  No acceptance filter            (r/w)

IDHIT_0         EQU     $00 ;  Identifier Acceptance Filter 0 Hit Indicator (r)
IDHIT_1         EQU     $01 ;  Identifier Acceptance Filter 1 Hit Indicator (r)
IDHIT_2         EQU     $02 ;  Identifier Acceptance Filter 2 Hit Indicator (r)
IDHIT_3         EQU     $03 ;  Identifier Acceptance Filter 3 Hit Indicator (r)
IDHIT_MASK      EQU     $03 ;  Identifier Acceptance Hit Indicator Mask

CRXERR          EQU     $50E            ; CAN Receive Error Counter Register (r)

CTXERR  EQU     $50f    ; CAN Transmitter Error Counter Register (r)
      
CIDAR0  EQU     $510    ; CAN Identifier Acceptance Register 0
CIDAR1  EQU     $511    ; CAN Identifier Acceptance Register 1
CIDAR2  EQU     $512    ; CAN Identifier Acceptance Register 2
CIDAR3  EQU     $513    ; CAN Identifier Acceptance Register 3
      
CIDMR0  EQU     $514    ; CAN Identifier Mask Register 0
CIDMR1  EQU     $515    ; CAN Identifier Mask Register 1
CIDMR2  EQU     $516    ; CAN Identifier Mask Register 2
CIDMR3  EQU     $517    ; CAN Identifier Mask Register 3

CRXBUF  EQU     $540    ; CAN Receive Buffer
CTXBUF0 EQU     $550    ; CAN Transmit Buffer 0
CTXBUF1 EQU     $560    ; CAN Transmit Buffer 1
CTXBUF2 EQU     $570    ; CAN Transmit Buffer 2

CBF_ID  EQU $00 ;  CAN Message Identifier 0 index
;   CBF_ID0 EQU $00 ;  CAN Message Identifier 0 index
;   CBF_ID1 EQU $01 ;  CAN Message Identifier 1 index
;   CBF_ID2 EQU $02 ;  CAN Message Identifier 2 index
;   CBF_ID3 EQU $03 ;  CAN Message Identifier 3 index
CBF_DAT EQU $04 ;  CAN Message Data index
;   CBF_DAT0 EQU $04 ;  CAN Message Data index
;   CBF_DAT1 EQU $05 ;  CAN Message Data index
;   CBF_DAT2 EQU $06 ;  CAN Message Data index
;   CBF_DAT3 EQU $07 ;  CAN Message Data index
;   CBF_DAT4 EQU $08 ;  CAN Message Data index
;   CBF_DAT5 EQU $09 ;  CAN Message Data index
 ;  CBF_DAT6 EQU $0a ;  CAN Message Data index
;   CBF_DAT7 EQU $0b ;  CAN Message Data index
CBF_LEN         EQU     $0c             ; CAN Message length index
CBF_PRI         EQU     $0d             ; CAN Message transmit buffer priority index

; ************ SIM section ************ 
SBSR            def     $fe00,1         ; SIM break status register 
SRSR            def     $fe01,1         ; SIM reset status register 
SBFCR           def     $fe03,1         ; SIM break control register 
INT1            def     $fe04,1         ; interrupt status register 1 
INT2            def     $fe05,1         ; interrupt status register 2 
INT3            def     $fe06,1         ; interrupt status register 3 
INT4            def     $fe07,1         ; interrupt status register 4 
FL2CR           def     $fe08,1         ; FLASH-2 control register 
BRKA            def     $fe09,2         ; BREAK address register 
BRKAH           def     $fe09,1         ; BREAK address register low 
BRKAL           def     $fe0a,1         ; BREAK address register high 
BRKSCR          def     $fe0b,1         ; BREAK status/ctrl register 
LVISR           def     $fe0c,1         ; LVI status register 
FLTCR2          def     $fe0d,1         ; FLASH-2 test control register 
FLTCR1          def     $fe0e,1         ; FLASH-1 test control register 
FL1BPR          def     $ff80,1         ; FLASH-1 block protect register 
FL2BPR          def     $ff81,1         ; FLASH-2 block protect register 
FL1CR           def     $ff88,1         ; FLASH-1 control register 
COPCTL          def     $ffff,1         ; COP control register 

; **** END OF ORIGINAL DEFINITIONS *********************************************

_HC908GZ60_         def       *                 ;Tells us this INCLUDE has been used

FLASH_PAGE_SIZE     def       128               ;minimum that must be erased at once

          #if FLASH_PAGE_SIZE <> 128
                    #Error    FLASH_PAGE_SIZE should be fixed at 128
          #endif

FLASH_DATA_SIZE     def       0                 ;default: no runtime flash storage

VECTORS             def       $FFCC             ;start of fixed vectors
          #ifdef RVECTORS
VECTORS             set       RVECTORS
          #endif

;--- Vectors
                    #temp     VECTORS
Vtpm2ch5            next      :temp,2           ;TPM2 channel 5 vector
Vtpm2ch4            next      :temp,2           ;TPM2 channel 4 vector
Vtpm2ch3            next      :temp,2           ;TPM2 channel 3 vector
Vtpm2ch2            next      :temp,2           ;TPM2 channel 2 vector
Vcantx              next      :temp,2           ;CAN transmit vector
Vcanrx              next      :temp,2           ;CAN receive vector
Vcanerr             next      :temp,2           ;CAN error vector
Vcanwu              next      :temp,2           ;CAN wake up vector
Vtim                next      :temp,2           ;time base vector
Vadc                next      :temp,2           ;analog to digital conversion vector
Vkeyboard           next      :temp,2           ;keyboard vector
Vescitx             next      :temp,2           ;SCI transmit vector
Vescirx             next      :temp,2           ;SCI receive vector
Vescierr            next      :temp,2           ;SCI error vector
Vspitx              next      :temp,2           ;SPI transmit vector
Vspirx              next      :temp,2           ;SPI receive vector
Vtpm2ovf            next      :temp,2           ;TPM2 overflow vector
Vtpm2ch1            next      :temp,2           ;TPM2 channel 1 vector
Vtpm2ch0            next      :temp,2           ;TPM2 channel 0 vector
Vtpm1ovf            next      :temp,2           ;TPM1 overflow vector
Vtpm1ch1            next      :temp,2           ;TPM1 channel 1 vector
Vtpm1ch0            next      :temp,2           ;TPM1 channel 0 vector
Vpll                next      :temp,2           ;PLL vector
Virq                next      :temp,2           ;IRQ vector
Vswi                next      :temp,2           ;SWI vector
Vreset              next      :temp,2           ;reset vector

; Flash2 $0462-$04FF is not supported

ROM                 def       $0980
ROM_END             def       $1B7F

XROM                def       $2000             ;1E20
XROM_END            def       $EFFF

RAM                 def       $0050
RAM_END             def       $00FF

XRAM                def       $0100
XRAM_END            def       $043F

; Far2 RAM is not supported by ASM8, but available on GZ32, GZ48, GZ60
SEG1                def       $0580
SEG1_END            def       $097F

FLASH_START         def       ROM
FLASH_END           def       ROM_END

#ifndef MHZ
  #ifndef KHZ
HZ                  def       5200000
  #endif
#endif
;-------------------------------------------------------------------------------
;                    #Uses     common.inc
;-------------------------------------------------------------------------------

                    #DATA

                    #VECTORS
                    org       VECTORS

                    #RAM        ; NearRAM
                    org       RAM

                    #XRAM       ; FarRAM
                    org       XRAM

                    #SEG1       ; Far2RAM
                    org       SEG1

                    #ROM        ; Flash $0980-$1B7F
                    org       ROM

                    #XROM       ; Flash $1E20-$EFFF
                    org       XROM

                    #MEMORY   ROM       ROM_END
                    #MEMORY   XROM      XROM_END
                    #MEMORY   RAM       RAM_END
                    #MEMORY   XRAM      XRAM_END
                    #MEMORY   SEG1      SEG1_END
                    #MEMORY   VECTORS   VECTORS|$00FF

                    #LISTOn

