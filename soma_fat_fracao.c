#include <stdio.h>
#include <math.h>

float fat = 0;
float i;
int n;

main(){
    printf ("Fatorial a ser calculado: \n");
    scanf ("%d",&n);

    for (i=1; i<=n; i++){
        fat = fat + (1/i);
        printf ("%f\n", fat); 
    } 

    printf ("%f", fat);
    return 0;

}