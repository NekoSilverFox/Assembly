; 224 - 通用过利用通码和闭码判断A键开闭，并是否全屏幕输出A【实验15】
; ====================================================

; 要求请见 P285

; 安装一个新的 int 9 中断例程
; 功能：在 DOS 下，按下“A”键后，除非不再松开，如果松开，就显示满屏幕的“A”，其他键照常处理

; 提示，按下一个键产生的扫描码成为通码，松开一个键产生的扫描码成为断码。断码 = 通码 + 80H

; ====================================================
assume cs:codesg
; ====================================================
stacksg segment stack
	db 128 dup (0)
stacksg ends
; ====================================================
codesg segment
start:				mov ax, stacksg
				mov ss, ax
				mov sp, 128

				call clear_screen
				
				call save_old_int9

				call install_new_int9
							
				call set_IVT

				mov ax, 4c00h
				int 21h
				
		; --------------------------------
		; 按下“A”键后，除非不再松开，如果松开，就显示满屏幕的“A”，其他键照常处理
		show_A:		

				in al, 60h

				cmp al, 1Eh
				jne _exitShowA

		_againRead:	in al, 60h
				cmp al, 1EH
				je _againRead
				mov ax, 0B800h
				mov es, ax
				mov di, 0
				mov cx, 2000
		_printA:	mov byte ptr es:[di + 0], 'A'
				mov byte ptr es:[di + 1], 00000011B
				add di, 2
				loop _printA


		_exitShowA:	pushf		; <<==== 千万别忘了将标志寄存器入栈，因为后面用的是 iret 需要恢复
				call dword ptr CS:[200H]

				iret
		_endShowA:	nop

		; --------------------------------
		; 清空屏幕
		clear_screen:	push ax
				push es
				push di

				mov ax, 0B800H
				mov es, ax
				mov di, 0

				mov cx, 2000
		_clearScreen:	mov es:[di], 0700H
				add di, 2
				loop _clearScreen

				pop di
				pop es
				pop ax
				ret
			

	; ------------------------------------
	; 设置中断向量表
	set_IVT:	push ax
			push es

			mov ax, 0
			mov es, ax

			cli
			mov word ptr es:[9 * 4 + 0], 0204H	; IP
			mov word ptr es:[9 * 4 + 2], 0H		; CS
			sti

			pop es
			pop ax
			ret

	; ------------------------------------
	; 新的int 9 拷贝到 0:204
	install_new_int9: 
			push ax
			push cx
			push ds
			push es

			mov ax, cs
			mov ds, ax
			mov si, OFFSET show_A
			
			mov ax, 0
			mov es, ax
			mov di, 204H

			cld	; 正向传送
			mov cx, OFFSET _endShowA - OFFSET show_A
			rep movsb

			pop es
			pop ds
			pop cx
			pop ax
			ret

	; ------------------------------------
	; 保存原来 int 9 的CS：IP
	save_old_int9:	push ax
			push ds
			mov ax, 0
			mov ds, ax
			
			cli
			push ds:[9 * 4 + 0]
			pop ds:[200H + 0]
			push ds:[9 * 4 + 2]
			pop ds:[200H + 2]
			sti
			

			pop ds
			pop ax
			ret
			
codesg ends
end start
