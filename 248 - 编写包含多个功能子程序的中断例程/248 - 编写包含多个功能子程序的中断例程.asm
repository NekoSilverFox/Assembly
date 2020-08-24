; 248 - ��д������������ӳ�����ж�����
; ======================================================

; ��װһ���µ� int 7ch �ж����̣�Ϊ��ʾ����ṩ���¹��ܵ��ӳ���

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

		; �������ݵ��ж���������
		call install_int7ch

		call set_IVT



		mov ah, 1
		mov al, 00000110B
		int 7ch

		mov ah, 2
		mov al, 00100000B
		int 7ch

		mov ah, 3
		int 7ch

		mov ax, 4c00h
		int 21h



	; ---------------------------------------------
	set_IVT:	push ax
			push es

			mov ax, 0
			mov es, ax
			
			cli			
			mov word ptr es:[7ch * 4 + 0], 200H	; IP
			mov word ptr es:[7ch * 4 + 2], 0H	; CS
			sti

			pop es
			pop ax

			ret

	; ---------------------------------------------
	install_int7ch:	push ax
			push cx
			push ds
			push es
			push di
			push si

			mov ax, 0
			mov es, ax
			mov di, 200H

			mov ax, cs
			mov ds, ax
			mov si, OFFSET int_set_screen

			mov cx, OFFSET _endSet - OFFSET int_set_screen
			cld
			rep movsb
			
			pop si
			pop di
			pop es
			pop ds
			pop cx
			pop ax
			ret

	; ---------------------------------------------
	; ����Щ���ó������ӳ������ڵ�ַ������һ�����У������ڱ��еĹ��ܺ�λ�����Ӧ��
	; ��Ӧ��ϵΪ�����ܺ� * 2 = ��Ӧ�Ĺ����ӳ����ڵ�ַ���е�ƫ��
	int_set_screen:	jmp _setScreen
		
			table	dW	OFFSET clear_screen - OFFSET int_set_screen + 200H
				dw	OFFSET set_font - OFFSET int_set_screen + 200H
				dw	OFFSET set_background - OFFSET int_set_screen + 200H		; ����������������ط����ص㣡����������
				dw	OFFSET up_row - OFFSET int_set_screen + 200H

	_setScreen:	push ax
			push bx
			push es

			cmp ah, 3
			ja _retSet

			mov bx, 0
			mov es, bx

			mov bl, ah
			mov bh, 0
			add bx, bx	; ���� ah �еĹ��ܺż�������Ӧ�ӳ����� table ���е� �ε�ַ + ƫ�Ƶ�ַ
			add bx, OFFSET table - OFFSET int_set_screen + 200H

			call word ptr es:[bx]

	_retSet:	pop es
			pop bx
			pop ax
			iret


		

			
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


	_endSet:	nop

codesg ends
end start
