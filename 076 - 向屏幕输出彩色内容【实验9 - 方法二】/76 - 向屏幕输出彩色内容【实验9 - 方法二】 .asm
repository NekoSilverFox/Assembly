; 76 - ����Ļ�����ɫ���ݡ�ʵ��9 - �������� 

; =================================================================
; Ҫ��: ����Ļ�м�ֱ���ʾ��ɫ���̵׺�ɫ���׵���ɫ�ַ�����welcome to masm!��
; =================================================================

assume cs:codesg, ds:datasg, es:colorsg

; =================================================================

datasg segment
		dw 'w','e','l','c','o','m','e',' ','t','o',' ','m','a','s','m','!'
		dw 'w','e','l','c','o','m','e',' ','t','o',' ','m','a','s','m','!'
		dw 'w','e','l','c','o','m','e',' ','t','o',' ','m','a','s','m','!'
datasg ends

; =================================================================

colorsg segment
		db 00000010B, 10101100B, 01111001B
colorsg ends

; =================================================================

;stacksg segment
;		dw 48 dup (0)
;stacksg ends

; =================================================================

codesg segment

		; ���ݴ�������
start:		mov ax, datasg
		mov ds, ax

		mov ax, colorsg
		mov es, ax

		mov di, 1
		mov si, 0

		; �Ƚ�ds���еĸ�λ����������
		mov cx, 3

loop3:		mov dx, cx
		mov cx, 16
		mov ah, es:[si]

	loopRow:	mov ds:[di], ah
			add di, 2
			loop loopRow

		;dec dx
		inc si
		mov cx, dx
		loop loop3

; ====================================================================

		; �����ִ�������
		mov di, 0

		; ���ݵ�����ȥ
		mov ax, 0B800H
		mov es, ax
 		mov bx, 160 * 12 + 64

		mov cx, 3

mov3:		mov dx, cx
		mov cx, 16

	movRow:		mov ax, ds:[di]
			mov es:[bx], ax
			add di, 2
			add bx, 2
			loop movRow
		
		;dec dx
		mov cx, dx
		add bx, 160 - 32	
		loop mov3
		
		mov ax, 4c00h
		int 21h


codesg ends

end start

