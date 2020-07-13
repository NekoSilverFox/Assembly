; 17 - 用push将A段中的前8个字型数据逆序复制到B段中
; =================================================================
; 程序如下，编写code段中的代码，用push指令 将 a段中前8个字型数据，逆序复制到b段中
; =================================================================

assume cs:code

a segment
		db 1,2,3,4,5,6,7,8,0AH,0BH,0CH,0DH,0EH,0FH,0FFH
a ends

b segment
		db 0,0,0,0,0,0,0,0
b ends

code segment
		start:	mov ax, a
				mov ds, ax

				mov ax, b
				mov ss, ax
				mov sp, 16

				mov bx, 0
				mov cx, 8

loopPush:		mov ah, ds:[bx]
				inc bx
				mov al, ds:[bx]
				inc bx

				push ax
				loop loopPush

				mov ax, 4C00H
				int 21H

code ends

end start

