; 245 - 以16进制形式在屏幕中间显示给定的字节型数据
; ======================================================

; P291

; ======================================================
assume cs:codesg

codesg segment

	start:	mov al, 0ABH
		call showbyte

		mov ax, 4c00h
		int 21h

	; ---------------------------------------------
	showbyte:	jmp short show

			table db '0123456789ABCDEF'	; 字符表

	show:		push ax
			push bx
			push es

			mov ah, al
			shr ah, 1
			shr ah, 1
			shr ah, 1
			shr ah, 1		; 右移4位，ah中得到高4位的值
			and al, 00001111B	; al 中为底 4 位的值

			mov bl, ah
			mov bh, 0
			mov ah, table[bx]	; 用高 4 位的值作为相对于 table 的偏移，取得相对应的字符

			mov bl, al
			mov bh, 0
			mov al, table[bx]	; 用低 4 位的值作为相对于 table 的偏移，取得相对应的字符
		
			mov bx, 0B800H
			mov es, bx
			
			mov byte ptr es:[160 * 12 + 40 * 2 + 0], ah
			mov byte ptr es:[160 * 12 + 40 * 2 + 1], 00000111B
			mov byte ptr es:[160 * 12 + 40 * 2 + 2], al
			mov byte ptr es:[160 * 12 + 40 * 2 + 3], 00000111B
			
			pop es
			pop bx
			pop ax

			ret

codesg ends
end start
