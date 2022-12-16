# Sector-Oriented-Partial-Reconfiguration-Demonstrator

> :warning: **DISCONTINUATION OF PROJECT** - 
> *This project will no longer be maintained by Intel.
> Intel has ceased development and contributions including, but not limited to, maintenance, bug fixes, new releases, or updates, to this project.*
> **Intel no longer accepts patches to this project.**
> *If you have an ongoing need to use this project, are interested in independently developing it, or would like to maintain patches for the open source software community, please create your own fork of this project.*



Software Requirement: Intel® Quartus® Prime Design Suite 18.0.0/219

Target Device: Stratix 10 H-tile ES1 1SG280HU2F50E2VGS1

This is a 9-sector 3x3 NoC design, where data master of a sector can send packets to any other 8 sectors by forwarding to neighbour sectors. In this version, each sector has customized number of north, east, south, west and local ports, where address widths of the ports vary for each sector. No manual control of address span extender involved.

Origin data master (Nios II Processor) can communicated to any sector by writing to the address of the slave (FIFO). The longer the data path, the more sectors the packet will be rerouted to, as each sector can only communicate with its immediate north/east/south/west neighbour.
