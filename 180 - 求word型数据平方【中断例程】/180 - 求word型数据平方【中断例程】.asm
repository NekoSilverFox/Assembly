; 180 - ��word������ƽ�����ж����̡�
; =================================================================

; ��д����װ�ж�7ch���ж�����

; ����˵������� P253
; ���ܣ���һword�����ݵ�ƽ��
; ������(ax)=Ҫ���������
; ����ֵ��dx, ax�д�Ž���ĸ�16λ�͵�16λ
; Ӧ�þ�����2*3456^2

; =================================================================
assume cs:code, ss:stack
; =================================================================

; =================================================================
stack segment stack
		db	128 dup (0)
stack ends
; =================================================================
code segment
start:		mov ax, stack
		mov ss, ax
		mov sp, 128

		; sqr��װ����
		call local_sqr

		; �����ն�������
		call set_IVT

		mov ax, 3456
		int 7ch

		add ax, ax
		adc dx, dx	; <==== ע����adc����ΪҪ��λ

		mov ax, 4C00H
		int 21H



		; -------------------------------
		; ��װsqr
		local_sqr:	push ax
				push ds
				push es
				push di
				push si

				mov ax, cs
				mov ds, ax
				mov si, OFFSET sqr

				mov ax, 0
				mov es, ax
				mov di, 200H

				mov cx, OFFSET _retSqr - OFFSET sqr	; ����ѭ������Ϊ sqr���򳤶�
				cld		; ����Ϊ����
	
				rep movsb
	
				pop si
				pop di
				pop es
				pop ds
				pop ax
				ret


		; -------------------------------
		; �����ն�������
		set_IVT:	push ax
				push es

				mov ax, 0
				mov es, ax
				mov word ptr es:[7ch * 4 + 0], 0200H	; IP	���ң�ע���� *4
				mov word ptr es:[7ch * 4 + 2], 0000H	; CS

				pop es
				pop ax
				ret


		; -------------------------------
		; ���ܣ���һword�����ݵ�ƽ��
		; ������(ax)=Ҫ���������
		; ����ֵ��dx, ax�д�Ž���ĸ�16λ�͵�16λ
		sqr:		mul ax
				iret		; <--- ʹ�� iret ��˳��ʵ�� popf
		_retSqr:	nop	; <<==== Ҫָ���������һ���ֽڣ�������
		

code ends

end start
