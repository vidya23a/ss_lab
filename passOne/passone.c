#include<stdio.h>
#include<string.h>
#include<stdlib.h>

char label[10],opcode[10],operand[10];
char code[10],mnemonic[10];

void passOne(){
    int locctr,length,start;
    FILE*fp1,*fp2,*fp3,*fp4;
    
    fp1=fopen("input.txt","r");
    fp2=fopen("optab.txt","r");
    fp3=fopen("symtab.txt","w");
    fp4=fopen("intermediate.txt","w");
    
    fscanf(fp1,"%s\t%s\t%s",label,opcode,operand);
    if(strcmp(opcode,"START")==0){
        start=atoi(operand);
        locctr=start;
        fprintf(fp4,"\t%s\t%s\t%s\n",label,opcode,operand);
        fscanf(fp1,"%s\t%s\t%s",label,opcode,operand);
    }
    else
        locctr=0;
    
    while(strcmp(opcode,"END")!=0){
        fprintf(fp4,"%d\t%s\t%s\t%s\n",locctr,label,opcode,operand);
        
        if(strcmp(label,"**")==0){
            fprintf(fp3,"%s\t%d\n",opcode,locctr);
        }
        
        fscanf(fp2,"%s\t%s",code,mnemonic);
        while(strcmp(code,"END")!=0){
            if(strcmp(opcode,code)==0){
                locctr+=3;
                break;
            }
            fscanf(fp2,"%s\t%s",code,mnemonic);
        }
        
        if(strcmp(opcode,"WORD")==0)
            locctr+=3;
        if(strcmp(opcode,"BYTE")==0)
            locctr++;
        if(strcmp(opcode,"RESB")==0)
            locctr+=atoi(operand);
        if(strcmp(opcode,"RESW")==0)
            locctr+=(3*(atoi(operand)));
            
        fscanf(fp1,"%s\t%s\t%s",label,opcode,operand);

    }
    fprintf(fp4,"%d\t%s\t%s\t%s\n",locctr,label,opcode,operand);
    length=locctr-start;
    printf("Length:%d\n",length);
}

int main(){
    passOne();
}

//length=23
