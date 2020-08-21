; 183 - 用int 7ch中断例程实现jmp near ptr指令的功能【中断例程】
; =================================================================

; 用int 7ch中断例程实现jmp near ptr指令的功能，用bx向中断例程传送转移位移。
; 应用举例：在屏幕的第12行，显示data段中以0结尾的字符串
; 程序说明请详见 P257
; 

; =================================================================
assume cs:code, ss:stack, ds:data
; =================================================================
data segment
		db	'conversation', 0
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

		; capital 安装程序
		call local_sqr

		; 设置终断向量表
		call set_IVT

		mov ax, data
		mov ds, ax
		mov si, 0

		mov ax, 0B800H
		mov es, ax
		mov di, 160 * 12

	s:	cmp byte ptr ds:[si], 0		; 比较与0的关系
		je _exit			; 如果是0则程序退出	这是新的退出方法！！！
		mov al, ds:[si]
		mov es:[di + 0], al
		mov byte ptr es:[di + 1], 00000011B
		inc si
		add di, 2
		mov bx, OFFSET s - OFFSET se		; 注意，是 s - se ，得到的是负数
		int 7ch
	se:	nop

	_exit:	mov ax, 4C00H
		int 21H



		; -------------------------------
		; 安装my_loop
		local_sqr:	push ax
				push cx
				push ds
				push es
				push di
				push si

				mov ax, cs
				mov ds, ax
				mov si, OFFSET jmp_near_ptr

				mov ax, 0
				mov es, ax
				mov di, 200H

				mov cx, OFFSET _endJmpNearPtr - OFFSET jmp_near_ptr
				cld		; 设置为正向传送
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
				push es
				mov ax, 0
				mov es, ax
				mov word ptr es:[7ch * 4 + 0], 0200H	; IP
				mov word ptr es:[7ch * 4 + 2], 0000H	; CS
				pop es
				pop ax
				ret


		; -------------------------------
		; 功能：实现loop功能					在栈中： 标志寄存器 cs ip 
		jmp_near_ptr:	pop bp
				add bp, bx
				push bp
				iret
		_endJmpNearPtr:	nop
		
		

code ends

end start
