; 21 - 用单引号在数据段中定义数据
; =================================================================

assume cs:codesg, ds:datasg

datasg segment
			db 'abcdEFGH'
			db '123'
datasg ends


codesg segment
start:		mov ax, datasg
			mov ds, ax
			
			mov al, 'b'
			mov ah, 'h'
codesg ends

end start