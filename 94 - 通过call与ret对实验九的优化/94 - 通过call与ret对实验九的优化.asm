; 94 - 通过call与ret对实验九的优化
; =================================================================

; 77 - 向屏幕输出彩色内容【实验9 - 方法三】 
; =================================================================
; 要求: 在屏幕中间分别显示绿色、绿底红色、白底蓝色字符串“welcome to masm!”
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
main:		mov ax, stacksg		; <<===== 注意：call要用到栈所以要提前设置好栈段，不能放在set_reg里了，否则会导致程序出错
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



