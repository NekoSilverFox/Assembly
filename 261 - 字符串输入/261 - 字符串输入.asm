; 261 - 字符串输入
; ======================================================

; P304

; 最基本的字符串输入程序，需要具备以下功能
; 1. 在输入的同时需要显示这个字符串
; 2. 一般在输入回车符后，字符串输入结束
; 3. 能够删除已经输入的字符串

; ======================================================

; 编写一个接收字符串输入的子程序，实现上面3个基本功能。因为在输入的过程中需要显示，子程序的参数如下
; (dh)、(dl) = 字符串在屏幕上显示的行、列位置
; ds:si 指向字符串的储存空间，字符串以0为结尾符

; ======================================================

; 功能编号：0（ah读取）
; 
; mov ah, 0
; int 16h
; 读取的 扫描码送入 ah，ASCII码送入 al
; ======================================================
assume cs:codesg, ss:stacksg
; ======================================================
stacksg segment stack
	db 128 dup (0)
stacksg ends
; ======================================================
codesg segment
start:		mov ax, stacksg
		mov ss, ax
		mov sp, 128

		call get_str

		mov ax, 4c00h
		int 21h

	; ===================================
	; 子程序：接收字符串输入
	get_str:		push ax

	_getStrs:		mov ah, 0
				int 16h
				cmp al, 20h	; ASCII码小于20h说明不是字符
				jb nochar
				mov ah, 0
				call char_stack	; 字符入栈
				mov ah, 2
				call char_stack	; 显示栈中字符
				jmp _getStrs

	nochar:			cmp ah, 0eh	; 退格键的扫描码
				je _backspace
				cmp ah, 1ch	; Enter 的扫描码
				je _enter
				jmp _getStrs

	_backspace:		mov ah, 1
				call char_stack	; 字符出栈
				mov ah, 2
				call char_stack
				jmp _getStrs

	_enter:			mov al, 0
				mov ah, 0
				call char_stack	; 0 入栈
				mov ah, 2
				call char_stack	; 显示栈中字符串
				pop ax
				ret


	; ===================================
	; 子程序：字符栈的入栈、出栈和显示
	; 参数说明：(ah) = 功能号，0 表示入栈；1 出栈；2显示
	; ds:si 指向栈空间
	; 对于 0 号 功能：（al）= 入栈字符
	; 对于 1 号 功能：（al）= 返回字符
	; 对于 2 号 功能：（dh）、（dl）= 字符串在屏幕上的显示行、列位置
	char_stack:		jmp _charStart
			table	dw _push, _pop, _show
			top	dw 0			; 栈顶

	_charStart:		push bx
				push dx
				push di
				push es


				cmp ah, 2
				ja _ret
				mov bl, ah
				mov bh, 0
				add bx, bx
				jmp word ptr table[bx]

	_push:			mov bx, top
				mov [si][bx], al
				inc top
				jmp _ret

	_pop:			cmp top, 0
				je _ret
				dec top
				mov bx, top
				mov al, [si][bx]
				jmp _ret

	_show:			mov bx, 0b800h
				mov es, bx
				mov al, 160
				mov ah, 0
				mul dh
				mov di, ax
				add dl, dl
				mov ah, 0
				add di, ax

				mov bx, 0

	_shows:			cmp bx, top
				jne _noempty
				mov byte ptr es:[di], ' '
				jmp _ret
	
	_noempty:		mov al, [si][bx]
				mov es:[di], al
				mov byte ptr es:[di + 2], ' '
				inc bx
					add di, 2
				jmp _shows

	_ret:			pop es
				pop di
				pop dx
				pop bx
				ret

codesg ends
end start
