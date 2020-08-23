; 222 - ��F1���ı���Ļ��ɫ
; ====================================================

; ���񣺰�װ�µ� int9 �ж�����
; ���ܣ���F1���ı���Ļ��ɫ������������

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
			mov si, OFFSET new_int9
			
			mov ax, 0
			mov es, ax
			mov di, 204H

			cld	; ������
			mov cx, OFFSET _endNewInt9 - OFFSET new_int9
			rep movsb

			pop es
			pop ds
			pop cx
			pop ax
			ret
			

	; ------------------------------------
	; �µ�int 9�� ��F1���ı���Ļ��ɫ 
	new_int9:	push ax
			push es
			push di

			in al, 60h		

			;mov ax, 0
			;mov es, ax
			pushf		; <<==== ǧ������˽���־�Ĵ�����ջ����Ϊ�����õ��� iret ��Ҫ�ָ�
			call dword ptr CS:[200H]
			;call dword ptr es:[200H]	; ִ���ж�����ʱ CS�Ѿ� = 0�ˣ����Բ���Ҫע�Ͳ���


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
	; ����ԭ�� int 9 ��CS��IP
	save_old_int9:	push ax
			push ds
			mov ax, 0
			mov ds, ax
			
			cli
			push ds:[9 * 4 + 0]
			pop ds:[200H + 0]
			push ds:[9 * 3 + 2]
			pop ds:[200H + 2]
			sti
			

			pop ds
			pop ax
			ret
			

codesg ends
end start
