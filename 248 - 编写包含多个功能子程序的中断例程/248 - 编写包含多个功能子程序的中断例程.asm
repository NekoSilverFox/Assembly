; 248 - 编写包含多个功能子程序的中断例程
; ======================================================

; 安装一个新的 int 7ch 中断例程，为显示输出提供如下功能的子程序

; ======================================================
; 在直接定址表中储存子程序的地址，从而方便的实现不同子程序的调用
; 
; 实现一个 setscreen，为显示输出提供以下功能
; 
; （1）清屏
; （2）设置前景色，文字颜色
; （3）设置背景色
; （4）向上滚动一行
; 
; 入口参数的说明如下：
; ah - 传递功能号：0 - 清屏，1 - 设置前景色， 2 - 设置背景色，3 - 向上滚动一行
; al - 传递颜色{0 ~ 7}

; （1）清屏		将显存中当前屏幕中的字符设置为空格符	
; （2）设置前景		设置当前显存中当前屏幕中处于 奇地址 的属性字节的 第 0,1,2 位
; （3）设置背景色	设置当前显存中当前屏幕中处于 奇地址 的属性字节的 第 4,5,6 位
; （4）向上滚动一行	依次将第n+1行的内容复制到 n 行处；最后一行为空
; 

; ======================================================

; 感悟：可以把这种用标号的使用看做成 C/C++ 中的数组

; ======================================================
assume cs:codesg, ss:stacksg
; ======================================================
stacksg segment stack
	db 128 dup (0)
stacksg ends
; ======================================================
codesg segment
start:		mov ax, stacksg
		mov ss, ax
		mov sp, 128

		; 拷贝数据到中断向量表中
		call install_int7ch

		call set_IVT



		mov ah, 1
		mov al, 00000110B
		int 7ch

		mov ah, 2
		mov al, 00100000B
		int 7ch

		mov ah, 3
		int 7ch

		mov ax, 4c00h
		int 21h



	; ---------------------------------------------
	set_IVT:	push ax
			push es

			mov ax, 0
			mov es, ax
			
			cli			
			mov word ptr es:[7ch * 4 + 0], 200H	; IP
			mov word ptr es:[7ch * 4 + 2], 0H	; CS
			sti

			pop es
			pop ax

			ret

	; ---------------------------------------------
	install_int7ch:	push ax
			push cx
			push ds
			push es
			push di
			push si

			mov ax, 0
			mov es, ax
			mov di, 200H

			mov ax, cs
			mov ds, ax
			mov si, OFFSET int_set_screen

			mov cx, OFFSET _endSet - OFFSET int_set_screen
			cld
			rep movsb
			
			pop si
			pop di
			pop es
			pop ds
			pop cx
			pop ax
			ret

	; ---------------------------------------------
	; 将这些设置程序功能子程序的入口地址储存在一个表中，他们在表中的功能和位置相对应。
	; 对应关系为：功能号 * 2 = 对应的功能子程序在地址表中的偏移
	int_set_screen:	jmp _setScreen
		
			table	dW	OFFSET clear_screen - OFFSET int_set_screen + 200H
				dw	OFFSET set_font - OFFSET int_set_screen + 200H
				dw	OFFSET set_background - OFFSET int_set_screen + 200H		; ！！！！！！这个地方是重点！！！！！！
				dw	OFFSET up_row - OFFSET int_set_screen + 200H

	_setScreen:	push ax
			push bx
			push es

			cmp ah, 3
			ja _retSet

			mov bx, 0
			mov es, bx

			mov bl, ah
			mov bh, 0
			add bx, bx	; 根据 ah 中的功能号计算对算对应子程序在 table 表中的 段地址 + 偏移地址
			add bx, OFFSET table - OFFSET int_set_screen + 200H

			call word ptr es:[bx]

	_retSet:	pop es
			pop bx
			pop ax
			iret


		

			
	; ---------------------------------------------
	; （1）清屏		将显存中当前屏幕中的字符设置为空格符
	clear_screen:	push bx
			push cx
			push es

			mov bx, 0B800h
			mov es, bx
			mov bx, 0
			mov cx, 2000

	_clearScreen:	mov es:[bx], 0700H
			add bx, 2
			loop _clearScreen

			pop es
			pop cx
			pop bx
			ret

	; ---------------------------------------------
	; （2）设置前景		设置当前显存中当前屏幕中处于 奇地址 的属性字节的 第 0,1,2 位
	set_font:	push bx
			push cx
			push es

			mov bx, 0B800H
			mov es, bx
			mov bx, 1
			mov cx, 2000
	
	_setFont:	and byte ptr es:[bx], 11111000B
			or es:[bx], al
			add bx, 2
			loop _setFont
		
			pop es
			pop cx
			pop bx
			ret

	; ---------------------------------------------
	;（3）设置背景色	设置当前显存中当前屏幕中处于 奇地址 的属性字节的 第 4,5,6 位
	set_background:	push bx
			push cx
			push es

			mov bx, 0B800H
			mov es, bx
			mov bx, 1
			mov cx, 2000

	_setBackground:	and byte ptr es:[bx], 10001111B
			or es:[bx], al
			add bx, 2
			loop _setBackground

			pop es
			pop cx
			pop bx
			ret

	; ---------------------------------------------
	; （4）向上滚动一行	依次将第n+1行的内容复制到 n 行处；最后一行为空
	up_row:		push bx
			push cx
			push ds
			push es
			push di
			push si
			
			mov bx, 0B800H
			mov es, bx
			mov ds, bx
			mov di, 0
			mov si, 160
			mov cx, 160 * 23

			cld	; 正向传送
			rep movsw

			; 最后一行清空
			mov cx, 160
	_upRow:		mov ds:[si], 0700H
			add si, 2
			loop _upRow

			pop si
			pop di
			pop es
			pop ds
			pop cx
			pop bx
			ret


	_endSet:	nop

codesg ends
end start
