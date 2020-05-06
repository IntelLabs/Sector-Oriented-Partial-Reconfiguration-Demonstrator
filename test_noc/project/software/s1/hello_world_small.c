/*
  Copyright (C) 2020 Intel Corporation

  SPDX-License-Identifier: MIT
*/

#include "sys/alt_stdio.h"
#include "HAL/inc/io.h"
#include "system.h"
#include <unistd.h>

int main()
{ 
  int fifo = 0;
  int data = 0;
  int id = 0;
  int status = 0;
  /* Event loop never exits. */
  while (1){

  status = IORD_32DIRECT(0x40020, 0);
  if (status > 0) {
	  fifo = IORD_32DIRECT(0x40000, 0);
	  fifo = fifo & 0x0000FFFF;
	  id = IORD_32DIRECT(0x100000, 0);
	  //write sys id + data to sector0
	  data = id << 16;
	  data = data | fifo;
	  IOWR_32DIRECT(0x00, 0, data);
  }
  usleep(1000);
  }

  return 0;
}
