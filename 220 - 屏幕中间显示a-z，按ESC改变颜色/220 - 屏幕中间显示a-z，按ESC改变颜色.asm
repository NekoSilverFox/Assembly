; 220 - 屏幕中间显示a-z，按ESC改变颜色
; ====================================================

; 编程:在屏幕中间依次显示 'a' ~ 'z'，并可以让人看清。在显示的过程中，按下ESC键后，改变显示的颜色。

; ====================================================
assume cs:codesg, ds:datasg, ss:stacksg
; ====================================================
stacksg segment stack
	db	128 dup (0)
stacksg ends
; ====================================================
datasg segment
	dw	0, 0
datasg ends
; ====================================================

codesg segment
start:			mov ax, stacksg
			mov ss, ax
			mov sp, 128

			call save_init_int9

			call loop_show

			call recover_int9

			mov ax, 4c00h
			int 21H

	; ------------------------------------------
	; 循环打印
	loop_show:	push ax
			push es
			mov ax, 0B800H
			mov es, ax
			mov ah, 'a'
			
	_loopShow:	mov es:[160 * 12 + 40 * 2], ah
			call sleep
			inc ah
			cmp ah, 'z'
			jna _loopShow
			
			pop es
			pop ax
			ret
			

	; ------------------------------------------
	; 将 datasg 段中原来的 int9 的地址恢复
	recover_int9:	push ax
			push ds
			push es
			
			mov ax, datasg
			mov ds, ax

			mov ax, 0
			mov es, ax

			push ds:[0]
			pop es:[4 * 9 + 0]
			push ds:[2]
			pop es:[4 * 9 + 2]

			pop es
			pop ds
			pop ax
			ret
			 

	; ------------------------------------------
	; 将原来的 int9 的地址保存到 datasg 段中，并设置新的int9
	save_init_int9:	push ax
			push ds
			push es

			mov ax, datasg
			mov ds, ax

			mov ax, 0
			mov es, ax

			push es:[9 * 4 + 0]	; IP
			pop ds:[0]
			push es:[9 * 4 + 2]	; CS
			pop ds:[2]

			mov word ptr es:[9 * 4 + 0], OFFSET new_int9
			mov es:[9 * 4 + 2], cs

			pop es
			pop ds
			pop ax
			ret

	; ------------------------------------------
	; 新的int9
	new_int9:	push ax
			push bx
			push ds
			push es

			
			mov ax, datasg
			mov ds, ax

			in al ,60H

			pushf
			pushf
			pop bx
			and bh, 11111100B
			push bx
			popf	; IF = 0, TF = 0

			call dword ptr ds:[0]	; 对int指令进行模拟，调用原来的int9中断例程

			cmp al, 1
			jne _retNewInt9

			mov ax, 0B800H
			mov es, ax
			inc byte ptr es:[160 * 12 + 40 * 2 + 1]

	_retNewInt9:	pop es
			pop ds
			pop bx
			pop ax

			iret	; 注意是 ret

	; ------------------------------------------
	; 延时显示
	sleep:		push ax
			push dx

			mov dx, 10
			mov ax ,0
	_sleep:		sub ax, 1
			sbb dx, 0
			cmp ax, 0
			jne _sleep
			cmp dx, 0
			jne _sleep

			pop dx
			pop ax
			ret

codesg ends
end start
