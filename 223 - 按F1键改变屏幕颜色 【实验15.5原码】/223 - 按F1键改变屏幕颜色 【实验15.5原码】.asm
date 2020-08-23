; 223 - 按F1键改变屏幕颜色 【实验15.5原码】
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
			
			push cs
			pop ds

			mov ax, 0
			mov es, ax

			mov si, OFFSET int9
			mov di, 204h
			mov cx, OFFSET _endInt9 - OFFSET int9

			cld
			rep movsb

			push es:[9 *  4 + 0]
			pop es:[200H]
			push es:[9 * 4 + 2]
			pop es:[202h]

			cli
			mov word ptr es:[9 * 4 + 0], 204H
			mov word ptr es:[9 * 4 + 2], 0
			sti

			mov ax, 4c00h
			int 21h


	int9:		push ax
			push bx
			push cx
			push es

			in al, 60h
			pushf
			call dword ptr cs:[200h]

			cmp al, 3bh
			jne _retInt9

			mov ax, 0B800H
			mov es, ax
			mov bx, 1
			mov cx, 2000
	_s:		inc byte ptr es:[bx]
			add bx, 2
			loop _s

	_retInt9:	pop es
			pop cx
			pop bx
			pop ax
			iret
			
	_endInt9:	nop

			
			

codesg ends
end start
