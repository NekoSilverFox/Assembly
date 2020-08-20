; 180 - 求word型数据平方【中断例程】
; =================================================================

; 编写、安装中断7ch的中断例程

; 程序说明请详见 P253
; 功能：求一word型数据的平方
; 参数：(ax)=要计算的数据
; 返回值：dx, ax中存放结果的高16位和低16位
; 应用举例：2*3456^2

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

		; sqr安装程序
		call local_sqr

		; 设置终断向量表
		call set_IVT

		mov ax, 3456
		int 7ch

		add ax, ax
		adc dx, dx	; <==== 注意是adc，因为要进位

		mov ax, 4C00H
		int 21H



		; -------------------------------
		; 安装sqr
		local_sqr:	push ax
				push ds
				push es
				push di
				push si

				mov ax, cs
				mov ds, ax
				mov si, OFFSET sqr

				mov ax, 0
				mov es, ax
				mov di, 200H

				mov cx, OFFSET _retSqr - OFFSET sqr	; 设置循环次数为 sqr程序长度
				cld		; 设置为正向
	
				rep movsb
	
				pop si
				pop di
				pop es
				pop ds
				pop ax
				ret


		; -------------------------------
		; 设置终断向量表
		set_IVT:	push ax
				push es

				mov ax, 0
				mov es, ax
				mov word ptr es:[7ch * 4 + 0], 0200H	; IP	并且，注意是 *4
				mov word ptr es:[7ch * 4 + 2], 0000H	; CS

				pop es
				pop ax
				ret


		; -------------------------------
		; 功能：求一word型数据的平方
		; 参数：(ax)=要计算的数据
		; 返回值：dx, ax中存放结果的高16位和低16位
		sqr:		mul ax
				iret		; <--- 使用 iret 来顺便实现 popf
		_retSqr:	nop	; <<==== 要指向结束的下一个字节！！！！
		

code ends

end start
