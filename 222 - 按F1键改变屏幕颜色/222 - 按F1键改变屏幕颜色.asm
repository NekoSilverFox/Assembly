; 222 - 按F1键改变屏幕颜色
; ====================================================

; 任务：安装新的 int9 中断例程
; 功能：按F1键改变屏幕颜色，其他键不变

; ====================================================
assume cs:codesg, ss:stacksg
; ====================================================
stacksg segment stack
	db	128 dup (0)
stacksg ends
; ====================================================

codesg segment
start:			mov ax, stacksg
			mov ss, ax
			mov sp, 128
			
			call save_old_int9

			call install_new_int9

			call set_IVT

			mov ax, 4c00h
			int 21h

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
			mov si, OFFSET new_int9
			
			mov ax, 0
			mov es, ax
			mov di, 204H

			cld	; 正向传送
			mov cx, OFFSET _endNewInt9 - OFFSET new_int9
			rep movsb

			pop es
			pop ds
			pop cx
			pop ax
			ret
			

	; ------------------------------------
	; 新的int 9， 按F1键改变屏幕颜色 
	new_int9:	push ax
			push es
			push di

			in al, 60h		

			;mov ax, 0
			;mov es, ax
			pushf		; <<==== 千万别忘了将标志寄存器入栈，因为后面用的是 iret 需要恢复
			call dword ptr CS:[200H]
			;call dword ptr es:[200H]	; 执行中断例程时 CS已经 = 0了，所以不需要注释部分


			cmp al, 3BH
			jne _iretNewInt9

			mov ax, 0B800H
			mov es, ax
			mov di, 1
			mov cx, 2000
	_changeColor:	inc byte ptr es:[di]
			add di, 2
			loop _changeColor

	_iretNewInt9:	pop di
			pop es
			pop ax
			iret		

	_endNewInt9:	nop

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