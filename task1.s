.file	"solution.c"
	.intel_syntax noprefix
	.text
	.data
	.align 4
	.type	maxLength, @object
	.size	maxLength, 4
maxLength:                                  #переменная - максимальное число элементов в массиве
	.long	219                             #значение перемнной maxLength
	.local	A                               #массив, в который считываются данные
	.comm	A,876,32                        #выделение памяти 876 байт (219 * sizeof(int))
	.local	B                               #массив, в который будет записан результат
	.comm	B,876,32                        #выделение памяти 876 байт
	.section	.rodata
.LC0:
	.string	"Length is incorrect = %d\n"    #строка, которая говорит ползователю, про неверную длину массива
	.text
	.globl	checkLength                     #объявление функции
	.type	checkLength, @function
checkLength:                                #функция, проверяющая длину массива
	endbr64
	push	rbp                             #сохранение rbp на стек
	mov	rbp, rsp                            #rbp = rsp
	sub	rsp, 16                             #вычитаем из rsp 16
	mov	DWORD PTR -4[rbp], edi              #указывает где на стеке разместить первый аргумент функции (переменная length)
	cmp	DWORD PTR -4[rbp], 0                #конструкция if (первое сравнение)
	jle	.L2                                 #если истина
	mov	eax, DWORD PTR maxLength[rip]       #eax = maxLength
	cmp	DWORD PTR -4[rbp], eax              #конструкция if (второе сравнение)
	jle	.L3                                 #если ложь
.L2:                                        #выводит строку о некорректности длины массива(если условный оператор истен)
	mov	eax, DWORD PTR -4[rbp]              #eax = DWORD PTR -4[rbp]
	mov	esi, eax                            #esi = eax
	lea	rax, .LC0[rip]                      #вызов вывода
	mov	rdi, rax                            #rdi = rax
	mov	eax, 0                              #eax = 0
	call	printf@PLT                      #вывод строки
	mov	eax, 0                              #eax = 0
	jmp	.L4                                 #переход к L4
.L3:
	mov	eax, 1                              #eax = 1
.L4:
	leave                                   #выход из функции
	ret                                     #возврат функции
	.size	checkLength, .-checkLength
	.section	.rodata
.LC1:
	.string	"%d"                            #строка, для формата ввода
	.text
	.globl	readArray                       #объявление функции
	.type	readArray, @function
readArray:                                  #функция заполнения массива
	endbr64
	push	rbp                             #сохранение rbp на стек
	mov	rbp, rsp                            #rdb = rsp
	sub	rsp, 32                             #вычитаем из rsp 32
	mov	DWORD PTR -20[rbp], edi             #указывает где на стеке разместить первый аргумент функции (переменная size)
	mov	DWORD PTR -4[rbp], 0                #счётчик цикла (переменная i)
	jmp	.L6                                 #перемещение к L6
.L7:
	mov	eax, DWORD PTR -4[rbp]              #eax = переменная цикла
	cdqe                                    #расширение "слова"
	lea	rdx, 0[0+rax*4]                     #rdx = адрес i-го элемента массива
	lea	rax, A[rip]
	add	rax, rdx                            #прибавление rdx к rax
	mov	rsi, rax                            #rsi = rax
	lea	rax, .LC1[rip]                      #подсказка для ввода
	mov	rdi, rax                            #rdi = rax
	mov	eax, 0                              #eax = 0
	call	__isoc99_scanf@PLT              #вызов принт
	mov	eax, DWORD PTR -4[rbp]              #eax = адрес счётчика
	cdqe                                    #расширение "слова"
	lea	rdx, 0[0+rax*4]                     #rdx = i-й элемент
	lea	rax, A[rip]
	mov	eax, DWORD PTR [rdx+rax]            #eax = адрес в стеке на arrayB[i]
	mov	edx, DWORD PTR -4[rbp]              #edx = sizeA
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]                     #rcx = адрес i-го
	lea	rdx, B[rip]
	mov	DWORD PTR [rcx+rdx], eax            #присвоение результата arrayB[i] = arrayA[i] * arrayA[i]
	add	DWORD PTR -4[rbp], 1                #i += 1
.L6:
	mov	eax, DWORD PTR -4[rbp]              #eax = адрес счётчика
	cmp	eax, DWORD PTR -20[rbp]             #сравнение счётчика c sizeA (аргумент функции)
	jl	.L7                                 #если eax < size переходим в .L7
	nop
	nop
	leave                                   #очистка стека
	ret                                     #возврат в вызывающую функцию
	.size	readArray, .-readArray
	.globl	calcArray
	.type	calcArray, @function
calcArray:                              #объявление функции
	endbr64
	push	rbp                          #сохранение rbp на стек
	mov	rbp, rsp                            #rbp = rsp
	mov	DWORD PTR -20[rbp], edi         #указывает где на стеке разместить первый аргумент функции (переменная size)
	mov	DWORD PTR -4[rbp], 0             #переменная цикла i = 0
	jmp	.L9
