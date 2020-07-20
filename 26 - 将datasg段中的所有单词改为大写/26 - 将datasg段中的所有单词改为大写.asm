; 26 - 将datasg段中的所有单词改为大写
; =================================================================
; 将datasg段中的所有单词改为大写
; 	习惯：si - 数据从哪里来
; 	习惯：di - 数据到哪里去
; 	本测试属于P154，问题7.7
; =================================================================

assume cs:codesg, ds:datasg

datasg segment
				db 'ibm             '
				db 'dec             '
				db 'dos             '
				db 'vax             '
datasg ends

;===================================

codesg segment
start:			mov ax, datasg
				mov ds, ax

				mov si, 0	; 行
				mov cx, 4

loopRow:		push cx
				mov cx, 3
				mov bx, 0

		loopCol:		mov al, ds:[si + bx]
						and al, 11011111B		; 注意！读取的是一个字母，所以是一字节！！用字节型寄存器！！！
						mov ds:[si + bx], al
						inc bx
						loop loopCol

				pop cx
				add  si, 16
				loop loopRow

codesg ends

end start