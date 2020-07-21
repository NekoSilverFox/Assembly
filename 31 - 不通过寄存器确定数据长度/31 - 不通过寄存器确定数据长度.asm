; 31 - 不通过寄存器确定数据长度
; =================================================================
;				 word ptr 代表字型数据
;				 byte ptr 代表字节型数据
; =================================================================

assume cs:codesg, ds:datasg

datasg segment
				dw 0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH,0FFFFH
datasg ends

codesg segment
start:			mov ax, datasg
				mov ds, ax
				
				mov word ptr ds:[0], 1		; word ptr 代表字型数据
				mov byte ptr ds:[2], 2		; byte ptr 代表字节型数据
				
				inc word ptr ds:[0]
				inc byte ptr ds:[2]
codesg ends

end start