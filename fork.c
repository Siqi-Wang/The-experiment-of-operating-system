#include<stdio.h>
#include<stdlib.h>
#include<sys/types.h>

main()
{
	sleep(1);
	if(fork()==0)
	{
	  sleep(2);
	  printf("This is the first child progress.\n");
	    if(fork()==0)
	    {
             sleep(2);
	     printf("this is the grandchild progress.\n");
	     exit(0);
	    }
          exit(1);
	}
	if(fork()==0)
	 {
	     sleep(3);
	     printf("This is the second child progress.\n");
	     exit(1);
	 }
      
	printf("This the father progress.\n");
	exit(1);
	
}
