; 220 - ��Ļ�м���ʾa-z����ESC�ı���ɫ
; ====================================================

; ���:����Ļ�м�������ʾ 'a' ~ 'z'�����������˿��塣����ʾ�Ĺ����У�����ESC���󣬸ı���ʾ����ɫ��

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
	; ѭ����ӡ
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
	; �� datasg ����ԭ���� int9 �ĵ�ַ�ָ�
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
	; ��ԭ���� int9 �ĵ�ַ���浽 datasg ���У��������µ�int9
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
	; �µ�int9
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

			call dword ptr ds:[0]	; ��intָ�����ģ�⣬����ԭ����int9�ж�����

			cmp al, 1
			jne _retNewInt9

			mov ax, 0B800H
			mov es, ax
			inc byte ptr es:[160 * 12 + 40 * 2 + 1]

	_retNewInt9:	pop es
			pop ds
			pop bx
			pop ax

			iret	; ע���� ret

	; ------------------------------------------
	; ��ʱ��ʾ
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
