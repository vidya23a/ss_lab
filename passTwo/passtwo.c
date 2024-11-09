#include<stdio.h>
#include<stdlib.h>
#include<string.h>

struct optab{
    char opcode[10];
    char hexcode[10];
}OT[30];
struct symtab{
    char symbol[10];
    int addr;
}ST[30];

int op_length,size,locctr,end_locctr,sym_length,start,instruction_length,is_found;
FILE*fp1,*fp2,*fp3,*fp4;
char label[10],opcode[10],hexcode[10],operand[10],line[50];

void op_read(){
    int i;
    for(i=0;i<30;i++){
        fscanf(fp1,"%s\t%s",OT[i].opcode,OT[i].hexcode);
    }
    op_length=i;
}

void sym_read(){
    int i;
    for(i=0;i<30;i++){
        fscanf(fp2,"%s\t%d",ST[i].symbol,&ST[i].addr);
    }
    sym_length=i;
}

int get_addr(char *label){
    for(int j=0;j<sym_length;j++){
        if(strcmp(ST[j].symbol,label)==0){
            return ST[j].addr;
        }
    }
    return -1;
}

int main(){
    fp1=fopen("optab.txt","r");
    fp2=fopen("symtab.txt","r");
    fp3=fopen("intermediate.txt","r");
    fp4=fopen("output.txt","w");
    
    op_read();
    sym_read();
    
    fscanf(fp3,"\t%s\t%s\t%x",label,opcode,&start);
    locctr=start;
    while(fgets(line,sizeof(line),fp3)){
        sscanf(line,"%x\t%s\t%s\t%s",&locctr,label,opcode,operand);
        if(strcmp(opcode,"END")==0){
            end_locctr=locctr;
            break;
        }
    }
    size=end_locctr-start;
    fprintf(fp4,"H^%s^%06x^%06x\n",label,start,size);
    rewind(fp3);
    fscanf(fp3,"%s %s %x",label,opcode,&start);
    while(fgets(line,sizeof(line),fp3)){
        instruction_length=0;
        sscanf(line,"%x %s %s %s",&locctr,label,opcode,operand);
        if(strcmp(opcode,"END")==0){
            fprintf(fp4,"E^%06x\n",start);
            break;
        }
        is_found=0;
        for(int i=0;i<op_length;i++){
            if(strcmp(OT[i].opcode,opcode)==0){
                int address=get_addr(operand);
                if(address!=-1){
                    instruction_length=6;
                    fprintf(fp4,"T^%06x^%02x^%s^%06x\n",locctr,instruction_length,OT[i].hexcode,address);
                }
                is_found=1;
                break;
            }
        }
        if(!is_found){
            if(strcmp(opcode,"WORD")==0){
                instruction_length=6;
                fprintf(fp4,"T^%06x^%02x^%s^%06x\n",locctr,instruction_length,"00",atoi(operand));
            }
            else if(strcmp(opcode,"BYTE")==0){
                if(operand[0]=='C'||operand[0]=='c'){
                    instruction_length=strlen(operand)-3;
                    fprintf(fp4,"T^%06x^%02x^%s^%s\n",locctr,instruction_length,"C",operand+2);
                }
                else{
                    instruction_length=(strlen(operand)-3)/2;
                    fprintf(fp4,"T^%06x^%02x^%s^%s\n",locctr,instruction_length,"H",operand+2);
                }
            }
        }
    }
    fclose(fp1);
    fclose(fp2);
    fclose(fp3);
    fclose(fp4);
}
