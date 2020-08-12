; 98 - 利用call、ret将内存中的数据显示在屏幕上【偏移地址在数据段中】
; =================================================================
; 1. 问题一：
;		设计一个程序，程序处理的字符串以0结尾，并且显示在屏幕上
;
; 2. 问题二
;		在屏幕上显示4行字符串，每一行都要换行
; =================================================================










; 				程序内有为修改错误












assume cs:codesg, ds:datasg, ss:stacksg

; =================================================================

datasg segment
		db '1) restart pc ', 0		; 可以利用jczx判断，cx == 0 时退出跳转
		db '2) start system ', 0
		db '3) show clock ', 0
		db '4) set clock ', 0
		
		dw 0, 0FH, 20H, 2FH		; <<=== 为什么用dw？因为一会操作的寄存器为16位寄存器
datasg ends

; =================================================================

stacksg segment
		db 128 dup (0)
stacksg ends

; =================================================================

codesg segment
main:		mov ax, stacksg
		mov ss, ax	; !!!!!!记住，先设置栈段，因为call要用到栈
		mov sp, 128


		call set_reg

		call show_option


		mov ax, 4c00h
		int 21H

	; ------------------------------------
	set_reg:	mov ax, 0B800H
			mov es, ax
		
			mov ax, datasg
			mov ds, ax

			
			mov cx, 4
			mov bx, 3CH
			mov di, 0
			mov si, 160 * 10 + 64
			ret
	; ------------------------------------
	show_option:	mov di, ds:[bx + 0]
			call show_string
			add bx, 2
			add si, 160
			loop show_option
			
			ret

	; ------------------------------------
	show_string:	push cx
			push bx
			push ds
			push es
			push si
			push di
			
			mov ch, 0
	showString:	mov cl, ds:[di]
			jcxz show_str_ret
			inc di
			mov es:[si], cl
			add si, 2
			jmp showString
	show_str_ret:	pop di
			pop si
			pop es
			pop ds
			pop bx
			pop cx
			ret

codesg ends
end main

; =================================================================;



