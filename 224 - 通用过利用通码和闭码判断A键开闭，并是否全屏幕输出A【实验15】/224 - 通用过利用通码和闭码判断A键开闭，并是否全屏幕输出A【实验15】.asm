; 224 - ͨ�ù�����ͨ��ͱ����ж�A�����գ����Ƿ�ȫ��Ļ���A��ʵ��15��
; ====================================================

; Ҫ����� P285

; ��װһ���µ� int 9 �ж�����
; ���ܣ��� DOS �£����¡�A�����󣬳��ǲ����ɿ�������ɿ�������ʾ����Ļ�ġ�A�����������ճ�����

; ��ʾ������һ����������ɨ�����Ϊͨ�룬�ɿ�һ����������ɨ�����Ϊ���롣���� = ͨ�� + 80H

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
		; ���¡�A�����󣬳��ǲ����ɿ�������ɿ�������ʾ����Ļ�ġ�A�����������ճ�����
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


		_exitShowA:	pushf		; <<==== ǧ������˽���־�Ĵ�����ջ����Ϊ�����õ��� iret ��Ҫ�ָ�
				call dword ptr CS:[200H]

				iret
		_endShowA:	nop

		; --------------------------------
		; �����Ļ
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
	; �����ж�������
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
	; �µ�int 9 ������ 0:204
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

			cld	; ������
			mov cx, OFFSET _endShowA - OFFSET show_A
			rep movsb

			pop es
			pop ds
			pop cx
			pop ax
			ret

	; ------------------------------------
	; ����ԭ�� int 9 ��CS��IP
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
