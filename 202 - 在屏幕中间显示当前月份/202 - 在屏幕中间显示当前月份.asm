; 202 - 在屏幕中间显示当前月份
; ====================================================

; 
; ====================================================
assume cs:codesg

codesg segment
start:		call clear_screen

		mov al, 8
		out 70h, al
		in al, 71h

		mov ah, al
		mov cl, 4
		shr ah, cl
		and al, 00001111B

		add al, 30H	; al 中为月份的个位数码值
		add ah, 30H	; ah 中为月份的十位数码值

		mov bx, 0B800H
		mov es, bx
		mov di, 169 * 12 + 40 * 2
		mov byte ptr es:[di + 0], ah
		mov byte ptr es:[di + 1], 00001010B
		mov byte ptr es:[di + 2], al
		mov byte ptr es:[di + 3], 00001010B

		mov ax, 4c00h
		int 21h


	clear_screen:	push ax
			push cx
			push es
			push di

			mov ax, 0B800H
			mov es, ax
			mov di, 0

			mov cx, 2000
			mov ax, 0700H	; 0700H 是空白
		
		_clear:	mov es:[di], ax
			add di, 2
			loop _clear
		
			pop di
			pop es
			pop cx
			pop ax
			
			ret

codesg ends
end start
