nasm -f elf64 -o m.o m.asm
ld -o m m.o
./m
