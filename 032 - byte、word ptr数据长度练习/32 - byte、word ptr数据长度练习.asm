; 32 - byte、word ptr数据长度练习
; =================================================================

assume cs:codesg, ds:datasg, ss:stacksg

stacksg segment
				dw 0,0,0,0
				dw 0,0,0,0
				dw 0,0,0,0
				dw 0,0,0,0
stacksg ends

datasg segment
				db 'DEC'		; 公司名
				db 'Ken Olsen'	; 总裁名
				dw 137			; 排名 ==> 38
				dw 40			; 收入 ==> +70
				db 'PDP'		; 著名产品 ==> ‘VAX’
datasg ends

;===================================

codesg segment
start:			mov ax, stacksg
				mov ss, ax
				mov sp, 32

				mov ax, datasg
				mov ds, ax

				mov bx, 0
				mov si, 0

				mov word ptr ds:[bx + 12 + si], 38

				add si, 2
				add word ptr ds:[bx + 12 + si], 70


				add si, 2
				mov byte ptr ds:[bx + 12 + si], 'V'

				inc si
				mov byte ptr ds:[bx + 12 + si], 'A'

				inc si
				mov byte ptr ds:[bx + 12 +si], 'X'
codesg ends

end start