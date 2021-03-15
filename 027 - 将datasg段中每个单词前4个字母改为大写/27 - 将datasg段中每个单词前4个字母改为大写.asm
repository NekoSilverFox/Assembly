; 27 - 将datasg段中每个单词前4个字母改为大写
; =================================================================
; 将datasg段中每个单词前4个字母改为大写
; 	习惯：si - 数据从哪里来
; 	习惯：di - 数据到哪里去
; 	本测试属于P154，问题7.7
; =================================================================

assume cs:codesg, ds:datasg, ss:stacksg

stacksg segment
				dw 0,0,0,0,0,0,0,0
stacksg ends

datasg segment
				db '1. dispaly      '
				db '2. brows        '
				db '3. replace      '
				db '4. modify       '
				db 'vax             '
datasg ends

;===================================

codesg segment
start:			mov ax, datasg
				mov ds, ax

				mov si, 0	; 行
				mov cx, 4

loopRow:		push cx
				mov cx, 4
				mov bx, 0

		loopCol:		mov al, ds:[si + bx + 3]
						and al, 11011111B		; 注意！读取的是一个字母，所以是一字节！！用字节型寄存器！！！
						mov ds:[si + bx + 3], al
						inc bx
						loop loopCol

				pop cx
				add  si, 16
				loop loopRow

codesg ends

end start