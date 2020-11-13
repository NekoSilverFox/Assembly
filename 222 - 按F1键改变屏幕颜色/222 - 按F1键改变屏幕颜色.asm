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
start:		mov ax, stacksg
			mov ss, ax
			mov sp, 128
			
			call save_old_int9

			call install_new_int9

			call set_IVT



			call clear_screen

	angin:	call show_ymd

		call show_hms	
		
		call WTF	; 实现边框处根据秒数进行随机变换，瞎写的

		jmp angin

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
			

; -------------------------------------------------
	; 显示年/月/日
	show_ymd:	push ax
			push bx
			push cx
			push dx
			push bp
			push ds
			push es
			push di
			push si

			mov al, 9
			mov bx, 28 * 2
			mov cx, 3

		_showYMD: push ax
			push cx
			out 70h, al
			in al, 71h

			mov ah, al
			mov cl, 4
			shr ah, cl
			and al, 00001111B

			mov cl, 00000011B
			call print_time

			mov dl, '/'
			mov dh, 00001111B
			add bx, 2 * 2

			pop bp
			push bp
			dec bp
			cmp bp, 0
			je _dontPrintYMDSign

			call print_sign			
			
		_dontPrintYMDSign:	add bx, 2

			pop cx
			pop ax
			dec al

			loop _showYMD


			pop si
			pop di
			pop es
			pop ds
			pop bp
			pop dx
			pop cx
			pop bx
			pop ax
			ret
			


	; -------------------------------------------------
	; 显示显示分钟秒
	show_hms:	push ax
			push bx
			push cx
			push dx
			push bp
			push ds
			push es
			push di
			push si

			mov al, 4
			mov bx, 38 * 2
			mov cx, 3

		_showHMS: push ax
			push cx
			out 70h, al
			in al, 71h

			mov ah, al
			mov cl, 4
			shr ah, cl
			and al, 00001111B

			mov cl, 00000010B
			call print_time

			mov dl, ':'
			mov dh, 00001111B
			add bx, 2 * 2

			pop bp
			push bp
			dec bp
			cmp bp, 0
			je _dontPrintHMSSign

			call print_sign
			
		_dontPrintHMSSign:	add bx, 2

			pop cx
			pop ax
			sub al, 2

			loop _showHMS

			pop si
			pop di
			pop es
			pop ds
			pop bp
			pop dx
			pop cx
			pop bx
			pop ax
			ret

	; -------------------------------------------------
	; 打印符号
	; dl = 打印的符号
	; dh = 打印符号的颜色
	; bx = 屏幕中间的位置
	print_sign:	push ax
			push bx
			push dx
			push bp
			push es
			push di

			mov bp, 0B800H
			mov es, bp
			mov di, 160 * 12
			mov byte ptr es:[bx + di + 0], dl
			mov byte ptr es:[bx + di + 1], dh
	
			pop di
			pop es
			pop bp
			pop dx
			pop bx
			pop ax
			ret
	
	; -------------------------------------------------
	; 删除符号
	; bx = 屏幕中间的位置
	del_tail_sign:	push ax
			push bx
			push dx
			push bp
			push es
			push di

			sub bx, 2
			mov bp, 0B800H
			mov es, bp
			mov di, 160 * 12
			mov byte ptr es:[bx + di + 0], 20H
			mov byte ptr es:[bx + di + 1], 0

			pop di
			pop es
			pop bp
			pop dx
			pop bx
			pop ax
			ret

	; -------------------------------------------------
	; 输出到屏幕中间
	; al = 个位数 码值
	; ah = 十位数 码值
	; cl = 颜色
	; bx = 起始位置
	print_time:	push ax
			push bx
			push cx
			push bp
			push es
			push di

			mov bp, 0B800H
			mov es, bp
			mov di, 160 * 12

			add al, 30H	; al 中为月份的个位数码值
			add ah, 30H	; ah 中为月份的十位数码值
			
			mov byte ptr es:[bx + di + 0], ah
			mov byte ptr es:[bx + di + 1], cl
			mov byte ptr es:[bx + di + 2], al
			mov byte ptr es:[bx + di + 3], cl

			pop di
			pop es
			pop bp
			pop cx
			pop bx
			pop ax
			ret

	; -------------------------------------------------
	; 清屏
	clear_screen:	push ax
			push cx
			push es
			push di

			mov ax, 0B800H
			mov es, ax
			mov di, 0

			mov cx, 2000
			mov ax, 0700H	; 0700H 是空白
		
		_clear:	mov es:[di], ax
			add di, 2
			loop _clear
		
			pop di
			pop es
			pop cx
			pop ax
			
			ret





	; -------------------------------------------------
	; 实现一个花里胡哨的功能
	; 实现边框处根据秒数进行随机变换
	; 瞎写的，不用管
	WTF:		push ax
			push bx
			push cx
			push dx
			push bp
			push ds
			push es
			push di
			push si

			mov ax, 0B800H
			mov es, ax
			mov di, 0
			
			mov al, 0
			out 70h, al
			in al, 71h

			mov cx, 80

		_1:	mov byte ptr es:[di + 0], al
			inc al
			mov byte ptr es:[di + 1], al
			inc al
			add di, 2
			loop _1

			mov cx, 25
			mov di, 160

		_2:	mov byte ptr es:[di + 0], al
			mov byte ptr es:[di + 2], al
			inc al
			mov byte ptr es:[di + 1], al
			mov byte ptr es:[di + 3], al
			inc al
			add di, 160
			loop _2

			mov cx, 80
			mov di, 160 * 24

		_3:	mov byte ptr es:[di + 0], al
			inc al
			mov byte ptr es:[di + 1], al
			inc al
			add di, 2
			loop _3

			mov cx, 25
			mov di, 156

		_4:	mov byte ptr es:[di + 0], al
			mov byte ptr es:[di + 2], al
			inc al
			mov byte ptr es:[di + 1], al
			mov byte ptr es:[di + 3], al
			inc al
			add di, 160
			loop _4

			pop si
			pop di
			pop es
			pop ds
			pop bp
			pop dx
			pop cx
			pop bx
			pop ax
			ret

codesg ends
end start
