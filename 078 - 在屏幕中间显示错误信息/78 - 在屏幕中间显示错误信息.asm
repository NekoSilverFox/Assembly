; 78 - ����Ļ�м���ʾ������Ϣ
; =================================================================

; ��дһ���ӳ��򣬽����������ַ�����0��β���ַ����е�Сд��ĸת��Ϊ��д��ĸ

; ���ƣ�letterc
; ���ܣ�����0��β���ַ����е�Сд��ĸת��Ϊ��д��ĸ
; ������ds:si ָ���ַ����׵�ַ
; 
; =================================================================
assume cs:code, ss:stack, ds:data
; =================================================================
data segment
		db	'overflow!'
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


		mov ax, data
		mov ds, ax
		mov si, 0 
		
		; -------------------------------
		; ����Ļ�м���ʾoverflow��
		; ���룺ds:si ָ���ַ�����һ������
		; 
		show_error:	push ax
				push cx
				push ds
				push es
				push di
				push si

				mov ax, 0B800H
				mov es, ax
				mov di, 160 * 11 + 40 * 2
				
				mov cx, 9

			_showError:	mov al, ds:[si]
					mov es:[di + 0], al
					mov byte ptr es:[di + 1], 11001111B
					add di, 2
					inc si
					loop _showError

				pop si
				pop di
				pop es
				pop ds
				pop cx
				pop ax
			_ret:	ret
		

code ends

end start
