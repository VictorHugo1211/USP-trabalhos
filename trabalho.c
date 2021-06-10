#include <stdio.h>

int opc, a, b, c, d, e, aux, aux2, log;
main()
{
   printf ("Escolha uma das operacoes:\n");
   printf ("1) Media aritmetica simples\n");
   printf ("2) Media ponderada\n");
   printf ("3) Desvio padrao\n");
   printf ("4) Maior valor\n");
   printf ("5) Menor valor\n");
   scanf ("%d", &opc);

   switch (opc)
   {
   case 1:
       printf ("Digite a quantidade de variaveis (min: 1 e max:5)\n");
       scanf ("%d", &log);
       printf ("Digite o primeiro valor\n");
       scanf ("%d", &a);
       if (log == 1)
       {
           aux2 = a;
           printf ("%d", aux2);

           return;
       } else {
           log = log + 1;
       }
       
       
       printf ("Digite o segundo valor\n");
       scanf ("%d", &b);
       if (log == 2)
       {
           aux2 = a + b;
           printf ("%d", aux2);

           return 0;
       } else {
           log = log + 1;
       }
       
       printf ("Digite o terceiro valor\n");
       scanf ("%d", &c);
       log = log + 1;
       printf ("Digite o quarto valor\n");
       scanf ("%d", &d);
       log = log + 1;
       printf ("Digite o quinto valor\n");
       scanf ("%d", &e);
       log = log + 1;

       break;

   case 2:
       printf ("Digite o primeiro valor\n");
       scanf ("%d", &a);
       printf ("Digite o segundo valor\n");
       scanf ("%d", &b);
       printf ("Digite o terceiro valor\n");
       scanf ("%d", &c);
       printf ("Digite o quarto valor\n");
       scanf ("%d", &d);
       printf ("Digite o quinto valor\n");
       scanf ("%d", &e);

       break;

   case 3:
       while (aux != "exit")
       {
                                                
       }
       

       break;
     
   default:
       break;
   }

    return;
}
