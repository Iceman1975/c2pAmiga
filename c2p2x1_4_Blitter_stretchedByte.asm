;
; Performs 2x1 C2P on specially prepared data.
;
; Pixel format is: %aabbccdd (where a is the most significant bit of the 4 bpl pixel)
;
BLITTER_NASTY = 1

doC2PbyCPU macro
		ifnd BLITTER_NASTY
		rept (160/8)*(\1) ;convert 1 row

		move.l (a4)+,d0
		and.l #$0F0F0F0F,d0
		move.l d0,d1
		swap d0
		lsl.w #4,d0
		or.w   d1,d0
		swap d0		
		
		move.l (a4)+,d2
		and.l #$0F0F0F0F,d2
		move.l d2,d1
		swap d2
		lsl.w #4,d2
		or.w   d1,d2
		move.w d2,d0
		
		move.l d0,(a3)+
		endr
		endif
	endm

waitblit macro
	tst	dmaconr(a6)
.\@:
	btst.b	#DMAB_BLTDONE-8,dmaconr(a6)
	bne.s	.\@
	endm
	

c2p:
		ifd BLITTER_NASTY
			move.w  #$8400,$DFF096  
		endif 
		lea $dff000,a6
        ; Common to all passes
        move.l  #-1,bltafwm(a6)

		
		
.pass:									;res0
		lea buffer,a0
		lea res0,a1
		
		lea buffer,a4				; init for CPU suppport
		lea resCPU,a3				; init for CPU suppport
	
        move.l  a0,bltapt(a6)	;A buffer 
		adda.l #2,a0
        move.l  a0,bltbpt(a6)	; B buffer
		
        move.l  a1,bltdpt(a6)	; res0 res0
		move.w  #$F0F0,bltcdat(a6)
		
        move.w  #2,bltamod(a6)
        move.w  #2,bltbmod(a6)
        move.w  #0,bltdmod(a6)
        move.w  #NABNC!ANBC!ABNC!ABC!DEST!SRCB!SRCA,bltcon0(a6)
		move.w  #4<<12,bltcon1(a6)
		waitblit
 		
		move.w  #(20*50*64)+(((16))/16),bltsize(a6)			; 2 CPU lines
		doC2PbyCPU 2
		waitblit
		move.w  #(20*50*64)+(((16))/16),bltsize(a6)			; 2 CPU lines
		doC2PbyCPU 2
		waitblit
		move.w  #(20*50*64)+(((16))/16),bltsize(a6)			; 2 CPU lines
		doC2PbyCPU 2
		waitblit
		move.w  #(20*50*64)+(((16))/16),bltsize(a6)			; 2 CPU lines
		doC2PbyCPU 2
		waitblit 	
		
		
		
		
