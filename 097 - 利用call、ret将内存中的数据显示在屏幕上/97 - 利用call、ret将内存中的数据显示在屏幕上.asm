; 97 - ����call��ret���ڴ��е�������ʾ����Ļ��
; =================================================================
; 1. ����һ��
;		���һ�����򣬳�������ַ�����0��β��������ʾ����Ļ��
;
; 2. �����
;		����Ļ����ʾ4���ַ�����ÿһ�ж�Ҫ����
; =================================================================
assume cs:codesg, ds:datasg, ss:stacksg

; =================================================================

datasg segment
		db '1) restart pc ', 0		; ��������jczx�жϣ�cx == 0 ʱ�˳���ת
		db '2) start system ', 0
		db '3) show clock ', 0
		db '4) set clock ', 0
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
			mov si, 160 * 10 + 64
			mov di, 0
		call show_string

			mov si, 160 * 11 + 64
			mov di, 0FH
		call show_string

			mov si, 160 * 12 + 64
			mov di, 20H
		call show_string

			mov si, 160 * 13 + 64
			mov di, 2FH
		call show_string

		mov ax, 4c00h
		int 21H

	; ------------------------------------
	set_reg:	mov ax, 0B800H
			mov es, ax
		
			mov ax, datasg
			mov ds, ax
			ret
	; ------------------------------------
	show_string:	mov ch, 0
			mov cl, ds:[di]
			jcxz show_str_ret
			inc di
			mov es:[si], cl
			add si, 2
			jmp show_string
	show_str_ret:	ret

codesg ends
end main

; =================================================================;



