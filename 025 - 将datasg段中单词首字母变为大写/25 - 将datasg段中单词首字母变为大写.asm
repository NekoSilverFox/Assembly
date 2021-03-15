; 25 - 将datasg段中单词首字母变为大写
; =================================================================
; 将datasg段中单词首字母变为大写
; 	习惯：si - 数据从哪里来
; 	习惯：di - 数据到哪里去
; 	本测试属于P152，问题7.6
; =================================================================

assume cs:codesg, ds:datasg

datasg segment
				db '1. file         '
				db '2. edit         '
				db '3. search       '
				db '4. view         '
				db '5. options      '
				db '6. help         '
datasg ends

;===================================

codesg segment
start:			mov ax, datasg
				mov ds, ax

				mov si, 3
				mov bx, 0
				mov cx, 6

changeLatter:	mov al, ds:[bx + si]		; 注意！读取的是一个字母，所以是一字节！！用字节型寄存器！！！
				and al, 11011111B
				mov ds:[bx + si], al

				add bx, 16
				loop changeLatter
codesg ends

end start