; 78 - 在屏幕中间显示错误信息
; =================================================================

; 编写一个子程序，将包含任意字符，以0结尾的字符串中的小写字母转变为大写字母

; 名称：letterc
; 功能：将以0结尾的字符串中的小写字母转变为大写字母
; 参数：ds:si 指向字符串首地址
; 
; =================================================================
assume cs:code, ss:stack, ds:data
; =================================================================
data segment
		db	'overflow!'
data ends
; =================================================================
stack segment stack
		db	128 dup (0)
stack ends
; =================================================================
code segment
start:		mov ax, stack
		mov ss, ax
		mov sp, 128


		mov ax, data
		mov ds, ax
		mov si, 0 
		
		; -------------------------------
		; 在屏幕中间显示overflow！
		; 输入：ds:si 指向字符串第一个内容
		; 
		show_error:	push ax
				push cx
				push ds
				push es
				push di
				push si

				mov ax, 0B800H
				mov es, ax
				mov di, 160 * 11 + 40 * 2
				
				mov cx, 9

			_showError:	mov al, ds:[si]
					mov es:[di + 0], al
					mov byte ptr es:[di + 1], 11001111B
					add di, 2
					inc si
					loop _showError

				pop si
				pop di
				pop es
				pop ds
				pop cx
				pop ax
			_ret:	ret
		

code ends

end start
