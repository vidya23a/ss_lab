#include<stdio.h>
#include<string.h>

char input[30],label[30];
int start,end,address,addr,taddr,ptaddr,w=0,length=0,l,count=0,i=0,k;
FILE*fp1,*fp2;

void check(){
    count++;
    address++;
    taddr++;
    
    if(count==4){
        printf(" ");
        i++;
        if(i==4){
            printf("\n%x\t",taddr);
            i=0;
        }
        count=0;
    }
}

int main(){
    fp1=fopen("input.txt","r");
    fscanf(fp1,"%s",input);
    printf("MEMORY ADDRESS\t CONTENTS\n");
    while(strcmp(input,"E")!=0){
        if(strcmp(input,"H")==0){
            fscanf(fp1,"%s%x%x%s",label,&start,&end,input);
            address=start;
        }
        else if(strcmp(input,"T")==0){
            l=length;
            ptaddr=addr;
            fscanf(fp1,"%x%x%s",&taddr,&length,input);
            addr=taddr;
            if(w==0){
                ptaddr=address;
                w=1;
            }
            for( k=0;k<(taddr-(ptaddr+1));k++){
                address++;
                printf("xx");
                count++;
                if(count==4){
                    printf(" ");
                    i++;
                    if(i==4){
                        printf("\n%x\t",address);
                        i=0;
                    }
                    count=0;
                }
                
            }
            if(taddr==start)
                printf("\n%x\t",taddr);
            printf("%c%c",input[0],input[1]);
            check();
            printf("%c%c",input[2],input[3]);
            check();
            printf("%c%c",input[4],input[5]);
            check();
            fscanf(fp1,"%s",input);
        }
        else{
            printf("%c%c",input[0],input[1]);
            check();
            printf("%c%c",input[2],input[3]);
            check();
            printf("%c%c",input[4],input[5]);
            check();
            fscanf(fp1,"%s",input);
        }
    }
    fclose(fp1);
}


/*
ADDRESS		CONTENTS

1000	14103348 20390010 36281030 30101548 
1010	20613C10 0300102A 0C103900 102Dxxxx 
1020	xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx 
1030	xxxxxxxx xxxxxxxx xxxxxx0C 10364820 
1023	61081033 4C000045 4F460000 03000000 
1033	xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx 
1060	xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx 
1070	xxxxxxxx xxxxxxxx 04103000 1030E020 
104f	5D30203F D8205D28 10303020 57549039 
105f	2C205E38 203Fxxxx xxxxxxxx xxxxxxxx 
10a0	xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx 
10b0	xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx 
10c0	xxxxxxxx xx101036 4C000000 00000010 
1082	00041030 E0207930 20645090 39DC2079 
1092	2C1036
*/
