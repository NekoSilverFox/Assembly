; 246 - 计算sin(x)，使用直接定址表
; ======================================================

; 编写一个子程序，计算 sin(x) = {0,30,60,90,120,150,180}
; 并在屏幕中间显示计算结果。比如 sin(30)显示为“0.5”

; ======================================================

; 感悟：可以把这种用标号的使用看做成 C/C++ 中的数组

; ======================================================
assume cs:codesg
; ======================================================

; ======================================================
codesg segment
start:		mov ax, 0
		mov al, 120
		
		call sin


		mov ax, 4c00h
		int 21h

			
	; ---------------------------------------------
	sin:	jmp _show     ; 01    23    45    67     89     1011   1012
		table	dw	ag0, ag30, ag60, ag90, ag120, ag150, ag180	; 字符串偏移地址表
		ag0	db	'0', 0
		ag30	db	'0.5', 0
		ag60	db	'0.866', 0
		ag90	db	'1', 0
		ag120	db	'0.866', 0
		ag150	db	'0.5', 0
		ag180	db	'0', 0

	_show:	push bx
		push es
		push si

		mov bx ,0B800H
		mov es, bx

		; 用 角度/30 作为相对于 table 的偏移，取得对应字符串的偏移地址，放在 bx 中
		mov ah, 0
		mov bl, 30
		div bl

		; 判断部分，如果是奇奇怪怪的角度直接退出
		cmp ah, 0
		jne _retShow

		mov bl, al
		mov bh, 0
		add bx, bx		; 因为是 dw 类型的所以要 乘以2，一个偏移地址占 2 个字节
		mov bx, table[bx]

		; 以下显示 sin(x) 对应字符串
		mov si, 160 * 12 + 40 * 2
	_shows:	mov ah, cs:[bx]
		cmp ah, 0
		je _retShow
		mov byte ptr es:[si + 0], ah
		mov byte ptr es:[si + 1], 00001111B
		inc bx
		add si, 2
		jmp short _shows
	_retShow: pop si
		pop es
		pop bx
		ret
codesg ends
end start
