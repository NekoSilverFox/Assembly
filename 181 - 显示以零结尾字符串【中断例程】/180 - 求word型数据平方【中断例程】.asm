; 180 - ��word������ƽ�����ж����̡�
; =================================================================

; ��д����װ�ж�7ch���ж�����

; ����˵������� P254
; ���ܣ���һ��ȫ����ĸ�������β���ַ�����ת��Ϊ��д
; ������ds:si ָ���ַ������׵�ַ
; Ӧ�þ���

; =================================================================
assume cs:code, ss:stack, ds:data
; =================================================================
data segment
		db	'conversation',0
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
		
		int 7ch

		mov ax, 4C00H
		int 21H



		; -------------------------------
		; ��װcapital
		local_sqr:	push ax
				push cx
				push ds
				push es
				push di
				push si

				mov ax, cs
				mov ds, ax
				mov si, OFFSET capital

				mov ax, 0
				mov es, ax
				mov di, 200H

				mov cx, OFFSET _endCapital - OFFSET capital
				cld
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
		set_IVT:	
				mov ax, 0
				mov es, ax
				mov word ptr es:[7ch * 4 + 0], 0200H	; IP
				mov word ptr es:[7ch * 4 + 2], 0000H	; CS

				ret


		; -------------------------------
		; ���ܣ���һ��ȫ����ĸ�������β���ַ�����ת��Ϊ��д
		; ������ds:si ָ���ַ������׵�
		capital:	push ax
				push cx
				push si

				mov cx, 0

		_loopCapital:	mov cl, ds:[si]
				jcxz _iretCapital
				and cl, 11011111B
				mov ds:[si], cl
				inc si
				jmp _loopCapital



		_iretCapital:	pop si
				pop cx
				pop ax
				iret		; <--- ʹ�� iret ��˳��ʵ�� popf
		_endCapital:	nop	; <<==== Ҫָ���������һ���ֽڣ�������
		

code ends

end start
