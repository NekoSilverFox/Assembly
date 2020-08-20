; 170 - 错误信息写入中断向量表【内中断】
; =================================================================

; 程序说明请详见 P240
; 

; 注意：因为win10 的中断机制不同，所以这个代码可能不会正确运行

; =================================================================
assume cs:code, ss:stack, ds:data
; =================================================================
data segment
	;	db	'overflow!'	不能写在这里，因为程序运行完，其他程序可能会覆盖掉这里面的内容
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

		; do0安装程序
		call local_do0

		; 设置终断向量表
		call set_IVT

		mov ax, 2233H
		mov bx, 0
		div bx

		mov ax, 4C00H
		int 21H



		; -------------------------------
		; 安装do0
		local_do0:	push ax
				push cx
				push ds
				push es
				push di
				push si

				mov ax, cs	; <-- 注意这里是CS
				mov ds, ax 
				mov si, OFFSET do0

				mov ax, 0000H
				mov es, ax
				mov di, 0200H
				mov cx, OFFSET _do0Ret  - OFFSET do0	; 代码长度
				cld
				rep movsb

				pop si
				pop di
				pop es
				pop ds
				pop cx
				pop ax
				ret


		; -------------------------------
		; 设置终断向量表
		set_IVT:	push ax
				push ds
				
				mov ax, 0
				mov ds, ax
				mov word ptr ds:[0 * 4 + 0], 0200H		; IP 别再设反了！！！！
				mov word ptr ds:[0 * 4 + 2], 0H			; CS

				pop ds
				pop ax
				ret


		; -------------------------------
		; 在屏幕中间显示overflow！
		; 输入：ds:si 指向字符串第一个内容
		; 
		do0:		jmp short _do0Start
				db	'overflow!'	; 会放到中断向量表中
	
			_do0Start:	push ax
					push cx
					push ds
					push es
					push di
					push si

					mov ax, cs
					mov ds, ax
					mov si, 202H	; <-- 因为'overflow!'放到了向量表中的空闲内存中，所以是202H

					mov ax, 0B800H
					mov es, ax
					mov di, 160 * 12 + 36 * 2
				
					mov cx, 9

			_do0:		mov al, ds:[si]
					mov es:[di + 0], al
					mov byte ptr es:[di + 1], 11001111B
					add di, 2
					inc si
					loop _do0

				pop si
				pop di
				pop es
				pop ds
				pop cx
				pop ax
				ret

			_do0Ret:	nop	; <<==== 要指向结束的下一个字节！！！！
		

code ends

end start
