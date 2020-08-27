; 261 - �ַ�������
; ======================================================

; P304

; ��������ַ������������Ҫ�߱����¹���
; 1. �������ͬʱ��Ҫ��ʾ����ַ���
; 2. һ��������س������ַ����������
; 3. �ܹ�ɾ���Ѿ�������ַ���

; ======================================================

; ��дһ�������ַ���������ӳ���ʵ������3���������ܡ���Ϊ������Ĺ�������Ҫ��ʾ���ӳ���Ĳ�������
; (dh)��(dl) = �ַ�������Ļ����ʾ���С���λ��
; ds:si ָ���ַ����Ĵ���ռ䣬�ַ�����0Ϊ��β��

; ======================================================

; ���ܱ�ţ�0��ah��ȡ��
; 
; mov ah, 0
; int 16h
; ��ȡ�� ɨ�������� ah��ASCII������ al
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

		call get_str

		mov ax, 4c00h
		int 21h

	; ===================================
	; �ӳ��򣺽����ַ�������
	get_str:		push ax

	_getStrs:		mov ah, 0
				int 16h
				cmp al, 20h	; ASCII��С��20h˵�������ַ�
				jb nochar
				mov ah, 0
				call char_stack	; �ַ���ջ
				mov ah, 2
				call char_stack	; ��ʾջ���ַ�
				jmp _getStrs

	nochar:			cmp ah, 0eh	; �˸����ɨ����
				je _backspace
				cmp ah, 1ch	; Enter ��ɨ����
				je _enter
				jmp _getStrs

	_backspace:		mov ah, 1
				call char_stack	; �ַ���ջ
				mov ah, 2
				call char_stack
				jmp _getStrs

	_enter:			mov al, 0
				mov ah, 0
				call char_stack	; 0 ��ջ
				mov ah, 2
				call char_stack	; ��ʾջ���ַ���
				pop ax
				ret


	; ===================================
	; �ӳ����ַ�ջ����ջ����ջ����ʾ
	; ����˵����(ah) = ���ܺţ�0 ��ʾ��ջ��1 ��ջ��2��ʾ
	; ds:si ָ��ջ�ռ�
	; ���� 0 �� ���ܣ���al��= ��ջ�ַ�
	; ���� 1 �� ���ܣ���al��= �����ַ�
	; ���� 2 �� ���ܣ���dh������dl��= �ַ�������Ļ�ϵ���ʾ�С���λ��
	char_stack:		jmp _charStart
			table	dw _push, _pop, _show
			top	dw 0			; ջ��

	_charStart:		push bx
				push dx
				push di
				push es


				cmp ah, 2
				ja _ret
				mov bl, ah
				mov bh, 0
				add bx, bx
				jmp word ptr table[bx]

	_push:			mov bx, top
				mov [si][bx], al
				inc top
				jmp _ret

	_pop:			cmp top, 0
				je _ret
				dec top
				mov bx, top
				mov al, [si][bx]
				jmp _ret

	_show:			mov bx, 0b800h
				mov es, bx
				mov al, 160
				mov ah, 0
				mul dh
				mov di, ax
				add dl, dl
				mov ah, 0
				add di, ax

				mov bx, 0

	_shows:			cmp bx, top
				jne _noempty
				mov byte ptr es:[di], ' '
				jmp _ret
	
	_noempty:		mov al, [si][bx]
				mov es:[di], al
				mov byte ptr es:[di + 2], ' '
				inc bx
					add di, 2
				jmp _shows

	_ret:			pop es
				pop di
				pop dx
				pop bx
				ret

codesg ends
end start
