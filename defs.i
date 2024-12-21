;APS00000078000000780000007800000078000000780000007800000078000000780000007800000078
;	IFND DEFS_I
;DEFS_I	SET 1

execbase                EQU   $4
custom	                EQU   $dff000
ciaa	                EQU   $bfe001
ciab	                EQU   $bfd000

; exec.library
_LVOSupervisor          EQU -30
_LVODisable	        EQU -120
_LVOEnable	        EQU -126
_LVOForbid	        EQU -132
_LVOPermit	        EQU -138
_LVOFindTask	        EQU -294
_LVOSetTaskPri		EQU -300
_LVOAllocSignal	        EQU -330
_LVOFreeSignal	        EQU -336
_LVOGetMsg	        EQU -372
_LVOReplyMsg	        EQU -378
_LVOWaitPort	        EQU -384
_LVOOldOpenLibrary	EQU -408
_LVOCloseLibrary	EQU -414
_LVOOpenDevice	        EQU -444
_LVOCloseDevice	        EQU -450
_LVODoIO	        EQU -456
_LVORawDoFmt            EQU -522
_LVOOpenLibrary	        EQU -552

eb_AttnFlags            EQU $128

AFB_68010	        EQU 0	; also set for 68020
AFB_68020	        EQU 1	; also set for 68030
AFB_68030	        EQU 2	; also set for 68040
AFB_68040	        EQU 3	; also set for 68060
AFB_68881	        EQU 4	; also set for 68882
AFB_68882	        EQU 5
AFB_FPU40	        EQU 6	; Set if 68040 FPU
AFB_68060	        EQU 7


pr_MsgPort              EQU $5C
pr_CLI                  EQU $AC

cli_StandardOutput      EQU $38

; graphics.library
_LVOOpenFont            EQU  -72
_LVOCloseFont           EQU  -78
_LVOLoadView		EQU -222
_LVOWaitBlit		EQU -228
_LVOWaitTOF		EQU -270

tf_CharData             EQU 34  ; struct TextFont
gb_ActiView		EQU 34 	; struct *View
gb_copinit		EQU 38	; struct *copinit; ptr to copper start up list

; dos.library
_LVOOpen		EQU -30
_LVOClose		EQU -36
_LVOCRead   	        EQU -40
_LVOWrite		EQU -48
_LVOInput               EQU -54
_LVOOutput              EQU -60
_LVOSeek                EQU -66

MODE_OLDFILE		EQU 1005
MODE_NEWFILE		EQU 1006
MODE_READWRITE		EQU 1004

; hardware/custom.i
bltddat     EQU   $000
dmaconr     EQU   $002
vposr	    EQU   $004
vhposr	    EQU   $006
dskdatr     EQU   $008
joy0dat     EQU   $00A
joy1dat     EQU   $00C
clxdat	    EQU   $00E

adkconr     EQU   $010
pot0dat     EQU   $012
pot1dat     EQU   $014
potinp	    EQU   $016
serdatr     EQU   $018
dskbytr     EQU   $01A
intenar     EQU   $01C
intreqr     EQU   $01E

dskpt	    EQU   $020
dsklen	    EQU   $024
dskdat	    EQU   $026
refptr	    EQU   $028
vposw	    EQU   $02A
vhposw	    EQU   $02C
copcon	    EQU   $02E
serdat	    EQU   $030
serper	    EQU   $032
potgo	    EQU   $034
joytest     EQU   $036
strequ	    EQU   $038
strvbl	    EQU   $03A
strhor	    EQU   $03C
strlong     EQU   $03E

bltcon0     EQU   $040
bltcon1     EQU   $042
bltafwm     EQU   $044
bltalwm     EQU   $046
bltcpt	    EQU   $048
bltbpt	    EQU   $04C
bltapt	    EQU   $050
bltdpt	    EQU   $054
bltsize     EQU   $058
bltcon0l    EQU   $05B		; note: byte access only
bltsizv     EQU   $05C
bltsizh     EQU   $05E

bltcmod     EQU   $060
bltbmod     EQU   $062
bltamod     EQU   $064
bltdmod     EQU   $066

bltcdat     EQU   $070
bltbdat     EQU   $072
bltadat     EQU   $074

deniseid    EQU   $07C
dsksync     EQU   $07E

