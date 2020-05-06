set s0_fifo_base 0x40000
set s0_fifo_csr 0x40020
set s1_fifo_base 0x480
set s2_fifo_base 0x400
set s3_fifo_base 0x300
set s4_fifo_base 0x2a0
set s5_fifo_base 0x210
set s6_fifo_base 0x110
set s7_fifo_base 0x90
set s8_fifo_base 0x0

set s1_sf_base 0x490
set s2_sf_base 0x410
set s3_sf_base 0x310
set s4_sf_base 0x280
set s5_sf_base 0x200
set s6_sf_base 0x100
set s7_sf_base 0x80
set s8_sf_base 0x10

set s1_pr_pio 0x10010
set s2_pr_pio 0x10020
set s3_pr_pio 0x10030
set s4_pr_pio 0x10040
set s5_pr_pio 0x10050
set s6_pr_pio 0x10060
set s7_pr_pio 0x10070
set s8_pr_pio 0x10080

set rst_pio 0x20010
################################################################################

set n0 [ lindex [ get_service_paths jtag_debug ] 0] 
open_service jtag_debug $n0
jtag_debug_reset_system $n0
close_service jtag_debug $n0

set n1 [ lindex [ get_service_paths master ] 1] 
open_service master $n1

proc regwr {addr char} {
  global n1
  master_write_32 $n1 $addr $char
}

proc regrd {addr} {
  global n1 
  set rdata [master_read_32 $n1 $addr 1]
  return $rdata
}

proc sector_write {char} {
  global n1
  global s0_fifo_csr
  global s1_fifo_base
  global s2_fifo_base
  global s3_fifo_base
  global s4_fifo_base
  global s5_fifo_base
  global s6_fifo_base
  global s7_fifo_base
  global s8_fifo_base
  
  set data [ regrd $s0_fifo_csr ]
  puts "Sector 0 FIFO Status : $data"
  regwr $s1_fifo_base $char
  puts "Written to sector1 FIFO."
  set data [ regrd $s0_fifo_csr ]
  puts "Sector 0 FIFO Status : $data"
  regwr $s2_fifo_base $char
  puts "Written to sector2 FIFO."
  set data [ regrd $s0_fifo_csr ]
  puts "Sector 0 FIFO Status : $data"
  regwr $s3_fifo_base $char
  puts "Written to sector3 FIFO."
  set data [ regrd $s0_fifo_csr ]
  puts "Sector 0 FIFO Status : $data"
  regwr $s4_fifo_base $char
  puts "Written to sector4 FIFO."
  set data [ regrd $s0_fifo_csr ]
  puts "Sector 0 FIFO Status : $data"
  regwr $s5_fifo_base $char
  puts "Written to sector5 FIFO."
  set data [ regrd $s0_fifo_csr ]
  puts "Sector 0 FIFO Status : $data"
  regwr $s6_fifo_base $char
  puts "Written to sector6 FIFO."
  set data [ regrd $s0_fifo_csr ]
  puts "Sector 0 FIFO Status : $data"
  regwr $s7_fifo_base $char
  puts "Written to sector7 FIFO."
  set data [ regrd $s0_fifo_csr ]
  puts "Sector 0 FIFO Status : $data"
  regwr $s8_fifo_base $char
  puts "Written to sector8 FIFO."
  set data [ regrd $s0_fifo_csr ]
  puts "Sector 0 FIFO Status : $data"
}

proc fiford {num} {
  global n1
  global s0_fifo_base
  global s0_fifo_csr
  for {set oc 0} {$oc<$num} {incr oc} {
    set data [ regrd $s0_fifo_base ]
    puts "FIFO data $oc: $data"
	set data [ regrd $s0_fifo_csr ]
    puts "Sector 0 FIFO Status : $data"
  }
}

proc s1wr {char} {
  global s1_fifo_base 
  regwr $s1_fifo_base $char
  puts "Written $char to sector1."
}

proc s2wr {char} {
  global s2_fifo_base
  regwr $s2_fifo_base $char
  puts "Written $char to sector2."
}

proc s3wr {char} {
  global s3_fifo_base
  regwr $s3_fifo_base $char
  puts "Written $char to sector3."
}

proc s4wr {char} {
  global s4_fifo_base
  regwr $s4_fifo_base $char
  puts "Written $char to sector4."
}

proc s5wr {char} {
  global s5_fifo_base
  regwr $s5_fifo_base $char
  puts "Written $char to sector5."
}

proc s6wr {char} {
  global s6_fifo_base
  regwr $s6_fifo_base $char
  puts "Written $char to sector6."
}

proc s7wr {char} {
  global s7_fifo_base
  regwr $s7_fifo_base $char
  puts "Written $char to sector7."
}

proc s8wr {char} {
  global s8_fifo_base
  regwr $s8_fifo_base $char
  puts "Written $char to sector8."
}

proc s1freeze { } {
  global s1_pr_pio
  global rst_pio
  regwr $s1_pr_pio 0xf
  puts "Sent freeze requests to Sector1 PR Region Controllers."
  regwr $rst_pio 0x2
  puts "Reset Sector1."
}

proc s2freeze { } {
  global s2_pr_pio
  global rst_pio
  regwr $s2_pr_pio 0xf
  puts "Sent freeze requests to Sector2 PR Region Controllers."
  regwr $rst_pio 0x4
  puts "Reset Sector2."
}

proc s3freeze { } {
  global s3_pr_pio
  global rst_pio
  regwr $s3_pr_pio 0xf
  puts "Sent freeze requests to Sector3 PR Region Controllers."
  regwr $rst_pio 0x8
  puts "Reset Sector3."
}

