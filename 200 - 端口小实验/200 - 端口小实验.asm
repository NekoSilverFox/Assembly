; 200 - �˿�Сʵ��
; ===========================================
assume cs:codesg

codesg segment
start:		in al, 20h	; �� 20h �˿ڶ�ȡһ���ֽ�
		out 20h, al	; �� 20h �˿�д��һ���ֽ�

	;	in bl, 20h	ERROR

	;	in al, 3f8h	ERROR
		mov dx, 3f8h
		in al, dx
		out dx, al
codesg ends
end start
