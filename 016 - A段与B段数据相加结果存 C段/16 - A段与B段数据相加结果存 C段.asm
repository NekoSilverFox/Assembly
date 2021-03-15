; 16 - A段与B段数据相加结果存 C段
; =================================================================
; 程序如下，编写code段中的代码，将a段和b段中的数据依次相加，结果存放在c段中
; =================================================================

assume cs:code

a segment
		db 1,2,3,4,5,6,7,8			; db --> d-data	b-byte 字节型数据	1Byte
a ends

b segment
		db 1,2,3,4,5,6,7,8
b ends

c segment
		db 0,0,0,0,0,0,0,0
c ends

code segment
		start:	mov bx, 0
				mov cx, 8

loopAdd:		mov ax, a
				mov ds, ax
				mov al, ds:[bx]

				mov dx, b
				mov ds, dx
				ADD al, ds:[bx]

				mov dx, c
				mov ds, dx
				mov ds:[bx], al

				inc bx
				loop loopAdd

				mov ax, 4C00H
				int 21H

code ends

end start