cop1lc	    EQU   $080
cop2lc	    EQU   $084
copjmp1     EQU   $088
copjmp2     EQU   $08A
copins	    EQU   $08C
diwstrt     EQU   $08E
diwstop     EQU   $090
ddfstrt     EQU   $092
ddfstop     EQU   $094
dmacon	    EQU   $096
clxcon	    EQU   $098
intena	    EQU   $09A
intreq	    EQU   $09C
adkcon	    EQU   $09E

aud	    EQU   $0A0
aud0	    EQU   $0A0
aud1	    EQU   $0B0
aud2	    EQU   $0C0
aud3	    EQU   $0D0

* AudChannel
ac_ptr	    EQU   $00	; ptr to start of waveform data
ac_len	    EQU   $04	; length of waveform in words
ac_per	    EQU   $06	; sample period
ac_vol	    EQU   $08	; volume
ac_dat	    EQU   $0A	; sample pair
ac_SIZEOF   EQU   $10

bplpt	    EQU   $0E0

bplcon0     EQU   $100
bplcon1     EQU   $102
bplcon2     EQU   $104
bplcon3     EQU   $106
bpl1mod     EQU   $108
bpl2mod     EQU   $10A
bplcon4     EQU   $10C
clxcon2     EQU   $10E

bpldat	    EQU   $110

sprpt	    EQU   $120

spr	    EQU   $140

* SpriteDef
sd_pos	    EQU   $00
sd_ctl	    EQU   $02
sd_dataa    EQU   $04
sd_datab    EQU   $06
sd_SIZEOF   EQU   $08

color	    EQU   $180

htotal	    EQU   $1c0
hsstop	    EQU   $1c2
hbstrt	    EQU   $1c4
hbstop	    EQU   $1c6
vtotal	    EQU   $1c8
vsstop	    EQU   $1ca
vbstrt	    EQU   $1cc
vbstop	    EQU   $1ce
sprhstrt    EQU   $1d0
sprhstop    EQU   $1d2
bplhstrt    EQU   $1d4
bplhstop    EQU   $1d6
hhposw	    EQU   $1d8
hhposr	    EQU   $1da
beamcon0    EQU   $1dc
hsstrt	    EQU   $1de
vsstrt	    EQU   $1e0
hcenter     EQU   $1e2
diwhigh     EQU   $1e4
fmode	    EQU   $1fc

; hardware/dma.i

DMAF_SETCLR    EQU   $8000
DMAF_AUDIO     EQU   $000F  * 4 bit mask
DMAF_AUD0      EQU   $0001
DMAF_AUD1      EQU   $0002
DMAF_AUD2      EQU   $0004
DMAF_AUD3      EQU   $0008
DMAF_DISK      EQU   $0010
DMAF_SPRITE    EQU   $0020
DMAF_BLITTER   EQU   $0040
DMAF_COPPER    EQU   $0080
DMAF_RASTER    EQU   $0100
DMAF_MASTER    EQU   $0200
DMAF_BLITHOG   EQU   $0400
DMAF_ALL       EQU   $01FF  * all dma channels

* read definitions for dmaconr
* bits 0-8 correspnd to dmaconw definitions
DMAF_BLTDONE   EQU   $4000
DMAF_BLTNZERO  EQU   $2000

DMAB_SETCLR    EQU   15
DMAB_AUD0      EQU   0
DMAB_AUD1      EQU   1
DMAB_AUD2      EQU   2
DMAB_AUD3      EQU   3
DMAB_DISK      EQU   4
DMAB_SPRITE    EQU   5
DMAB_BLITTER   EQU   6
DMAB_COPPER    EQU   7
DMAB_RASTER    EQU   8
DMAB_MASTER    EQU   9
DMAB_BLITHOG   EQU   10
DMAB_BLTDONE   EQU   14
DMAB_BLTNZERO  EQU   13

; hardware/blit.i
ABC	    equ   $80
ABNC	    equ   $40
ANBC	    equ   $20
ANBNC	    equ   $10
NABC	    equ   $8
NABNC	    equ   $4
NANBC	    equ   $2
NANBNC	    equ   $1

