#include <stdio.h>
#include <stdlib.h>
#include <dos.h>

/* Program to dump a PC-9801's graphics GDC VRAM to a file. */

void dump_segmented(FILE *outfile, unsigned int seg, unsigned int offset,
                  unsigned long int length) {

  /* Dump memory starting at any offset in a segment;
     allowed to span multiple segments */
  char far *fb_address;
  unsigned long int i;
  unsigned long int j;
  unsigned int current_seg;
  i = 0;
  j = offset;
  current_seg = seg;
  fb_address = MK_FP(current_seg, offset);
  while(i < length){
    putc(*(fb_address+j),outfile);
    i++;
    j++;
    if (j >= 65536) {
      /* move to next segment */
      j=0;
      current_seg += 0x1000;
      fb_address = MK_FP(current_seg, 0x0000);
    }
  }
}

FILE *reopen(FILE *outfile, char *path, char *mode) {
  /* Reuse a file pointer for a different file */
  fclose(outfile);
  outfile = fopen(path, mode);
  if(!outfile) {
    fprintf(stderr, "ERROR: reopen(): Unable to open %s\n", path);
    exit(1);
  }
  return(outfile);
}

int main(int argc, char **argv) {
  FILE *outfile;
  outfile = fopen("VRAM_A8.BIN","wb");
  if (!outfile) {
    fprintf(stderr,"ERROR: fopen(): Unable to open VRAM_A8.BIN\n");
    exit(1);
  }
  dump_segmented(outfile, 0xa000, 0x8000, 256000);
  reopen(outfile, "VRAM_B0.BIN", "wb");
  dump_segmented(outfile, 0xb000, 0x0000, 256000);
  reopen(outfile, "VRAM_B8.BIN","wb");
  dump_segmented(outfile, 0xb000, 0x8000, 256000);
  reopen(outfile, "VRAM_E0.BIN", "wb");
  dump_segmented(outfile, 0xe000, 0x0000, 256000);
  fclose(outfile);
}