.L12:
	mov	eax, DWORD PTR -4[rbp]          #eax := переменная цикла
	cdqe
	lea	rdx, 0[0+rax*4]                 #rdx = i-й элемент
	lea	rax, A[rip]
	mov	eax, DWORD PTR [rdx+rax]        #eax = адрес в стеке на B[i]
	test	eax, eax                    #сравнение с 0
	jle	.L10
	mov	eax, DWORD PTR -4[rbp]          #eax = B[i]
	cdqe
	lea	rdx, 0[0+rax*4]                 #rdx = адрес i-го элемента массива
	lea	rax, B[rip]
	mov	DWORD PTR [rdx+rax], 2
	jmp	.L11
.L10:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, A[rip]
	mov	eax, DWORD PTR [rdx+rax]        #eax = адрес в стеке на arrayB[i]
	test	eax, eax
	jns	.L11
	mov	eax, DWORD PTR -4[rbp]          #eax = переменная цикла
	cdqe
	lea	rdx, 0[0+rax*4]                 rdx = адрес i-го элемента массива
	lea	rax, A[rip]
	mov	eax, DWORD PTR [rdx+rax]        #eax = адрес в стеке на B[i]
	lea	ecx, 5[rax]
	mov	eax, DWORD PTR -4[rbp]          #eax = переменная цикла i
	cdqe
	lea	rdx, 0[0+rax*4]                 #rdx = адрес i-го элемента массива
	lea	rax, B[rip]
	mov	DWORD PTR [rdx+rax], ecx
.L11:
	add	DWORD PTR -4[rbp], 1  # i += 1
.L9:
	mov	eax, DWORD PTR -4[rbp]          #eax = адрес счётчика (i)
	cmp	eax, DWORD PTR -20[rbp]         #сравнение счётчика c sizeA (аргумент функции)
	jl	.L12
	nop
	nop
	pop	rbp
	ret
	.size	calcArray, .-calcArray
	.section	.rodata
.LC2:
	.string	"A: "
.LC3:
	.string	"%d "
.LC4:
	.string	"\nB: "
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp         #сохранение rbp на стек
	mov	rbp, rsp          #rbp = rsp
	sub	rsp, 16          #вычитаем из rsp 16
	lea	rax, -12[rbp]
	mov	rsi, rax         #rsi = rax
	lea	rax, .LC1[rip]      #получение формата считывания
	mov	rdi, rax             #rdi := rax
	mov	eax, 0               #eax := 0
	call	__isoc99_scanf@PLT  # #вызов функции scanf
	mov	eax, DWORD PTR -12[rbp]
	mov	edi, eax            #edi := eax
	call	checkLength
	test	eax, eax
	jne	.L14
	mov	eax, 0                  #eax := 0
	jmp	.L20
.L14:
	mov	eax, DWORD PTR -12[rbp]
	mov	edi, eax
	call	readArray
	mov	eax, DWORD PTR -12[rbp]
	mov	edi, eax
	call	calcArray       #вызов функции
	lea	rax, .LC2[rip]      #rax := строка для вывода
	mov	rdi, rax            #rdi := rax
	call	puts@PLT
	mov	DWORD PTR -4[rbp], 0    #переменная цикла i = 0
	jmp	.L16
.L17:
	mov	eax, DWORD PTR -4[rbp]  #eax = переменная цикла
	cdqe
	lea	rdx, 0[0+rax*4]          #rdx = i-й элемент
	lea	rax, A[rip]
	mov	eax, DWORD PTR [rdx+rax]        #eax := адрес в стеке на arrayB[i]
	mov	esi, eax
	lea	rax, .LC3[rip]
	mov	rdi, rax                    #rdi := формат вывода
	mov	eax, 0
	call	printf@PLT           #вызов функции printf
	add	DWORD PTR -4[rbp], 1        #переменная цикла i += 1
.L16:
	mov	eax, DWORD PTR -12[rbp]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L17
	lea	rax, .LC4[rip]
	mov	rdi, rax      #rdi := формат вывода
	call	puts@PLT
	mov	DWORD PTR -8[rbp], 0
	jmp	.L18
.L19:
	mov	eax, DWORD PTR -8[rbp]  #eax = адрес в стеке на введённое значение
	cdqe
	lea	rdx, 0[0+rax*4]     #rdx = адрес i-го элемента массива
	lea	rax, B[rip]
	mov	eax, DWORD PTR [rdx+rax]        #eax = адрес в стеке на arrayB[i]
	mov	esi, eax
	lea	rax, .LC3[rip]
	mov	rdi, rax              #rdi := формат вывода
	mov	eax, 0
	call	printf@PLT           #вызов функции printf
	add	DWORD PTR -8[rbp], 1
.L18:
	mov	eax, DWORD PTR -12[rbp]
	cmp	DWORD PTR -8[rbp], eax
	jl	.L19
	mov	eax, 0      #eax = 0
.L20:
	leave           #очистка стека
	ret                  #возврат в вызывающую функцию