BC0B_DEST   equ     8
BC0B_SRCC   equ     9
BC0B_SRCB   equ     10
BC0B_SRCA   equ     11
BC0F_DEST   equ   $100
BC0F_SRCC   equ   $200
BC0F_SRCB   equ   $400
BC0F_SRCA   equ   $800

BC1F_DESC   equ 2

DEST	    equ   $100
SRCC	    equ   $200
SRCB	    equ   $400
SRCA	    equ   $800

ASHIFTSHIFT equ   12 ; bits to right align ashift value
BSHIFTSHIFT equ   12 ; bits to right align bshift value

* definations for blitter control register 1 */
LINEMODE    equ   $1
FILL_OR     equ   $8
FILL_XOR    equ   $10
FILL_CARRYIN   equ   $4
ONEDOT	    equ   $2
OVFLAG	    equ   $20
SIGNFLAG    equ   $40
BLITREVERSE equ   $2

SUD	    equ   $10
SUL	    equ   $8
AUL	    equ   $4

OCTANT8     equ   24
OCTANT7     equ   4
OCTANT6     equ   12
OCTANT5     equ   28
OCTANT4     equ   20
OCTANT3     equ   8
OCTANT2     equ   0
OCTANT1     equ   16

; hardware/intbits.i

INTB_SETCLR    EQU   (15)  ;Set/Clear control bit. Determines if bits
			   ;written with a 1 get set or cleared. Bits
			   ;written with a zero are allways unchanged.
INTB_INTEN     EQU   (14)  ;Master interrupt (enable only )
INTB_EXTER     EQU   (13)  ;External interrupt
INTB_DSKSYNC   EQU   (12)  ;Disk re-SYNChronized
INTB_RBF       EQU   (11)  ;serial port Receive Buffer Full
INTB_AUD3      EQU   (10)  ;Audio channel 3 block finished
INTB_AUD2      EQU   (9)   ;Audio channel 2 block finished
INTB_AUD1      EQU   (8)   ;Audio channel 1 block finished
INTB_AUD0      EQU   (7)   ;Audio channel 0 block finished
INTB_BLIT      EQU   (6)   ;Blitter finished
INTB_VERTB     EQU   (5)   ;start of Vertical Blank
INTB_COPER     EQU   (4)   ;Coprocessor
INTB_PORTS     EQU   (3)   ;I/O Ports and timers
INTB_SOFTINT   EQU   (2)   ;software interrupt request
INTB_DSKBLK    EQU   (1)   ;Disk Block done
INTB_TBE       EQU   (0)   ;serial port Transmit Buffer Empty

INTF_SETCLR    EQU   (1<<INTB_SETCLR)
INTF_INTEN     EQU   (1<<INTB_INTEN)
INTF_BLIT      EQU   (1<<INTB_BLIT)
INTF_VERTB     EQU   (1<<INTB_VERTB)

COLOR00         equ     color+$00
COLOR01         equ     color+$02
COLOR02         equ     color+$04
COLOR03         equ     color+$06
COLOR04         equ     color+$08
COLOR05         equ     color+$0A
COLOR06         equ     color+$0C
COLOR07         equ     color+$0E
COLOR08         equ     color+$10
COLOR09         equ     color+$12
COLOR10         equ     color+$14
COLOR11         equ     color+$16
COLOR12         equ     color+$18
COLOR13         equ     color+$1A
COLOR14         equ     color+$1C
COLOR15         equ     color+$1E
COLOR16         equ     color+$20
COLOR17         equ     color+$22
COLOR18         equ     color+$24
COLOR19         equ     color+$26
COLOR20         equ     color+$28
COLOR21         equ     color+$2A
COLOR22         equ     color+$2C
COLOR23         equ     color+$2E
COLOR24         equ     color+$30
COLOR25         equ     color+$32
COLOR26         equ     color+$34
COLOR27         equ     color+$36
COLOR28         equ     color+$38
COLOR29         equ     color+$3A
COLOR30         equ     color+$3C
COLOR31         equ     color+$3E

BPLCON0         equ     bplcon0         ; Just capitalization...
BPLCON1         equ     bplcon1         ;  "         "
BPLCON2         equ     bplcon2         ;  "         "
BPL1MOD         equ     bpl1mod         ;  "         "
BPL2MOD         equ     bpl2mod         ;  "         "

;	ENDC ; DEFS_I
