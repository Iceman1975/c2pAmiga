	include "defs.i"

	
screenBuffer_modulo           = -2
screenBuffer_modulo_repeat    =  -(screen_width/8)-2
screenw=160 ; must be multiple of 16
screenh=100
screend=4   ; fixed
chunkyBufferSize=screenw*screenh
bplwords=chunkyBufferSize/2
screen_width=320
screen_height=256
screen_bitplane_size=screen_width/8*screen_height


	SECTION    ChipData,  DATA_C



main:
    bsr     init
	bsr		initCopper


.waitmouse:
	bsr screen_waitVBlank
	
	;move.w #$fff,$dff180
	bsr     c2p
	move.w #$000,$dff180
	
	btst	#6,ciaa
	bne.s	.waitmouse
    rts

	
	

screen_waitVBlank:
wait:              ; wait until at beam line 0
                              move.l    $dff004,d0                                                                 ; read VPOSR and VHPOSR into d0 as one long word
                              and.l     #$000fff00,d0
                              cmp.l     #$00011000,d0
                              bne.s     wait                                                                       ; if not equal jump to wait
                              rts
							  

	
	
initCopper:
        ; Initialize copperlist
        lea.l     copper,a1                                                                  ; put copper address into a1
        move.l    a1,$dff080                                                                 ; COP1LCH (also sets COP1LCL)
        move.w    $dff088,d0                                                                 ; COPJMP1 
        move.w    #$81a0,$dff096                                                             ; DMACON set bitplane, copper, sprite
							  
        move.l  Screen_RENDER,d0
                              
        lea       copper_screen,a0
        moveq     #3,d7                                                                      ; only 4 bitplanes here
.ss1:
       move      d0,6(a0) 
       swap      d0 
       move      d0,2(a0) 
       swap      d0 
       add.l     #screen_bitplane_size,d0 
       addq.l    #8,a0 

       dbf       d7,.ss1
		
       rts

		
init:
  move.w    #$4000,$dff09a                      ; INTENA - clear external interrupt

  or.b      #%10000000,$bfd100                  ; CIABPRB stops drive motors
  and.b     #%10000111,$bfd100                  ; CIABPRB

  move.w    #$01a0,$dff096                      ; DMACON clear bitplane, copper, sprite
 
  move.w    #$4000,$dff100                      ; BPLCON0 one bitplane, color burst
  move.w    #$0000,$dff102                      ; BPLCON1 scroll
  move.w    #$003f,$dff104                      ; BPLCON2 video

  move.w    #$2c71,$dff08e                      ; DIWSTRT upper left corner of display 
  move.w    #$30b1,$dff090                      ; DIWSTOP lower right corner of display 

  move.w    #$0030,$dff092                      ; DDFSTRT Data fetch start
  move.w    #$00d0,$dff094                      ; DDFSTOP Data fetch stop

 
  rts
  
  
		
	;include "c2p2x1_4_CPU_stretchedByte.asm"
	include "c2p2x1_4_Blitter_stretchedByte.asm"		
	include "copperlist.asm"




Screen_RENDER dc.l screen

screen ds.b screen_bitplane_size*4
		
buffer:
	include "demoImage.asm"
	ds.b 160*20				; empty lines

	
	