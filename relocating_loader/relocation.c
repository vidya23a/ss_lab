#include<stdio.h>
#include<stdlib.h>
#include<string.h>

char bitmask[20],bit[30];

void bitmask_convert(char mask[]){
    int i,len;
    len=strlen(mask);
    strcpy(bit,"");
    for(i=0;i<len;i++){
        switch(mask[i]){
            case '0':strcat(bit,"0000");break;
            case '1':strcat(bit,"0001");break;
            case '2':strcat(bit,"0010");break;
            case '3':strcat(bit,"0011");break;
            case '4':strcat(bit,"0100");break;
            case '5':strcat(bit,"0101");break;
            case '6':strcat(bit,"0110");break;
            case '7':strcat(bit,"0111");break;
            case '8':strcat(bit,"1000");break;
            case '9':strcat(bit,"1001");break;
            case 'A':strcat(bit,"1010");break;
            case 'B':strcat(bit,"1011");break;
            case 'C':strcat(bit,"1100");break;
            case 'D':strcat(bit,"1101");break;
            case 'E':strcat(bit,"1110");break;
            case 'F':strcat(bit,"1111");break;
            default:break;
        }
    }
}

void main(){
    FILE*fp1;
    char rec[20],first[3],second[5],name[20];
    int start,addr,len,bitmask_index=0,modif_obj_code,add;
    printf("Enter the starting address\n");
    scanf("%X",&start);
    add=start;
    fp1=fopen("input.txt","r");
    fscanf(fp1,"%s",rec);
    if(strcmp(rec,"H")==0){
        fscanf(fp1,"%s,%x,%x",name,&addr,&len);
        printf("Program name:%s\n\n",name);
        printf("ADDRESS\tOBJECT CODE\n");
    }
    else{
        printf("Unrecognized object code format\n");
        exit(1);
    }
    strcpy(rec,"");
    fscanf(fp1,"%s",rec);
    while(strcmp(rec,"E")!=0){
        if(strcmp(rec,"T")==0){
            fscanf(fp1,"%X%X%s",&addr,&len,bitmask);
            addr+=start;
            bitmask_index=0;
            bitmask_convert(bitmask);
            fscanf(fp1,"%s",rec);
        }
        if(bit[bitmask_index]=='1'){
            for(int i=0;i<6;i++){
                if(i<2)
                    first[i]=rec[i];
                else
                    second[i-2]=rec[i];
            }
            first[2]='\0';
            second[4]='\0';
            modif_obj_code=strtol(second,NULL,16);
            modif_obj_code+=start;
            printf("%X\t%s%X\n",addr,first,modif_obj_code);
        }
        else{
            printf("%X\t%s\n",addr,rec);
        }
        addr+=3;
        bitmask_index++;
        fscanf(fp1,"%s",rec);
    }
    fclose(fp1);
}
