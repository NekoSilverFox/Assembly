; 94 - ͨ��call��ret��ʵ��ŵ��Ż�
; =================================================================

; 77 - ����Ļ�����ɫ���ݡ�ʵ��9 - �������� 
; =================================================================
; Ҫ��: ����Ļ�м�ֱ���ʾ��ɫ���̵׺�ɫ���׵���ɫ�ַ�����welcome to masm!��
; ===============================================================
assume cs:codesg, ds:datasg, ss:stacksg

; =================================================================

datasg segment
		db 'welcome to masm!'
		db 00000010B, 10100100B, 01110001B
datasg ends

; =================================================================

stacksg segment
		dw 16 dup (0)
stacksg ends

; =================================================================

codesg segment
main:		mov ax, stacksg		; <<===== ע�⣺callҪ�õ�ջ����Ҫ��ǰ���ú�ջ�Σ����ܷ���set_reg���ˣ�����ᵼ�³������
		mov ss, ax
		mov sp, 32

		call set_reg
		call mov_data

		mov ax, 4c00h
		int 21h

	; ------------------------------------------
	set_reg:	mov ax, datasg
			mov ds, ax	
			ret


	; ------------------------------------------
	mov_data:	; where data go
			mov ax, 0B800H
			mov es, ax
			mov bx, 160 * 11 + 64
		
			mov cx, 3
			mov si, 0
			mov di, 16

	setALL:		push cx	
			mov cx, 16
			mov ah, ds:[di]

	setRow:		mov al, ds:[si]
			inc si
			mov es:[bx], ax
			add bx, 2
			loop setRow

			add bx, 160 - 32
			mov si, 0
			inc di
			pop cx
			loop setALL

			ret

codesg ends
end main

; =================================================================;



