nasm bootsect.asm -f bin -o bootsect.bin
qemu-system-x86_64 -drive format=raw,file=bootsect.bin
pause