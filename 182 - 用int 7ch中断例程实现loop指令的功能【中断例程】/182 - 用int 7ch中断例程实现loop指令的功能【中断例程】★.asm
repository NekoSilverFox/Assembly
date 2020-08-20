; 182 - 用int 7ch中断例程实现loop指令的功能【中断例程】
; =================================================================

; 182 - 用int 7ch中断例程实现loop指令的功能【中断例程】

; 程序说明请详见 P256
; 在屏幕中间显示80个"!"，使用int 7ch代替loop

; =================================================================
assume cs:code, ss:stack
; =================================================================

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

		mov ax, 0B800H
		mov es, ax
		mov di, 160*12

		mov bx, OFFSET s - OFFSET se	; 为什么用 s - se？ 想象一下，减出来是负数，在后续程序中跳转到s时候就可 add 一个负数。相当于减法
		mov cx, 80

	s:	mov byte ptr es:[di + 0], '!'
		mov byte ptr es:[di + 1], 00000111B
		add di, 2
		int 7ch				; 使用 int 7ch 代替（实现）loop指令
	se:	nop		


		mov ax, 4C00H
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
				mov si, OFFSET my_loop

				mov ax, 0
				mov es, ax
				mov di, 200H

				mov cx, OFFSET _endMyLoop - OFFSET my_loop
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
		set_IVT:	
				mov ax, 0
				mov es, ax
				mov word ptr es:[7ch * 4 + 0], 0200H	; IP
				mov word ptr es:[7ch * 4 + 2], 0000H	; CS

				ret


		; -------------------------------
		; 功能：实现loop功能
		my_loop:	push bp		; 暂存bp
				mov bp, sp	; (sp) = int 7ch 的下一条指令的IP
				dec cx
				jcxz _iretMyLoop
				add ss:[bp + 2], bx	; 复习：bp和ss相关联, 在这里bx是指令的位移，加上以后 ss:[bp + 2] 指向了 s
		_iretMyLoop:	pop bp		; 弹出暂存的 bp，将栈顶恢复到指向(sp) = int 7ch 的下一条指令的IP
				iret
		_endMyLoop:	nop
		
		

code ends

end start
