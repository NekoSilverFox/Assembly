; 247 - ��ֱ�Ӷ�ַ���д����ӳ����ַ��ʵ�ַ�����ӳ������
; ======================================================

; ��ֱ�Ӷ�ַ���д����ӳ���ĵ�ַ���Ӷ������ʵ�ֲ�ͬ�ӳ���ĵ���
; 
; ʵ��һ�� setscreen��Ϊ��ʾ����ṩ���¹���
; 
; ��1������
; ��2������ǰ��ɫ��������ɫ
; ��3�����ñ���ɫ
; ��4�����Ϲ���һ��
; 
; ��ڲ�����˵�����£�
; ah - ���ݹ��ܺţ�0 - ������1 - ����ǰ��ɫ�� 2 - ���ñ���ɫ��3 - ���Ϲ���һ��
; al - ������ɫ{0 ~ 7}

; ��1������		���Դ��е�ǰ��Ļ�е��ַ�����Ϊ�ո��	
; ��2������ǰ��		���õ�ǰ�Դ��е�ǰ��Ļ�д��� ���ַ �������ֽڵ� �� 0,1,2 λ
; ��3�����ñ���ɫ	���õ�ǰ�Դ��е�ǰ��Ļ�д��� ���ַ �������ֽڵ� �� 4,5,6 λ
; ��4�����Ϲ���һ��	���ν���n+1�е����ݸ��Ƶ� n �д������һ��Ϊ��
; 

; ======================================================

; ���򣺿��԰������ñ�ŵ�ʹ�ÿ����� C/C++ �е�����

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

	;	mov ah, 0
	;	call set_screen

		mov ah, 1
		mov al, 00000110B
		call set_screen

		mov ah, 2
		mov al, 00100000B
		call set_screen

		mov ah, 3
		call set_screen

		mov ax, 4c00h
		int 21h

	; ---------------------------------------------
	; ����Щ���ó������ӳ������ڵ�ַ������һ�����У������ڱ��еĹ��ܺ�λ�����Ӧ��
	; ��Ӧ��ϵΪ�����ܺ� * 2 = ��Ӧ�Ĺ����ӳ����ڵ�ַ���е�ƫ��
	set_screen:	jmp _setScreen
		
			table	dw	clear_screen, set_font, set_background, up_row

	_setScreen:	push bx

			cmp ah, 3
			ja _retSet
			mov bl, ah
			mov bh, 0
			add bx, bx	; ���� ah �еĹ��ܺż�������Ӧ�ӳ����� table ���е�ƫ��

			call word ptr table[bx]

	_retSet:	pop bx
			ret
		

			
	; ---------------------------------------------
	; ��1������		���Դ��е�ǰ��Ļ�е��ַ�����Ϊ�ո��
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
	; ��2������ǰ��		���õ�ǰ�Դ��е�ǰ��Ļ�д��� ���ַ �������ֽڵ� �� 0,1,2 λ
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
	;��3�����ñ���ɫ	���õ�ǰ�Դ��е�ǰ��Ļ�д��� ���ַ �������ֽڵ� �� 4,5,6 λ
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
	; ��4�����Ϲ���һ��	���ν���n+1�е����ݸ��Ƶ� n �д������һ��Ϊ��
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

			cld	; ������
			rep movsw

			; ���һ�����
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


codesg ends
end start
