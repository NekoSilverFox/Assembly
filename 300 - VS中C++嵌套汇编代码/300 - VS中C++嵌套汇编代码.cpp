#include <iostream>

int main()
{
	int a, b, c;	// �������

	_asm
	{
		mov a, 3		// 3��ֵ����a��Ӧ�ڴ浥Ԫ��λ��
		mov b, 4		// 4��ֵ����a��Ӧ�ڴ浥Ԫ��λ��
		mov eax, a	// ��a�ڴ浥Ԫ�е�ֵ���� ax �Ĵ���
		add eax , b
		mov c, eax		// eax ��32λ�Ĵ����� rax��64λ�Ĵ���
	}

	std::cout << c << std::endl;

	return 0;
}