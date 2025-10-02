#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>

int main(int argc, char **argv){
    if(argc<2){fprintf(stderr,"usage: %s shellcode.bin\n",argv[0]);return 1;}
    int fd=open(argv[1],O_RDONLY); if(fd<0){perror("open"); return 1;}
    struct stat st; if(fstat(fd,&st)<0){perror("stat"); return 1;}
    size_t sz=st.st_size; void* p=mmap(NULL, (sz+0xFFF)&~0xFFF, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANON, -1, 0);
    if(p==MAP_FAILED){perror("mmap"); return 1;}
    if(read(fd,p,sz)!=(ssize_t)sz){perror("read"); return 1;}
    close(fd);
    ((void(*)(void))p)();
    return 0;
}
