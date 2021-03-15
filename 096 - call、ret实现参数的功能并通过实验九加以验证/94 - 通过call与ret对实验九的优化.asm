; 96 - 通过call与ret对实验九的优化
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
		db 'xxxxxxxxxxxxxxxx'
		db 'AAAAAAAAAAAAAAAA'
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
			mov bx, 160 * 11 + 64		; <-- 实现参数的效果
			mov cx, 3
			mov si, 0
			mov di, 16
		call mov_data

		call set_reg
			mov bx, 160 * 5 + 64		; <-- 实现参数的效果
			mov cx, 1
			mov si, 19
			mov di, 17
		call mov_data

		call set_reg
			mov bx, 160 * 18 + 64		; <-- 实现参数的效果
			mov cx, 1
			mov si, 35
			mov di, 18
		call mov_data

		mov ax, 4c00h
		int 21h

	; ------------------------------------------
	set_reg:	mov ax, datasg
			mov ds, ax
			mov ax, 0B800H
			mov es, ax	
			ret


	; ------------------------------------------
	mov_data:	; where data go

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



