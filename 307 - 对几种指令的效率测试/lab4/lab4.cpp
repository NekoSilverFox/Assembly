#include <iostream>
#include <stdio.h>
#include <ctime>
#include <intrin.h>
#include <chrono>
#include <iomanip>

void printArray(int* arr)
{
	for (int i = 0; i < 10; ++i)
	{
		for (int j = 0; j < 10; ++j)
		{
			std::cout << arr[i * 10 + j] << " ";
		}
		std::cout << std::endl;
	}
}

#if 0
�� �����֧����� ��ڧ�� Pentium �ڧ���ݧ�٧����� ��ݧ֧է���ڧ� ������ҧ� �ѧէ�֧�ѧ�ڧ� :
	1. add ax, 12						���֧����֧է��ӧ֧ߧߧѧ� �ѧէ�֧�ѧ�ڧ�
	2. call proc							���ҧ��ݧ��ߧѧ� �ѧէ�֧�ѧ�ڧ�.
	3. add ax, bx						���֧ԧڧ����ӧѧ� �ѧէ�֧�ѧ�ڧ�.
	4. add ax, [bx]						�����ӧ֧ߧߧ� - ��֧ԧڧ����ӧѧ� �ѧէ�֧�ѧ�ڧ�.
	5. add ax, [bx + disp]			���ѧ٧�ӧѧ� �ѧէ�֧�ѧ�ڧ�(�ѧէ�֧�ѧ�ڧ� ��� �ҧѧ٧�)
	6. add ax, [bx + si]				���ѧ٧�ӧ� - �ڧߧէ֧ܧ�ߧѧ�
	7. add ax, [bx + si + disp]	���ѧ٧�ӧ� - �ڧߧէ֧ܧ�ߧѧ� ��� ��ާ֧�֧ߧڧ֧�
#endif

void commandASMTest()
{
	std::chrono::steady_clock::time_point t_start;
	std::chrono::steady_clock::time_point t_end;
	__int64 c_start;
	__int64 c_end;

	// ================== Empty ==================
	t_start = std::chrono::high_resolution_clock::now();
	c_start = __rdtsc();

	__asm
	{
		// Empty
	}

	t_end = std::chrono::high_resolution_clock::now();
	c_end = __rdtsc() - c_start;

	std::cout << "----- No commands -----" << std::endl
		<< "Ticks: " << c_end << std::endl
		<< "Time uesd: " << std::chrono::duration<double, std::milli>(t_end - t_start).count() << std::endl
		<< std::endl;

	// ================== add ch, cl ==================
	t_start = std::chrono::high_resolution_clock::now();
	c_start = __rdtsc();

	__asm
	{
		// ALL: 90 commands
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl // 10

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl // 20

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl // 30

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl  // 40

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl  // 50

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl  // 60

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl  // 70

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl // 80

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl

		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl
		add ch, cl // 90

	}
	t_end = std::chrono::high_resolution_clock::now();
	c_end = __rdtsc() - c_start;

	std::cout << "----- add ch, cl -----" << std::endl
		<< "Ticks: " << c_end << std::endl
		<< "Time uesd: " << std::chrono::duration<double, std::milli>(t_end - t_start).count() << std::endl
		<< std::endl;

	// ================== 3 Type commands ==================
	t_start = std::chrono::high_resolution_clock::now();
	c_start = __rdtsc();

	__asm
	{
		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 6

		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 12

		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 18

		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 24

		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 30

		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 36

		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 42

		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 48

		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 54

		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 60

		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 66

		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 72

		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 78

		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 84

		add ah, al
		add ch, al
		add dh, dl
		add ah, al
		add ch, al
		add dh, dl // 90
	}

	t_end = std::chrono::high_resolution_clock::now();
	c_end = __rdtsc() - c_start;

	std::cout << "----- 3 type ADD -----" << std::endl
		<< "Ticks: " << c_end << std::endl
		<< "Time uesd: " << std::chrono::duration<double, std::milli>(t_end - t_start).count() << std::endl
		<< std::endl;

	// ============= add edx, [ebx + 4 * esi + 8] =============
	t_start = std::chrono::high_resolution_clock::now();
	c_start = __rdtsc();

	__asm mov esi, 1
	__asm
	{
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8] // 10

		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8] // 20

		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8]
		add edx, [ebx + 4 * esi + 8] // 30
	}

	t_end = std::chrono::high_resolution_clock::now();
	c_end = __rdtsc() - c_start;

	std::cout << "----- add edx, [ebx + 4 * esi + 8] -----" << std::endl
		<< "Ticks: " << c_end << std::endl
		<< "Time uesd: " << std::chrono::duration<double, std::milli>(t_end - t_start).count() << std::endl
		<< std::endl;

	// ================== add eax, [ebx] ==================
	t_start = std::chrono::high_resolution_clock::now();
	c_start = __rdtsc();

	__asm
	{
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx] // 10

		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx] // 20

		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx]
		add eax, [ebx] // 30
	}

	t_end = std::chrono::high_resolution_clock::now();
	c_end = __rdtsc() - c_start;

	std::cout << "----- add eax, [ebx] -----" << std::endl
		<< "Ticks: " << c_end << std::endl
		<< "Time uesd: " << std::chrono::duration<double, std::milli>(t_end - t_start).count() << std::endl
		<< std::endl;

	// ================== add [ebx + esi], eax ==================
	t_start = std::chrono::high_resolution_clock::now();
	c_start = __rdtsc();

	__asm mov esi, 1
	__asm
	{
		add [ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax // 10

		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax
		add[ebx + esi], eax // 20
	}

	t_end = std::chrono::high_resolution_clock::now();
	c_end = __rdtsc() - c_start;

	std::cout << "----- add [ebx + esi], eax -----" << std::endl
		<< "Ticks: " << c_end << std::endl
		<< "Time uesd: " << std::chrono::duration<double, std::milli>(t_end - t_start).count() << std::endl
		<< std::endl;



	// ===========================================================
	int arr[10][10] = { 0 };
	std::cout << "-------------------------------------------" << std::endl
		<< "Original array:" << std::endl;
	printArray(arr[0]);

	int arr2[10] = { 1,1,1,1,1,1,1,1,1,1 };
	c_start = __rdtsc();
	__asm
	{
		cld
		mov ebx, 5
		lea edi, [arr + 40]

		_loop:
			lea esi, arr2
				mov ecx, 10
				rep movsd
				add edi, 40
				dec ebx
				cmp ebx, 0
				ja _loop
	}
	c_end = __rdtsc() - c_start;

	std::cout << std::endl
		<< "Ticks: " << c_end << std::endl
		<< "Use method (MOVSD):" << std::endl
		<< std::endl;
	printArray(arr[0]);
	std::cout	<< std::endl;

	// ===========================================================
	int arr3[10][10] = {};
	std::cout << "-------------------------------------------" << std::endl
		<< "Original array:" << std::endl;
	printArray(arr3[0]);
	c_start = __rdtsc();

	__asm
	{
		cld
		mov edx, 40
		mov ebx, 5
		mov eax, 1
		_loop2:
			lea edi, [arr3 + edx]
				mov ecx, 10
				rep stosd
				add edx, 80
				dec ebx
				cmp ebx, 0
				ja _loop2
	}
	c_end = __rdtsc() - c_start;

	std::cout << std::endl
		<< "Ticks: " << c_end << std::endl
		<< "Use method (STOSD):" << std::endl
		<< std::endl;
	printArray(arr[0]);
	std::cout << std::endl;
}


int main()
{
	commandASMTest();
}