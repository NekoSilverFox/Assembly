#include <iostream>

int main()
{
	int a, b, c;	// 定义变量

	_asm
	{
		mov a, 3		// 3的值放在a对应内存单元的位置
		mov b, 4		// 4的值放在a对应内存单元的位置
		mov eax, a	// 把a内存单元中的值放在 ax 寄存器
		add eax , b
		mov c, eax		// eax 是32位寄存器， rax是64位寄存器
	}

	std::cout << c << std::endl;

	return 0;
}