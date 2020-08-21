; 188 - 在屏幕2,4,6,8行显示4句英文诗【中断例程】
; =================================================================

; 补全程序，分别在屏幕第2/4/6/8行显示4句英文诗

; =================================================================

assume cs:code
; =================================================================
code segment
	s1:	db 'Good,better,best,', '$'
	s2:	db 'Never let it rest,', '$'
	s3:	db 'Till good is better,', '$'
	s4:	db 'And better,best.', '$'
	s:	dw OFFSET s1, OFFSET s2, OFFSET s3, OFFSET s4
	row:	db 2,4,6,8


start:		mov ax ,cs
		mov ds, ax
		mov bx, OFFSET s
		mov si, OFFSET row
		mov cx, 4

	ok:	mov bh, 0
		mov dh, ds:[si]		; mov dh, _________
		mov dl, 0
		mov ah, 2
		int 10h

		mov dx, ds:[bx]		; mov dx, ________
		mov ah, 9
		int 21h
		
		inc si		; _________
		add bx, 2	; _________
		loop ok

		mov ax, 4c00h
		int 21h


code ends

end start
