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
start:			mov ax, stack
				mov ss, ax
				mov sp, 32

				mov ax, data
				mov ds, ax

codesg ends

end start