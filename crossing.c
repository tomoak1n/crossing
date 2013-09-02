/* crossing.c for counting the number of crosses for codeiq by hyuki */
#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <stdlib.h>
#include <sys/stat.h>

typedef struct {
  int depth;
  int64_t **data_a;
} count_factory;
  

count_factory
initializefactory(int maxsize)
{
  count_factory f;
  int i;
  f.depth = log2(maxsize);
  f.data_a = malloc((f.depth+1) * sizeof(int64_t*));
  for(i = 0; i <= f.depth; i++){
    f.data_a[i] = calloc(1 << i, sizeof(int64_t));
  }
  return f;
}

int64_t
registerandreportcrosses(count_factory *f, int number)
{
  int64_t  cross = 0;
  int i = f->depth;
  int sn = number;
  while(i >= 0){
    int t = sn >> 1;
    int64_t *a = f->data_a[i];
    if ((sn&1) == 0)
      cross += a[t];
    else
      a[t] += 1;
    sn = t;
    i -= 1;
  }
  return cross;
}

int 
main(int argc, char**argv)
{
  count_factory f;
  struct stat sb;
  off_t filesize;
  FILE*input;
  int maxsizeest;
  int64_t cross;
  int c;

  if(argc < 2) exit(1);
  stat(argv[1], &sb);
  filesize = sb.st_size;
  maxsizeest = filesize/log10(filesize);

  f = initializefactory(maxsizeest);
  cross = 0;
  
  input = fopen(argv[1], "r");
  int n = 0;
  while((c=fgetc(input))!=EOF){
    switch(c){
     case '\n':
      cross += registerandreportcrosses(&f, n);
      n = 0;
      break;
     case '\r':
      break;
     default:
      n= n*10 + c - '0';
    }
  }
  if(n != 0){/*no new line at the last line */
    cross += registerandreportcrosses(&f, n);
  }
  printf("%lld\n", cross);
  return 0;
}
