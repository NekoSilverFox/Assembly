; 116 - 设计一简化版的综合优化
; =================================================================




; =================================================================
assume cs:code, ds:data, ss:stack
; =================================================================
data segment
		db	'Welcome to msam!', 0
data ends
; =================================================================
stack segment stack
		db	128 dup (0)
stack ends
; =================================================================
code segment
start:		mov ax ,stack
		mov ss, ax
		mov sp, 128

		mov ax, data
		mov ds, ax
		mov si, 0

		mov ax, 0B800H
		mov es, ax
		;mov di, 160 * 3

		mov dl, 5
		mov dh, 3
		mov cl, 11000010B
		call show_str

		mov ax, 4c00h
		int 21h


	
	; -------------------------------------
	; 1. 显示字符串
	; 名称：show_str
	; 功能：在指定位置，用指定颜色，显示一个用0结束的字符串
	; 参数：(dh)=行号（取值范围0~24）,（dl）=列号（取值范围0~79）
	; 	(cl)=颜色，ds:si指向字符串首地址
	; 
	; 返回：无
	;
	; 应用举例：在屏幕的8行3列，用绿色显示data段中的字符串
	;
	show_str: 	push ax
			push bx
			push ds
			push es
			push di
			push si
			push cx
			push dx
			
			mov ah, 0 
			mov al, 160
			mov dh, 0
			mov bx, dx
			mov dx, 0
			mul bx
			pop dx
			mov dh, 0
			add ax, dx	; 注意这里加两遍，不能简单地将列号相加，因为显示一个字符用了两个字节
			add ax, dx
			mov bx, ax

			; 确定输出的位置

		_showStr:	mov cx, 0
				mov cl, ds:[si + 0]
				jcxz _retShowStr
				mov es:[bx + 0], cl
				pop cx
				push cx
				mov byte ptr es:[bx + 1], cl
				inc si
				add bx, 2
				jmp _showStr

		_retShowStr:	pop cx
				pop si
				pop di
				pop es
				pop ds
				pop bx
				pop ax
				ret


	
code ends

end start

