; 7 - 字型数据和栈对程序6的优化
; ===================================================================
; 编程技巧：
;			ds寄存器 --> 数据从哪里来
;			es寄存器 --> 数据到哪里去（es也是一个数据寄存器）
; ===================================================================
; 题目：将 FFFF:0 ~ FFFF:F 内存单元中的内容拷贝到 0:200 ~ 0:20F中

assume cs:codesg

codesg segment
		mov ax, 0FFFFH	; 设置 ds寄存器 --> 数据从哪里来
		mov ds, ax

		mov ax, 20H		; 设置 es 寄存器 --> 数据到哪里去
		mov es, ax

		mov ax, 0 		; 进行清零及初始化
		mov bx, 0
		mov cx, 8		; 别忘了对 cx 进行初始化

; 方法一：
;cpData:	mov ax, ds:[bx]
;		mov es:[bx], ax
;		add bx, 2
;		loop cpData

; 方法二：
cpData:	push ds:[bx]
		pop es:[bx]
		add bx, 2
		loop cpData

codesg ends

end