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
§£ §á§â§à§è§Ö§ã§ã§à§â§Ö §ä§Ú§á§Ñ Pentium §Ú§ã§á§à§İ§î§Ù§å§ğ§ä§ã§ñ §ã§İ§Ö§Õ§å§ğ§ë§Ú§Ö §ã§á§à§ã§à§Ò§í §Ñ§Õ§â§Ö§ã§Ñ§è§Ú§Ú :
	1. add ax, 12						§¯§Ö§á§à§ã§â§Ö§Õ§ã§ä§Ó§Ö§ß§ß§Ñ§ñ §Ñ§Õ§â§Ö§ã§Ñ§è§Ú§ñ
	2. call proc							§¡§Ò§ã§à§İ§ğ§ä§ß§Ñ§ñ §Ñ§Õ§â§Ö§ã§Ñ§è§Ú§ñ.
	3. add ax, bx						§²§Ö§Ô§Ú§ã§ä§â§à§Ó§Ñ§ñ §Ñ§Õ§â§Ö§ã§Ñ§è§Ú§ñ.
	4. add ax, [bx]						§¬§à§ã§Ó§Ö§ß§ß§à - §â§Ö§Ô§Ú§ã§ä§â§à§Ó§Ñ§ñ §Ñ§Õ§â§Ö§ã§Ñ§è§Ú§ñ.
	5. add ax, [bx + disp]			§¢§Ñ§Ù§à§Ó§Ñ§ñ §Ñ§Õ§â§Ö§ã§Ñ§è§Ú§ñ(§Ñ§Õ§â§Ö§ã§Ñ§è§Ú§ñ §á§à §Ò§Ñ§Ù§Ö)
	6. add ax, [bx + si]				§¢§Ñ§Ù§à§Ó§à - §Ú§ß§Õ§Ö§Ü§ã§ß§Ñ§ñ
	7. add ax, [bx + si + disp]	§¢§Ñ§Ù§à§Ó§à - §Ú§ß§Õ§Ö§Ü§ã§ß§Ñ§ñ §ã§à §ã§Ş§Ö§ë§Ö§ß§Ú§Ö§Ş
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