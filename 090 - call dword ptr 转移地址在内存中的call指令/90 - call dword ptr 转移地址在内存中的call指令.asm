; 89 - call dword ptr ת�Ƶ�ַ���ڴ��е�callָ��
; =================================================================
; ת�Ƶ�ַ�� ���ڴ桱 �е�callָ��������		==�� ���ڴ�����ʵ������ds����



; 1. call word ptr �ڴ浥Ԫ��ַ
; 	push ip
;	jmp word ptr �ڴ浥Ԫ��ַ



; 2. call dword ptr �ڴ浥Ԫ��ַ
; 	push CS
; 	push ip
;	jmp dword ptr �ڴ浥Ԫ��ַ

; ===============================================================

assume cs:codesg

; =================================================================

codesg segment
start:		mov sp, 10h
		mov ax, 0123H
		mov ds:[0], ax
		mov ax, 6789H
		mov ds:[2], ax

		call dword ptr ds:[0]	; ==>> ִ�к�ip == 0123h, cs == 6789H

		mov ax, 4c00h
		int 21h
codesg ends
; =================================================================
end start

