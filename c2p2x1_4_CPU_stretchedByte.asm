_screenw=160 ; must be multiple of 16
_screenh=100
_screend=4   ; fixed
_chunkyBufferSize=_screenw*_screenh


_screen_width=320
_screen_height=256
_screen_bitplane_size=_screen_width/8*_screen_height

; a0 screenPointer
c2p:
 		
        ;
        ; First pass (omitted if adjacent pixels have already been combined)
        ;
		lea buffer,a0
		move.l #(_chunkyBufferSize/4)-1,d7
		move.l Screen_RENDER,a4						;screen bitmap 0  (D)
		lea  (3*_screen_bitplane_size)(a4),a1		;screen bitmap 3 (A)
		lea  (1*_screen_bitplane_size)(a4),a2		;screen bitmap 1 (C)
		lea  (2*_screen_bitplane_size)(a4),a3		;screen bitmap 2 (B)
		
.pass:									;res0 und res1
		move.l (a0)+,d0
		move.l d0,d3
		lsl.l #2,d3
		
		and.l  #$CCCCCCCC,d0
		and.l  #$CCCCCCCC,d3
		move.l d0,d1
		move.l d3,d2
			
		lsl.l   #6,d1
		lsl.l   #6,d2
		or.l   d1,d0
		or.l   d2,d3
		
		;bitmap 3 and 1
		swap	d0
		rol.w #4,d0
		rol.l #4,d0
		move.b d0,(a1)+
		
		swap d0
		rol.w #4,d0
		move.b d0,(a2)+
		
		;bitmap 2 and 0
		swap	d3
		rol.w #4,d3
		rol.l #4,d3
		move.b d3,(a3)+
		
		swap d3
		rol.w #4,d3
		move.b d3,(a4)+
		
		dbf  d7,.pass
		rts

		
	
		
		
res0 ds.b chunkyBufferSize

res1 ds.b chunkyBufferSize