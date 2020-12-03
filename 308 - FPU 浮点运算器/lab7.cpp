// �ο����ϣ�http ://c.biancheng.net/view/3826.html
#include <iostream>
#include <conio.h>
#include <float.h>

void commFADD()
{
    float a, b, c;

    std::cout << "Enter 3 (float) number:\n";
    std::cout << "A : "; std::cin >> a;
    std::cout << "B : "; std::cin >> b;
    std::cout << "C : "; std::cin >> c;
    std::cout << std::endl << a << " + " << b << " + " << c << " = ";
    __asm
    {
        /*
        * 9B DB E3 - FINIT
        * ���δ���������븡���쳣֮���ʼ�� FPU��C0��C1��C2��C3 ���Ϊ 0������ FPU ����������Ϊ 037Fh�������Σ����أ������и����쳣��
        * ���ߧڧ�ڧѧݧڧ٧ڧ��ۧ�� FPU ����ݧ� ����ӧ֧�ܧ� �ߧ� �ߧѧݧڧ�ڧ� �ߧ֧�ѧ٧�֧�֧ߧߧ�� �ѧߧ�ާѧݧڧ� �� ��ݧѧӧѧ��֧� ����ܧ�� �ҧ֧� �ާѧ�ܧ�
        *
        * DB E3 - FNINIT - ��ʼ�� FPU���������δ���������븡���쳣
        */
        finit

        /*
        * FLD�����ظ�����ֵ��ָ�������������Ƶ� FPU ��ջջ������Ϊ ST(0)����
        * ������������ 32 λ��64 λ��80 λ���ڴ��������REAL4��REAL8��REAL10������һ�� FPU �Ĵ�����
        * FLD - �����ڧ��ӧѧߧڧ� ���֧�ѧߧէ�� �� ��ݧѧӧѧ��֧� ����ܧ�� �� �ӧ֧��ߧ�� ��ѧ��� ���֧ܧ� FPU (�ߧѧ٧�ӧѧ֧��� ST(0))
        */
        fld a       // ST(0) = a
        fld b       // ST(0) = b,  ST(1) = a  ִ�еڶ��� FLD ʱ��TOP �� 1����ʹ��֮ǰ���Ϊ ST(0) �Ķ�ջԪ�ر�Ϊ�� ST(1)��
        fadd       // ��� FADD û�в��������� ST(0)�� ST(1)��ӣ�����ݴ��� ST(l)��Ȼ�� ST(0) ������ջ���Ѽӷ����������ջ����
        fstp a     // FSTP�����渡��ֵ�������ջ��ָ� ST(0) ��ֵ���Ƶ��ڴ沢�� ST(0) ������ջ

        fld a
        fld c
        fadd
        fstp a
    }

    std::cout << a << std::endl << std::endl;
}


void commFDIV()
{
    float a = 5;
    float b = 0;
    int ctrl = 0x027B;  // 0000 0010 0111 1011

    std::cout << a << " /  " << b << " = ";
    //short dd;
    __asm
    {
        finit
        fstcw ctrl

        and ctrl, 0xffb  // 0000 1111e 1111e 1011b

        fldcw ctrl // ���θ����쳣 - ���ߧ�ާѧݧڧ� ��ݧѧӧѧ��֧� ����ܧ� ��ڧ��

        fld a
        fld b
        fdiv
        fstp a
    }

    std::cout << a << std::endl << std::endl;
}

void main()
{
    system("chcp 65001 && cls");

    //commFADD();
    std::cout << "==================================" << std::endl;
    std::cout << ">>> Div on 0 :" << std::endl;
    commFDIV();
}