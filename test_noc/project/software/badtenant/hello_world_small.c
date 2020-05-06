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
	 while (1){

	  IOWR_32DIRECT(0x00, 0, 0xffffffff);
	  usleep(5000000);
	 }


  return 0;
}