proc s4freeze { } {
  global s4_pr_pio
  global rst_pio
  regwr $s4_pr_pio 0xf
  puts "Sent freeze requests to Sector4 PR Region Controllers."
  regwr $rst_pio 0x10
  puts "Reset Sector4."
}

proc s5freeze { } {
  global s5_pr_pio
  global rst_pio
  regwr $s5_pr_pio 0xf
  puts "Sent freeze requests to Sector5 PR Region Controllers."
  regwr $rst_pio 0x20
  puts "Reset Sector5."
}

proc s6freeze { } {
  global s6_pr_pio
  global rst_pio
  regwr $s6_pr_pio 0xf
  puts "Sent freeze requests to Sector6 PR Region Controllers."
  regwr $rst_pio 0x40
  puts "Reset Sector6."
}

proc s7freeze { } {
  global s7_pr_pio
  global rst_pio
  regwr $s7_pr_pio 0xf
  puts "Sent freeze requests to Sector7 PR Region Controllers." 
  regwr $rst_pio 0x80
  puts "Reset Sector7."
}

proc s8freeze { } {
  global s8_pr_pio
  global rst_pio
  regwr $s8_pr_pio 0xf
  puts "Sent freeze requests to Sector8 PR Region Controllers."
  regwr $rst_pio 0x100
  puts "Reset Sector8."
}

proc s1unfreeze { } {
  global s1_pr_pio
  global rst_pio
  regwr $s1_pr_pio 0x0
  regwr $s1_pr_pio 0xf00
  regwr $s1_pr_pio 0x0
  puts "Sent unfreeze requests to Sector1 PR Region Controllers."
  regwr $rst_pio 0x0
  puts "De-assert reset to Sector1."
}

proc s2unfreeze { } {
  global s2_pr_pio
  global rst_pio
  regwr $s2_pr_pio 0x0
  regwr $s2_pr_pio 0xf00
  regwr $s2_pr_pio 0x0
  puts "Sent unfreeze requests to Sector2 PR Region Controllers."
  regwr $rst_pio 0x0
  puts "De-assert reset to Sector2."
}

proc s3unfreeze { } {
  global s3_pr_pio
  global rst_pio
  regwr $s3_pr_pio 0x0
  regwr $s3_pr_pio 0xf00
  regwr $s3_pr_pio 0x0
  puts "Sent unfreeze requests to Sector3 PR Region Controllers."
  regwr $rst_pio 0x0
  puts "De-assert reset to Sector3."
}

proc s4unfreeze { } {
  global s4_pr_pio
  global rst_pio
  regwr $s4_pr_pio 0x0
  regwr $s4_pr_pio 0xf00
  regwr $s4_pr_pio 0x0
  puts "Sent unfreeze requests to Sector4 PR Region Controllers."
  regwr $rst_pio 0x0
  puts "De-assert reset to Sector4."
}

proc s5unfreeze { } {
  global s5_pr_pio
  global rst_pio
  regwr $s5_pr_pio 0x0
  regwr $s5_pr_pio 0xf00
  regwr $s5_pr_pio 0x0
  puts "Sent unfreeze requests to Sector5 PR Region Controllers."
  regwr $rst_pio 0x0
  puts "De-assert reset to Sector5."
}

proc s6unfreeze { } {
  global s6_pr_pio
  global rst_pio
  regwr $s6_pr_pio 0x0
  regwr $s6_pr_pio 0xf00
  regwr $s6_pr_pio 0x0
  puts "Sent unfreeze requests to Sector6 PR Region Controllers."
  regwr $rst_pio 0x0
  puts "De-assert reset to Sector6."
}

proc s7unfreeze { } {
  global s7_pr_pio
  global rst_pio
  regwr $s7_pr_pio 0x0
  regwr $s7_pr_pio 0xf00
  regwr $s7_pr_pio 0x0
  puts "Sent unfreeze requests to Sector7 PR Region Controllers."
  regwr $rst_pio 0x0
  puts "De-assert reset to Sector7."
}

proc s8unfreeze { } {
  global s8_pr_pio
  global rst_pio
  regwr $s8_pr_pio 0x0
  regwr $s8_pr_pio 0xf00
  regwr $s8_pr_pio 0x0
  puts "Sent unfreeze requests to Sector8 PR Region Controllers."
  regwr $rst_pio 0x0
  puts "De-assert reset to Sector8."
}

proc s1filter { char } {
  global s1_sf_base
  regwr $s1_sf_base $char
  puts "Written $char to sector1 security filter."
}

proc s2filter { char } {
  global s2_sf_base
  regwr $s2_sf_base $char
  puts "Written $char to sector2 security filter."
}

proc s3filter { char } {
  global s3_sf_base
  regwr $s3_sf_base $char
  puts "Written $char to sector3 security filter."
}

proc s4filter { char } {
  global s4_sf_base
  regwr $s4_sf_base $char
  puts "Written $char to sector4 security filter."
}

proc s5filter { char } {
  global s5_sf_base
  regwr $s5_sf_base $char
  puts "Written $char to sector5 security filter."
}

proc s6filter { char } {
  global s6_sf_base
  regwr $s6_sf_base $char
  puts "Written $char to sector6 security filter."
}

proc s7filter { char } {
  global s7_sf_base
  regwr $s7_sf_base $char
  puts "Written $char to sector7 security filter."
}

proc s8filter { char } {
  global s8_sf_base
  regwr $s8_sf_base $char
  puts "Written $char to sector8 security filter."
}
