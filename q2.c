#include <stdio.h>

// İki sayının asal olup olmadığını kontrol eden fonksiyon
int areCoprime(int a, int b) {
    if (a == b)
        return a;
    int temp;
    while (b != 0) {
        temp = a % b;
        a = b;
        b = temp;
    }
    return a; // GCD'yi döndürür
}


// İki sayının en küçük ortak katını bulan fonksiyon
int findLCM(int a, int b) {
    int gcd = areCoprime(a, b);
    return gcd ? (a / gcd) * b : 0; // GCD 0 ise, LCM hesaplanamaz
}

int main() {
    const int maxLength = 20;
    int arr[maxLength];
    int n = 0; // Gerçek dizinin uzunluğunu izlemek için bir değişken

    printf("Diziyi giriniz (-1 girerek sonlandiriniz):\n");

    int input;
    while (n < maxLength && scanf("%d", &input) == 1 && input != -1) {
        arr[n++] = input;
    }
    // 12 3 2 7 13
    // 0 1 2 3 4 5
    for (int i = 1; i < n; i++) {
        if (areCoprime(arr[i - 1], arr[i]) != 1) {
            int lcm = findLCM(arr[i - 1], arr[i]);
            arr[i - 1] = lcm;

            // Sağdaki elemanları sola kaydır
            for (int j = i; j < n - 1; j++) {
                arr[j] = arr[j + 1];
            }
            n--; // Dizi boyutunu azalt

            // Eğer i'nin solunda eleman varsa ve o eleman ile yeni lcm asal değilse
            // i'yi azaltarak o elemanı tekrar kontrol et
            if (i > 1 && areCoprime(arr[i - 2], arr[i - 1]) != 1) {
                i -= 2;
            } else {
                i--; // Yalnızca bir önceki elemana dön
            }
        }
    }

    printf("Guncellenmis dizi:\n");
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    return 0;
}