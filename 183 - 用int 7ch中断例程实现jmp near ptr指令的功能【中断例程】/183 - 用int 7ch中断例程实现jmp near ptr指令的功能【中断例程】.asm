; 183 - ��int 7ch�ж�����ʵ��jmp near ptrָ��Ĺ��ܡ��ж����̡�
; =================================================================

; ��int 7ch�ж�����ʵ��jmp near ptrָ��Ĺ��ܣ���bx���ж����̴���ת��λ�ơ�
; Ӧ�þ���������Ļ�ĵ�12�У���ʾdata������0��β���ַ���
; ����˵������� P257
; 

; =================================================================
assume cs:code, ss:stack, ds:data
; =================================================================
data segment
		db	'conversation', 0
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

		; capital ��װ����
		call local_sqr

		; �����ն�������
		call set_IVT

		mov ax, data
		mov ds, ax
		mov si, 0

		mov ax, 0B800H
		mov es, ax
		mov di, 160 * 12

	s:	cmp byte ptr ds:[si], 0		; �Ƚ���0�Ĺ�ϵ
		je _exit			; �����0������˳�	�����µ��˳�����������
		mov al, ds:[si]
		mov es:[di + 0], al
		mov byte ptr es:[di + 1], 00000011B
		inc si
		add di, 2
		mov bx, OFFSET s - OFFSET se		; ע�⣬�� s - se ���õ����Ǹ���
		int 7ch
	se:	nop

	_exit:	mov ax, 4C00H
		int 21H



		; -------------------------------
		; ��װmy_loop
		local_sqr:	push ax
				push cx
				push ds
				push es
				push di
				push si

				mov ax, cs
				mov ds, ax
				mov si, OFFSET jmp_near_ptr

				mov ax, 0
				mov es, ax
				mov di, 200H

				mov cx, OFFSET _endJmpNearPtr - OFFSET jmp_near_ptr
				cld		; ����Ϊ������
				rep movsb

				pop si
				pop di
				pop es
				pop ds
				pop cx
				pop ax
				ret


		; -------------------------------
		; �����ն�������
		set_IVT:	push ax
				push es
				mov ax, 0
				mov es, ax
				mov word ptr es:[7ch * 4 + 0], 0200H	; IP
				mov word ptr es:[7ch * 4 + 2], 0000H	; CS
				pop es
				pop ax
				ret


		; -------------------------------
		; ���ܣ�ʵ��loop����					��ջ�У� ��־�Ĵ��� cs ip 
		jmp_near_ptr:	pop bp
				add bp, bx
				push bp
				iret
		_endJmpNearPtr:	nop
		
		

code ends

end start
