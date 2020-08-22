; 201 - 读写 CMOS RAM
; ====================================================
; 在 CMOS RAM中
; 70h 为地址端口，存放要访问的CMOS RAM单元地址
; 71h 为数据端口，存放选定的CMOS RAM单元中读取、写入的数据
; 具体介绍请见 P266-267

; ====================================================
; 编程，读取 CMOS RAM 的2号单元的内容
; 编程，向 CMOS RAM 的2号单元写入0
; 
; ====================================================
assume cs:codesg

codesg segment
start:		mov al, 2
		out 70h, al
		in al, 71h

		mov al, 2
		out 70h, al
		mov al, 0
		out 71h, al
codesg ends
end start
