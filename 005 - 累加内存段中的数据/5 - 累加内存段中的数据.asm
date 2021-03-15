; 5 - 累加内存段中的数据
; p 指令 直接跳过loop指令
; g 指令 可以认为是（go）到哪个地址

; 题目： 求 FFFF:0 到 FFFF:F 字节型数据的和，结果放到 dx 中

assume cs:codesg

codesg segment

			mov ax, 0FFFFH
			mov ds, ax
			mov ax, 0 		;因为之后需要用到ax寄存器进行累加，所以此处要归零
			mov bx, 0 		;注意初始化！
			mov cx, 16
			mov dx, 0

addNumber:	mov al, ds:[bx]
			add dx, ax
			inc bx
			loop addNumber

codesg ends

end