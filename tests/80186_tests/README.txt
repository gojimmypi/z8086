
"80186_tests" test suite (these are actually testing 80286)

* *.asm      original source code
* *.bin      test binaries. place at F000:0000.
             NOTE: these assume 286 boot behavior (CS:IP=F000:FFF0).
* res_*.bin  results expected at the offset 0x0
* *.s        disassembly
