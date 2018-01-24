; unlz4gb.s (c) 2018 tmk, see https://github.com/gitendo/lz4gb

; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.

; hl - compressed data
; de - where to decompress

unlz4gb:
;-------------------------------------------------------------------------------	
	xor	a		; init
	ld	b,a
	ld	c,a
_loop
	ld	a,(hl+)		; load token, move to next byte
	push	af		; store it for matchlength comparision
	swap	a		; switch nibbles
	and	$0f		; isolate length of literals
	jr	z,_no_literal	; 0 = no literal
	ld	c,a		; initial data length
	cp	15		; 
	call	z,get_length	; calculate total data length
	call	copy		; copy data

_no_literal
	pop	af		; restore token
	and	$0f		; isolate matchlength
	add	a,4		; minmatch = 4
	ld	c,a		; initial data length
	cp	19
	call	z,get_length	; calculate total data lenght

	ld	a,(hl+)		; offset lo
	cp	(hl)		; offset hi
	jr	nz,_set_src
	cp	0		; end of compressed data
	ret	z		; done

_set_src
	push	hl		; store compressed data offset
	ld	h,(hl)		; offset hi
	ld	l,a             ; offset lo

	ld	a,e		; hl = de - offset
	sub	l
	ld	l,a
	ld	a,d
	sbc	a,h
	ld	h,a	

	call	copy		; copy data

	pop	hl		; restore compressed data offset
	inc	hl		; skip offset hi byte
	jr	_loop


get_length:
;-------------------------------------------------------------------------------	
	add	a,(hl)		; add length byte
	jr	nc,_1
	inc	b		; increase counter's hi byte
_1
	ld	c,a		; move to counter's lo byte
	ld	a,(hl+)		; re-read and advance to next byte
	inc	a
	ret	nz		; return if not 255
	ld	a,c		; restore counter's lo byte
	jr	get_length


copy:
;-------------------------------------------------------------------------------
	inc	b
	inc	c
	jr	_skip
_copy
	ld	a,(hl+)
	ld	(de),a
	inc	de
_skip
	dec	c
	jr	nz,_copy
	dec	b
	jr	nz,_copy
	ret
