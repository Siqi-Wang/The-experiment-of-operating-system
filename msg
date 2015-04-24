/*************************************************************************
	> File Name: pipe.c
	> Author: 王超
	> Number: 2013051741
	> Created Time: 2015年04月23日 星期四 20时15分29秒
 ************************************************************************/

#include<stdio.h>
#include<sys/types.h>
#include<sys/msg.h>
#include<sys/ipc.h>
#include<stdlib.h>
#include<unistd.h>

#define Key 75

struct msgform
{
    long mtype;
    char mtrex[100];
}msg;

int msgqid,i;

void Sent()
{
    int i;
    msgqid=msgget(Key,0777);
    for(i=2;i>=1;i--)
    {
        msg.mtype=i;
        printf("\tA signal has sent\n");
        msgsnd(msgqid,&msg,100,0);
    }
    exit(0);
}

void Receive()
{
    msgqid=msgget(Key,0777|IPC_CREAT);
    do
    {
        msgrcv(msgqid,&msg,100,0,0);
        printf("\tReceive a signal\n");
    }
    while(msg.mtype!=1);
    msgctl(msgqid,IPC_RMID,0);
    exit(0);
}

void main()
{
    if((i=fork())==-1)
    {
        perror("Fail to fork new progress.");
        exit(EXIT_FAILURE);
    }
    if(!i)
        Receive();
    
    if((i=fork())==-1)
    {
        perror("Fail to fork new progress.");
        exit(EXIT_FAILURE);
    }
    if(!i)
        Sent();
    wait(0);
    wait(0);
}
