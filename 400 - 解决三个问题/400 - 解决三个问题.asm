; 400 - �����������
; ======================================================

; 

; ADD EAX, [EBX+4*ECX+4] �Ļ�������ʲô
; 0202H ��Ӧ��ָ����ʲô
; ִ��ָ��SAR, SHR, ROR ��A00Ah�£��ᷢ��ʲô
; 

; ======================================================

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

		call q2

		call q3

		mov ax, 4c00h
		int 21h

	; =========================================
	; q2
	q2:	push ax
		push es
		push di

		mov ax, cs
		mov es, ax
		mov di, OFFSET _change
				
		mov es:[di], 0202H
		
	_change:nop
		nop

		pop di
		pop es
		pop ax
		ret


	; =========================================
	; q3
	q3:	push ax

		mov ch, 0

		pushf
		mov ax, 0A00Ah
		mov cl, 2
		SAR ax, cl
		popf
		

		pushf
		mov ax, 0A00Ah
		mov cl, 2
		SHR ax, cl
		popf


		pushf
		mov ax, 0A00Ah
		mov cl, 2
		ROR ax, cl
		popf

		pop ax
		ret
		
codesg ends
end start
