; 182 - ��int 7ch�ж�����ʵ��loopָ��Ĺ��ܡ��ж����̡�
; =================================================================

; 182 - ��int 7ch�ж�����ʵ��loopָ��Ĺ��ܡ��ж����̡�

; ����˵������� P256
; ����Ļ�м���ʾ80��"!"��ʹ��int 7ch����loop

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

		; capital ��װ����
		call local_sqr

		; �����ն�������
		call set_IVT

		mov ax, 0B800H
		mov es, ax
		mov di, 160*12

		mov bx, OFFSET s - OFFSET se	; Ϊʲô�� s - se�� ����һ�£��������Ǹ������ں�����������ת��sʱ��Ϳ� add һ���������൱�ڼ���
		mov cx, 80

	s:	mov byte ptr es:[di + 0], '!'
		mov byte ptr es:[di + 1], 00000111B
		add di, 2
		int 7ch				; ʹ�� int 7ch ���棨ʵ�֣�loopָ��
	se:	nop		


		mov ax, 4C00H
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
				mov si, OFFSET my_loop

				mov ax, 0
				mov es, ax
				mov di, 200H

				mov cx, OFFSET _endMyLoop - OFFSET my_loop
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
		; ���ܣ�ʵ��loop����
		my_loop:	push bp		; �ݴ�bp
				mov bp, sp	; (sp) = int 7ch ����һ��ָ���IP
				dec cx
				jcxz _iretMyLoop
				add ss:[bp + 2], bx	; ��ϰ��bp��ss�����, ������bx��ָ���λ�ƣ������Ժ� ss:[bp + 2] ָ���� s
		_iretMyLoop:	pop bp		; �����ݴ�� bp����ջ���ָ���ָ��(sp) = int 7ch ����һ��ָ���IP
				iret
		_endMyLoop:	nop
		
		

code ends

end start
