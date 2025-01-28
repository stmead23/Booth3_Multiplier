#include <stdio.h>
#include <stdint.h>

int main(void) {
    //Open files for input and output, then check that they opened
    FILE* test_vecs = fopen("test.txt", "r");
    FILE* output = fopen("test.tv", "w");

    if (!test_vecs || !output) {
        printf("Fail to open file.\n");
        return 1;
    }

    uint16_t vectors[1000]; 

    //Read in values until the last one, then close the input file
    size_t i = 0;
    while (fscanf(test_vecs, "%x", &vectors[i]) != EOF) {
        i++;
    }
    fclose(test_vecs);

    //Write the formatted version into the output file, and close the output file
    for (i = 0; i < 1000; i+=2) {
        fprintf(output, "%04x_%04x_%08x\n", vectors[i], vectors[i+1], vectors[i]*vectors[i+1]);
    }
    fclose(output);
    return 0;
}