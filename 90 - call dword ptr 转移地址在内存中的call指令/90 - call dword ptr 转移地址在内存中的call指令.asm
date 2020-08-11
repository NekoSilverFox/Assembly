; 89 - call dword ptr 转移地址在内存中的call指令
; =================================================================
; 转移地址在 “内存” 中的call指令有两种		==》 在内存中其实就是在ds段中



; 1. call word ptr 内存单元地址
; 	push ip
;	jmp word ptr 内存单元地址



; 2. call dword ptr 内存单元地址
; 	push CS
; 	push ip
;	jmp dword ptr 内存单元地址

; ===============================================================

assume cs:codesg

; =================================================================

codesg segment
start:		mov sp, 10h
		mov ax, 0123H
		mov ds:[0], ax
		mov ax, 6789H
		mov ds:[2], ax

		call dword ptr ds:[0]	; ==>> 执行后ip == 0123h, cs == 6789H

		mov ax, 4c00h
		int 21h
codesg ends
; =================================================================
end start

