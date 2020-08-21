; 187 - 显示0结尾的字符串，并实现类似int 10h功能【中断例程】
; =================================================================

; 编写、安装中断7ch的中断例程,功能为显示一个用0结束的字符串，中断例程安装在 0:200 处

; 程序说明请详见 P263
; 功能：编写、安装中断7ch的中断例程,功能为显示一个用0结束的字符串，中断例程安装在 0:200 处
; 参数：(dh)=行号	(dl)=列号	(cl)=颜色	ds:si指向字符串首地址
; 应用举例
; =================================================================

assume cs:code, ss:stack, ds:data
; =================================================================
data segment
		db 'Welcome to masm!', 0
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

		; 安装local_print_str
		call local_print_str


		; 写入中断向量表
		call set_IVT

		mov dh, 10
		mov dl, 10
		mov cl, 2
		mov ax, data
		mov ds, ax
		mov si, 0
		int 7ch

		mov ax, 4c00h
		int 21h


	
		; ---------------------------------------------------------------------------------------
		; 安装local_print_str
	local_print_str:push ax
			push cx
			push ds
			push es
			push di
			push si

			mov ax, cs
			mov ds, ax
			mov si, OFFSET print_str

			mov ax, 0
			mov es, ax
			mov di, 200H
			mov cx, OFFSET _endPrintStr - OFFSET print_str
			cld
			rep movsb

			pop si
			pop di
			pop es
			pop ds
			pop cx
			pop ax
			ret

		; ---------------------------------------------------------------------------------------
		; 写入中断向量表
	set_IVT:	push ax
			push es

			mov ax, 0
			mov es, ax
			mov word ptr es:[7ch * 4 + 0], 200H	; IP
			mov word ptr es:[7ch * 4 + 2], 0	; CS
			
			pop es
			pop ax
			ret


		; ---------------------------------------------------------------------------------------
		; 编写、安装中断7ch的中断例程,功能为显示一个用0结束的字符串，中断例程安装在 0:200 处
		; 功能：编写、安装中断7ch的中断例程,功能为显示一个用0结束的字符串，中断例程安装在 0:200 处
		; 参数：(dh)=行号	(dl)=列号	(cl)=颜色	ds:si指向字符串首地址
	print_str:	push ax
			push cx
			push ds
			push es
			push di
			push si

			mov ax, 0B800H
			mov es, ax
			mov ax, 0
			mov al, 160
			mul dh
			mov dh, 0
			add ax, dx
			mov di, ax
		
			mov ah, cl	; 颜色转存到 ah 中
			mov cx, 0

	_copyByte:	mov cl, ds:[si]
			jcxz _iretPrintStr
			mov es:[di + 0], cl
			mov es:[di + 1], ah
			inc si
			add di, 2
			jmp _copyByte

	_iretPrintStr:	pop si
			pop di
			pop es
			pop ds
			pop cx
			pop ax
			iret
			
	_endPrintStr:	nop
			

code ends

end start
