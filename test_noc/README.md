# Design Compilation
1. Open Quartus project file test_noc.qpf and change to test_noc revision (base revision) if it's not already loaded.
2. Open system.qsys in Platform Designer and generate HDL.
3. Perform full design compilation in Quartus. This might take ~1 hour.
4. Export Design Partition of base revision for other project revisions:- 
	* Export final snapshot of root_partition as test_noc_static.qdb
	* Export final snapshot of s1_parent_partition as s1_parent_partition_default_final.qdb     	* Export final snapshot of s2_parent_partition as s2_parent_partition_default_final.qdb 
	* Export final snapshot of s3_parent_partition as s3_parent_partition_default_final.qdb 
	* Export final snapshot of s4_parent_partition as s4_parent_partition_default_final.qdb 
	* Export final snapshot of s5_parent_partition as s5_parent_partition_default_final.qdb 
	* Export final snapshot of s6_parent_partition as s6_parent_partition_default_final.qdb 
	* Export final snapshot of s7_parent_partition as s7_parent_partition_default_final.qdb 
	* Export final snapshot of s8_parent_partition as s8_parent_partition_default_final.qdb 
* This step must be repeated everytime the base revision is recompiled. 
5. Switch to test_noc_v1 revision. Perform full design compilation. 
6. Repeat for test_noc_v2 and test_noc_bad revisions. 
