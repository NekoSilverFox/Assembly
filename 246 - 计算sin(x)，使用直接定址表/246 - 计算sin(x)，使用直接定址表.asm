; 246 - ����sin(x)��ʹ��ֱ�Ӷ�ַ��
; ======================================================

; ��дһ���ӳ��򣬼��� sin(x) = {0,30,60,90,120,150,180}
; ������Ļ�м���ʾ������������ sin(30)��ʾΪ��0.5��

; ======================================================

; ���򣺿��԰������ñ�ŵ�ʹ�ÿ����� C/C++ �е�����

; ======================================================
assume cs:codesg
; ======================================================

; ======================================================
codesg segment
start:		mov ax, 0
		mov al, 120
		
		call sin


		mov ax, 4c00h
		int 21h

			
	; ---------------------------------------------
	sin:	jmp _show     ; 01    23    45    67     89     1011   1012
		table	dw	ag0, ag30, ag60, ag90, ag120, ag150, ag180	; �ַ���ƫ�Ƶ�ַ��
		ag0	db	'0', 0
		ag30	db	'0.5', 0
		ag60	db	'0.866', 0
		ag90	db	'1', 0
		ag120	db	'0.866', 0
		ag150	db	'0.5', 0
		ag180	db	'0', 0

	_show:	push bx
		push es
		push si

		mov bx ,0B800H
		mov es, bx

		; �� �Ƕ�/30 ��Ϊ����� table ��ƫ�ƣ�ȡ�ö�Ӧ�ַ�����ƫ�Ƶ�ַ������ bx ��
		mov ah, 0
		mov bl, 30
		div bl

		; �жϲ��֣����������ֵֹĽǶ�ֱ���˳�
		cmp ah, 0
		jne _retShow

		mov bl, al
		mov bh, 0
		add bx, bx		; ��Ϊ�� dw ���͵�����Ҫ ����2��һ��ƫ�Ƶ�ַռ 2 ���ֽ�
		mov bx, table[bx]

		; ������ʾ sin(x) ��Ӧ�ַ���
		mov si, 160 * 12 + 40 * 2
	_shows:	mov ah, cs:[bx]
		cmp ah, 0
		je _retShow
		mov byte ptr es:[si + 0], ah
		mov byte ptr es:[si + 1], 00001111B
		inc bx
		add si, 2
		jmp short _shows
	_retShow: pop si
		pop es
		pop bx
		ret
codesg ends
end start
