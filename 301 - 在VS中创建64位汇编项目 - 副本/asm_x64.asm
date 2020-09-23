; https://blog.csdn.net/Alisebeast/article/details/79875620 如何设置VS
		.code			;代码段      ！64 位没有 .model 宏指令，无法设置内存模型和生成的代码风格！
main proc				;main函数开始

0001B

	ret

main endp				;main函数结束
end
					;masm x64 没有指定入口点的宏指令！