.merge4_4:
		;**********
		;bitmap3
		;**********		
 
		
		lea    res0,a0
		lea    res1,a1
		adda.l #80*100-2,a0
		adda.l #80*100-2,a1
        move.l  a0,bltapt(a6)	;res0 
        move.l  a0,bltbpt(a6)	; res0		
        move.l  a1,bltdpt(a6)	; res1
		move.w  #$CCCC,bltcdat(a6)
		
        move.w  #0,bltamod(a6)
        move.w  #0,bltbmod(a6)
        move.w  #0,bltdmod(a6)
        move.w  #NABNC!ANBC!ABNC!ABC!DEST!SRCB!SRCA,bltcon0(a6)

		move.w  #6<<12!BLITREVERSE,bltcon1(a6)
		waitblit

		move.w  #(100*64)+(((80*8))/16),bltsize(a6)		; 9 CPU lines
		doC2PbyCPU 9
		waitblit
		
		
		lea    res1,a0
		move.l Screen_RENDER,a1
		adda.l #3*screen_bitplane_size,a1
        move.l  a0,bltapt(a6)	;A res1 
		adda.l #2,a0
        move.l  a0,bltbpt(a6)	; B res1
		
        move.l  a1,bltdpt(a6)	; bitmap3
		move.w  #$FF00,bltcdat(a6)
		
        move.w  #2,bltamod(a6)
        move.w  #2,bltbmod(a6)
        move.w  #0,bltdmod(a6)
        move.w  #NABNC!ANBC!ABNC!ABC!DEST!SRCB!SRCA,bltcon0(a6)
		
		move.w  #8<<12,bltcon1(a6)
		waitblit
 		
		move.w  #(20*50*64)+(((16))/16),bltsize(a6)		; 1 CPU lines
		doC2PbyCPU 1
		waitblit		
		move.w  #(20*50*64)+(((16))/16),bltsize(a6)		; 1 CPU lines
		doC2PbyCPU 1
		waitblit
		
		
		
		;**********
		;bitmap2
		;**********		
		
		lea    res0,a0
		lea    res1,a1
		adda.l #80*100-2,a0
		adda.l #80*100-2,a1
        move.l  a0,bltapt(a6)	;res0 
        move.l  a0,bltbpt(a6)	; res0		
        move.l  a1,bltdpt(a6)	; res1
		move.w  #$CCCC,bltcdat(a6)
		
        move.w  #0,bltamod(a6)
        move.w  #0,bltbmod(a6)
        move.w  #0,bltdmod(a6)
        move.w  #2<<12!NABNC!ANBC!ABNC!ABC!DEST!SRCB!SRCA,bltcon0(a6)

		move.w  #8<<12!BLITREVERSE,bltcon1(a6)
		waitblit

		move.w  #(100*64)+(((80*8))/16),bltsize(a6)		; 9 CPU lines
		doC2PbyCPU 9
		waitblit
		

		lea    res1,a0
		move.l Screen_RENDER,a1
		adda.l #2*screen_bitplane_size,a1
        move.l  a0,bltapt(a6)	;A res1 
		adda.l #2,a0
        move.l  a0,bltbpt(a6)	; B res1
		
        move.l  a1,bltdpt(a6)	; bitmap3
		move.w  #$FF00,bltcdat(a6)
		
        move.w  #2,bltamod(a6)
        move.w  #2,bltbmod(a6)
        move.w  #0,bltdmod(a6)
        move.w  #NABNC!ANBC!ABNC!ABC!DEST!SRCB!SRCA,bltcon0(a6)
		
		move.w  #8<<12,bltcon1(a6)
		waitblit
 		
		move.w  #(20*50*64)+(((16))/16),bltsize(a6)		; 1 CPU lines
		doC2PbyCPU 1
		waitblit		
		move.w  #(20*50*64)+(((16))/16),bltsize(a6)		; 1 CPU lines
		doC2PbyCPU 1
		waitblit
		
		

			
.merge4_4_part2:

