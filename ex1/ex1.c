// 209194141 Ynon Hendin

#include <stdbool.h>

typedef unsigned char* bytePointer;

// if a machine is big endian we expect the byte representation of the number 1 to be 0x00000001.
// conversely, if it is little endian it will be 0x01000000. this function uses a pointer of type
// unsigned char to check if indeed the MSB of the number 1, as represented in the machine, is zero.
int is_big_endian() {
    int n = 0x1;
    bytePointer bp = (bytePointer) &n;

    if (bp[0] > 0) {
        return 0;
    } else {
        return 1;
    }
}

// the idea is to add a 1 and shift it left until it gets to its spot in the representation, thus giving us the number.
// we loop on the bitArray, shifting left and then either adding one or zero, according to the value in
// bitArray. lastly, since we want the sign-magnitude value we check if the MSB is one or zero and return a negative
// or positive number accordingly.
// since the function gets an 8 bit long bit array it is easier to use a char, since this function will never get a
// value that is out of chars range. casting from char to int in this case does not affect the number.
int get_sign_magnitude(bool bitArray[8]) {
    char num = 0;
    int i;

    for (i = 6; i >= 0; i--) {
        num <<= 1;
        num += bitArray[i];
    }

    if (bitArray[7] == 1) {
        return (int) ((-1) * num);
    } else {
        return (int) num;
    }
}

// this function works like the previous function, except there is no need to check the MSB or make any twos-comp
// calculations, since the standard way of interpreting chars and ints in C is twos-comp.
int get_two_comp(bool bitArray[8]) {
    char num = 0;
    int i;

    for (i = 7; i >= 0; i--) {
        num <<= 1;
        num += bitArray[i];
    }
    return (int) num;
}
