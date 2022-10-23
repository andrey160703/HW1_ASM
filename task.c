//
// Created by Андрей Гусев on 23.10.2022.
//

#include <stdio.h>

static int maxLength = 219; // инициализируем максимальную длину
static int A[219]; // инициализируем массивы
static int B[219]; // инициализируем массивы

int checkLength(const int length) {
    if (length < 1 || length > maxLength) { // проверяем длину на корректность значения
        printf("Length is incorrect = %d\n", length);
        return 0;
    }
    return 1;
}

void readArray(const int size) {
    for (int i = 0; i < size; ++i) {
        scanf("%d", &A[i]); // считываем исходный массив
        B[i] = A[i];
    }
}

void calcArray(const int size) {
    for (int i = 0; i < size; ++i) {
        // Делаем заданное преобразование (Вариант 25)
        if (A[i] > 0)
            B[i] = 2;
        else if (A[i] < 0)
            B[i] = A[i] + 5;
    }
}

int main() {
    int size; // длина исходного массива
    scanf("%d", &size); // считываем длину исходного массива
    if (!checkLength(size)) {
        return 0;
    }
    readArray(size);
    calcArray(size);
    printf("A: \n");
    for (int i = 0; i < size; ++i) {
        printf("%d ", A[i]); // выводим исходный массив
    }
    printf("\nB: \n");
    for (int i = 0; i < size; ++i) {
        printf("%d ", B[i]); // выводим полученный массив
    }
    return 0;
}
