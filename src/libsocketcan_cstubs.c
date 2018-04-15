#include <assert.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <net/if.h>

#include <string.h>
#include <stdint.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdbool.h>
#include <errno.h>

#include <linux/can.h>
#include <linux/can/raw.h>
#include <linux/can/error.h>

#include <libsocketcan.h>

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/threads.h>
#include <caml/callback.h>
#include <caml/fail.h>
#include <caml/unixsupport.h>

#include <uint16.h>
#include <uint32.h>

#define RESULT_OK caml_alloc(1, 0)
#define RESULT_ERROR caml_alloc(1, 1)

static value eunix;

CAMLprim value libsc_initialize(void) {
  CAMLparam0();
  eunix = caml_hash_variant("EUnix");
  CAMLreturn (Val_unit);
}

CAMLprim value libsc_restart(value ifname) {
  CAMLparam1(ifname);
  CAMLlocal2(result, perrno);

  size_t ifnamelen;
  char cifname[16];

  int lerrno, rc;
  lerrno = rc = 0;

  ifnamelen = caml_string_length(ifname);
  if ((ifnamelen + 1) > sizeof(cifname)) {
    lerrno = ENAMETOOLONG;
    goto ERROR;
  }

  // copy string and put terminating \0 at it's end
  memcpy(cifname, String_val(ifname), ifnamelen);
  cifname[ifnamelen] = '\0';

  caml_release_runtime_system();
  rc = can_do_restart(cifname);
  caml_acquire_runtime_system();

  if (0 != rc) {
    lerrno = errno;
    goto ERROR;
  }

  result = RESULT_OK;
  Store_field(result, 0, Val_unit);
  goto END;

ERROR:
  perrno = caml_alloc(2, 0);
  Store_field(perrno, 0, eunix); // `EUnix
  Store_field(perrno, 1, unix_error_of_code(lerrno));

  result = RESULT_ERROR;
  Store_field(result, 0, perrno);

END:
  CAMLreturn(result);
}

