; 245 - ��16������ʽ����Ļ�м���ʾ�������ֽ�������
; ======================================================

; P291

; ======================================================
assume cs:codesg

codesg segment

	start:	mov al, 0ABH
		call showbyte

		mov ax, 4c00h
		int 21h

	; ---------------------------------------------
	showbyte:	jmp short show

			table db '0123456789ABCDEF'	; �ַ���

	show:		push ax
			push bx
			push es

			mov ah, al
			shr ah, 1
			shr ah, 1
			shr ah, 1
			shr ah, 1		; ����4λ��ah�еõ���4λ��ֵ
			and al, 00001111B	; al ��Ϊ�� 4 λ��ֵ

			mov bl, ah
			mov bh, 0
			mov ah, table[bx]	; �ø� 4 λ��ֵ��Ϊ����� table ��ƫ�ƣ�ȡ�����Ӧ���ַ�

			mov bl, al
			mov bh, 0
			mov al, table[bx]	; �õ� 4 λ��ֵ��Ϊ����� table ��ƫ�ƣ�ȡ�����Ӧ���ַ�
		
			mov bx, 0B800H
			mov es, bx
			
			mov byte ptr es:[160 * 12 + 40 * 2 + 0], ah
			mov byte ptr es:[160 * 12 + 40 * 2 + 1], 00000111B
			mov byte ptr es:[160 * 12 + 40 * 2 + 2], al
			mov byte ptr es:[160 * 12 + 40 * 2 + 3], 00000111B
			
			pop es
			pop bx
			pop ax

			ret

codesg ends
end start
