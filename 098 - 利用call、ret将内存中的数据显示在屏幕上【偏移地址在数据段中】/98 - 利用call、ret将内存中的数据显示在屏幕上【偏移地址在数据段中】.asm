; 98 - ����call��ret���ڴ��е�������ʾ����Ļ�ϡ�ƫ�Ƶ�ַ�����ݶ��С�
; =================================================================
; 1. ����һ��
;		���һ�����򣬳�������ַ�����0��β��������ʾ����Ļ��
;
; 2. �����
;		����Ļ����ʾ4���ַ�����ÿһ�ж�Ҫ����
; =================================================================










; 				��������Ϊ�޸Ĵ���












assume cs:codesg, ds:datasg, ss:stacksg

; =================================================================

datasg segment
		db '1) restart pc ', 0		; ��������jczx�жϣ�cx == 0 ʱ�˳���ת
		db '2) start system ', 0
		db '3) show clock ', 0
		db '4) set clock ', 0
		
		dw 0, 0FH, 20H, 2FH		; <<=== Ϊʲô��dw����Ϊһ������ļĴ���Ϊ16λ�Ĵ���
datasg ends

; =================================================================

stacksg segment
		db 128 dup (0)
stacksg ends

; =================================================================

codesg segment
main:		mov ax, stacksg
		mov ss, ax	; !!!!!!��ס��������ջ�Σ���ΪcallҪ�õ�ջ
		mov sp, 128


		call set_reg

		call show_option


		mov ax, 4c00h
		int 21H

	; ------------------------------------
	set_reg:	mov ax, 0B800H
			mov es, ax
		
			mov ax, datasg
			mov ds, ax

			
			mov cx, 4
			mov bx, 3CH
			mov di, 0
			mov si, 160 * 10 + 64
			ret
	; ------------------------------------
	show_option:	mov di, ds:[bx + 0]
			call show_string
			add bx, 2
			add si, 160
			loop show_option
			
			ret

	; ------------------------------------
	show_string:	push cx
			push bx
			push ds
			push es
			push si
			push di
			
			mov ch, 0
	showString:	mov cl, ds:[di]
			jcxz show_str_ret
			inc di
			mov es:[si], cl
			add si, 2
			jmp showString
	show_str_ret:	pop di
			pop si
			pop es
			pop ds
			pop bx
			pop cx
			ret

codesg ends
end main

; =================================================================;



