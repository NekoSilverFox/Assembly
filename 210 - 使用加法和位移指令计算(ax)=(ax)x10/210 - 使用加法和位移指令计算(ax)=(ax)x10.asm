; 210 - ʹ�üӷ���λ��ָ�����(ax)=(ax)x10
; ====================================================

; ��ʾ��(ax)*10 = (ax)*2 + (ax)*8
; ====================================================
assume cs:codesg

codesg segment
start:		mov ax, 1
		shl ax, 1
		mov dx, ax

		mov ax ,1
		mov cl, 3	; ��λ�ƴ���1ʱ������ʹ��cl���б���λ��
		shl ax, cl

		add ax, dx

		mov ax, 4c00h
		int 21h
codesg ends
end start
