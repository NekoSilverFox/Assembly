; 260 - �����û���������
; ======================================================

; P303

; �����û��������룬���롰r��������Ļ�ϵ��ַ�����Ϊ��ɫ�����롰g��������Ļ�ϵ��ַ�����Ϊ��ɫ�����롰b��������Ļ�ϵ��ַ�����Ϊ��ɫ

; ======================================================

; ���ܱ�ţ�0��ah��ȡ��
; 
; mov ah, 0
; int 16h
; ��ȡ�� ɨ�������� ah��ASCII������ al
; ======================================================
assume cs:codesg, ss:stacksg
; ======================================================
stacksg segment stack
	db 128 dup (0)
stacksg ends
; ======================================================
codesg segment
start:		mov ax, stacksg
		mov ss, ax
		mov sp, 128

		mov ah, 0
		int 16h

		mov ah, 1
		cmp al, 'r'
		je red

		cmp al, 'g'
		je green

		cmp al, 'b'
		je blue

		jmp _ret

	red:	shl ah, 1
	green:	shl ah, 1
	blue:	mov bx, 0b800H
		mov es, bx
		mov bx, 1
		mov cx, 2000

	s:	and byte ptr es:[bx], 11110000B		; ����λ�ֽڣ�ǰ�����ԣ�ȫ��Ϊ0
		or es:[bx], ah
		add bx, 2
		loop s

	_ret:	mov ax, 4c00h
		int 21h
		
		; =============================================
		; Ч������Ϊint 16h�ĵط��Ǵӻ�������ȡ�������������Ӧ�ַ��Ժ�Ż�Ż�ִ��
		; �������һֱ���ڵȴ�״̬

codesg ends
end start