.pass2:									;res0
				
		lea buffer,a0
		lea resCPU,a1
		adda.l #160*100-4,a0
		adda.l #80*100-2,a1
	
		
        move.l  a0,bltapt(a6)	;A buffer 
		adda.l #2,a0
        move.l  a0,bltbpt(a6)	; B buffer
		
        move.l  a1,bltdpt(a6)	; res0 res0
		move.w  #$F0F0,bltcdat(a6)
		
        move.w  #2,bltamod(a6)
        move.w  #2,bltbmod(a6)
        move.w  #0,bltdmod(a6)
        move.w  #4<<12!NABNC!ANBC!ABNC!ABC!DEST!SRCB!SRCA,bltcon0(a6)
		
		move.w  #BLITREVERSE,bltcon1(a6)
		waitblit
 		
		move.w  #(20*50*64)+(((16))/16),bltsize(a6)		
		waitblit
		move.w  #(20*50*64)+(((16))/16),bltsize(a6)		
		waitblit
		

		
		ifd BLITTER_NASTY
			move.w  #(20*50*64)+(((16))/16),bltsize(a6)		
			waitblit
			move.w  #(20*50*64)+(((16))/16),bltsize(a6)		
			waitblit
		else
			move.w  #(20*40*64)+(((16))/16),bltsize(a6)		;-30 line/done by CPU
			waitblit	
		endif
		
		;**********
		;bitmap1
		;**********		
		
		lea    resCPU,a0
		lea    res1,a1
		adda.l #80*100-2,a0
		adda.l #80*100-2,a1
        move.l  a0,bltapt(a6)	;res0 
        move.l  a0,bltbpt(a6)	; res0		
        move.l  a1,bltdpt(a6)	; res1
		move.w  #$CCCC,bltcdat(a6)
		
        move.w  #0,bltamod(a6)
        move.w  #0,bltbmod(a6)
        move.w  #0,bltdmod(a6)
        move.w  #NABNC!ANBC!ABNC!ABC!DEST!SRCB!SRCA,bltcon0(a6)

		move.w  #6<<12!BLITREVERSE,bltcon1(a6)
		waitblit

		move.w  #(100*64)+(((80*8))/16),bltsize(a6)		
		waitblit
		
		

		lea    res1,a0
		move.l Screen_RENDER,a1
		adda.l #1*screen_bitplane_size,a1
        move.l  a0,bltapt(a6)	;A res1 
		adda.l #2,a0
        move.l  a0,bltbpt(a6)	; B res1
		
        move.l  a1,bltdpt(a6)	; bitmap1
		move.w  #$FF00,bltcdat(a6)
		
        move.w  #2,bltamod(a6)
        move.w  #2,bltbmod(a6)
        move.w  #0,bltdmod(a6)
        move.w  #NABNC!ANBC!ABNC!ABC!DEST!SRCB!SRCA,bltcon0(a6)
		
		move.w  #8<<12,bltcon1(a6)
		waitblit
 		
		move.w  #(20*50*64)+(((16))/16),bltsize(a6)		
		waitblit		
		move.w  #(20*50*64)+(((16))/16),bltsize(a6)		
		waitblit
		
		
		;**********
		;bitmap0
		;**********		
		
		lea    resCPU,a0
		lea    res1,a1
		adda.l #80*100-2,a0
		adda.l #80*100-2,a1
        move.l  a0,bltapt(a6)	;res0 
        move.l  a0,bltbpt(a6)	; res0		
        move.l  a1,bltdpt(a6)	; res1
		move.w  #$CCCC,bltcdat(a6)
		
        move.w  #0,bltamod(a6)
        move.w  #0,bltbmod(a6)
        move.w  #0,bltdmod(a6)
        move.w  #2<<12!NABNC!ANBC!ABNC!ABC!DEST!SRCB!SRCA,bltcon0(a6)

		move.w  #8<<12!BLITREVERSE,bltcon1(a6)
		waitblit

		move.w  #(100*64)+(((80*8))/16),bltsize(a6)		
		waitblit
		
		

		lea    res1,a0
		move.l Screen_RENDER,a1
        move.l  a0,bltapt(a6)	;A res1 
		adda.l #2,a0
        move.l  a0,bltbpt(a6)	; B res1
		
        move.l  a1,bltdpt(a6)	; bitmap3
		move.w  #$FF00,bltcdat(a6)
		
        move.w  #2,bltamod(a6)
        move.w  #2,bltbmod(a6)
        move.w  #0,bltdmod(a6)
        move.w  #NABNC!ANBC!ABNC!ABC!DEST!SRCB!SRCA,bltcon0(a6)
		
		move.w  #8<<12,bltcon1(a6)
		waitblit
 		
		move.w  #(20*50*64)+(((16))/16),bltsize(a6)		
		waitblit		
		move.w  #(20*50*64)+(((16))/16),bltsize(a6)		
		waitblit

		rts
		
		
		
		
		
	
res0 ds.b chunkyBufferSize/2

res1 ds.b chunkyBufferSize/2

resCPU ds.b chunkyBufferSize/2

