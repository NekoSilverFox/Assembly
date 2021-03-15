; 23 - 利用[bx+idata]优化与或运算完成大小写转换
; =================================================================
; 在 codesg中填写代码，将datasg中定义的第一个字符串转换为大写，第二个字符串转换为小写
; =================================================================

assume cs:codesg, ds:datasg

datasg segment
			db 'BaSiC'
			db 'MinIX'
datasg ends
; ===================================
codesg segment

start:		mov ax, datasg
			mov ds, ax

			mov bx, 0
			mov cx, 5

loopChange:	mov dl, ds:[bx]
			and dl, 11011111B
			mov ds:[bx], dl

			mov dl, ds:[bx + 5]
			or dl, 00100000B
			mov ds:[bx + 5], dl

			inc bx
			loop loopChange
codesg ends

end start