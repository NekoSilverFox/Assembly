; 187 - ��ʾ0��β���ַ�������ʵ������int 10h���ܡ��ж����̡�
; =================================================================

; ��д����װ�ж�7ch���ж�����,����Ϊ��ʾһ����0�������ַ������ж����̰�װ�� 0:200 ��

; ����˵������� P263
; ���ܣ���д����װ�ж�7ch���ж�����,����Ϊ��ʾһ����0�������ַ������ж����̰�װ�� 0:200 ��
; ������(dh)=�к�	(dl)=�к�	(cl)=��ɫ	ds:siָ���ַ����׵�ַ
; Ӧ�þ���
; =================================================================

assume cs:code, ss:stack, ds:data
; =================================================================
data segment
		db 'Welcome to masm!', 0
data ends
; =================================================================
stack segment stack
		db	128 dup (0)
stack ends
; =================================================================
code segment
start:		mov ax, stack
		mov ss, ax
		mov sp, 128

		; ��װlocal_print_str
		call local_print_str


		; д���ж�������
		call set_IVT

		mov dh, 10
		mov dl, 10
		mov cl, 2
		mov ax, data
		mov ds, ax
		mov si, 0
		int 7ch

		mov ax, 4c00h
		int 21h


	
		; ---------------------------------------------------------------------------------------
		; ��װlocal_print_str
	local_print_str:push ax
			push cx
			push ds
			push es
			push di
			push si

			mov ax, cs
			mov ds, ax
			mov si, OFFSET print_str

			mov ax, 0
			mov es, ax
			mov di, 200H
			mov cx, OFFSET _endPrintStr - OFFSET print_str
			cld
			rep movsb

			pop si
			pop di
			pop es
			pop ds
			pop cx
			pop ax
			ret

		; ---------------------------------------------------------------------------------------
		; д���ж�������
	set_IVT:	push ax
			push es

			mov ax, 0
			mov es, ax
			mov word ptr es:[7ch * 4 + 0], 200H	; IP
			mov word ptr es:[7ch * 4 + 2], 0	; CS
			
			pop es
			pop ax
			ret


		; ---------------------------------------------------------------------------------------
		; ��д����װ�ж�7ch���ж�����,����Ϊ��ʾһ����0�������ַ������ж����̰�װ�� 0:200 ��
		; ���ܣ���д����װ�ж�7ch���ж�����,����Ϊ��ʾһ����0�������ַ������ж����̰�װ�� 0:200 ��
		; ������(dh)=�к�	(dl)=�к�	(cl)=��ɫ	ds:siָ���ַ����׵�ַ
	print_str:	push ax
			push cx
			push ds
			push es
			push di
			push si

			mov ax, 0B800H
			mov es, ax
			mov ax, 0
			mov al, 160
			mul dh
			mov dh, 0
			add ax, dx
			mov di, ax
		
			mov ah, cl	; ��ɫת�浽 ah ��
			mov cx, 0

	_copyByte:	mov cl, ds:[si]
			jcxz _iretPrintStr
			mov es:[di + 0], cl
			mov es:[di + 1], ah
			inc si
			add di, 2
			jmp _copyByte

	_iretPrintStr:	pop si
			pop di
			pop es
			pop ds
			pop cx
			pop ax
			iret
			
	_endPrintStr:	nop
			

code ends

end start
