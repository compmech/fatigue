#ifndef RAINFLOW_H
#define RAINFLOW_H

#include <math.h>

void rainflowc(int n, double *points, double *array_out)
{
    double *pr, *po, a[16384], ampl, mean;
    int tot_num, index, j, cNr;

    tot_num = n;
    pr = points;
    po = array_out;
    j = -1;
    cNr = 1;
    for (index=0; index<tot_num; index++)
    {
        a[++j]=*pr++;
        while ( (j >= 2) && (fabs(a[j-1]-a[j-2]) <= fabs(a[j]-a[j-1])) )
        {
            ampl=fabs( (a[j-1]-a[j-2])/2 );
            switch(j)
            {
                case 0: { break; }
                case 1: { break; }
                case 2: {
                    mean=(a[0]+a[1])/2;
                    a[0]=a[1];
                    a[1]=a[2];
                    j=1;
                    if (ampl > 0) {
                        *po++=ampl;
                        *po++=mean;
                        *po++=0.50;
                    }
                    break;
                }
                default: {
                    mean=(a[j-1]+a[j-2])/2;
                    a[j-2]=a[j];
                    j=j-2;
                    if (ampl > 0) {
                        *po++=ampl;
                        *po++=mean;
                        *po++=1.00;
                        cNr++;
                    }
                    break;
                }
            }
        }
    }
    for (index=0; index<j; index++) {
        ampl=fabs(a[index]-a[index+1])/2;
        mean=(a[index]+a[index+1])/2;
        if (ampl > 0){
            *po++=ampl;
            *po++=mean;
            *po++=0.50;
        }
    }
}
#endif RAINFLOW_H
