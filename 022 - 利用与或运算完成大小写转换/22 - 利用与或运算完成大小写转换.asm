; 22 - 利用与或运算完成大小写转换
; =================================================================

assume cs:codesg, ds:datasg

datasg segment
			db 'BaSiC'
			db 'iNfOrMaTiOn'
datasg ends
; ===================================
codesg segment

start:		mov ax, datasg
			mov ds, ax

			mov bx, 0
			mov cx, 5

loopBigger:	mov dl, ds:[bx]
			and dl, 11011111B
			mov ds:[bx], dl
			inc bx
			loop loopBigger

			mov cx, 11

loopSmaller:	mov dl, ds:[bx]
			or dl, 00100000B
			mov ds:[bx], dl
			inc bx
			loop loopSmaller

codesg ends

end start