.model large
code segment
assume cs:code, ds:code, es:code, ss:code
org 100h
start:
 
 ;Перейти на начало
 jmp beg
 
 print_symbol:
 ;Распечатать символ
  push ax
  push dx
  mov ah, 02h
  mov dl, dh
  cmp dl, 0
  je t2
  int 21h
  t2:
  pop dx
  int 21h
  pop ax
  ret
 
 print_number:
  ;Распечатать число, base = 10 
  push ax
  push bx
  push cx
  push dx
  mov ax, dx
  mov bx, 10
  mov cx, 0
  getdigits:
   mov dx, 0
   div bx
   inc cx
   add dx, 30h
   push dx
   cmp ax, 0
   jnz getdigits
  mov ah, 02h
  printdigits:
   pop dx
   int 21h
   loop printdigits
  pop dx
  pop cx
  pop bx
  pop ax
  ret
 
 debug:
  ;Сохранить регистры, запретить прерывания
  cli
  push bp
  mov bp, sp
  push ax
  push bx
  push cx
  push dx
  push si
  ;Вывести ip и ax
  mov dx, '['
  call print_symbol
  mov dx, [bp+2]
  call print_number
  mov dx, ','
  call print_symbol
  mov dx, [bp-2]
  call print_number
  mov dx, ']'
  call print_symbol
  mov dx, etr
  call print_symbol 
  ;Ожидать нажатие клавиши
  xor ax, ax
  int 16h
  ;Восстановить регистры, разрешить прерывания
  pop si
  pop dx
  pop cx
  pop bx
  pop ax
  pop bp
  sti
  iret
 
 ;Отлаживаемая программа
 thread:
  mov ax, 1
  mov cx, 10
  t1:
   add ax, ax
   loop t1
  ret
 
 beg:
  ;Сохранить старый обработчик
  mov ax, 3501h
  int 21h
  mov int1, bx
  mov int1+2, es
  ;Установить новый обработчик
  push cs
  pop ds
  mov dx, offset debug
  mov ax, 2501h
  int 21h
  ;Сохранить парамеры для возврата
  pushf
  push offset exit
  ;Установит TF флаг
  pushf
  pop ax
  or ax, 100h
  push ax
  push cs
  push offset thread
  iret
  
 exit:
  popf
  ;Установить старый обработчик
  lea dx, int1 
  mov ax, 2501h
  int 21h
  ;Выход после нажатия клавиши
  mov ah, 01h
  int 21h
  int 20h

int1 dw 0h, 0h
etr dw 0Ah, 0Dh
 
code ends
end start
