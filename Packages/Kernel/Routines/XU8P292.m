XU8P292 ;ALB/BRM,OIFO/SO - XU*8*292 PRE-INSTALL TO DELETE 5.12 & 5.13 ;5:39 AM  24 Jun 2003
 ;;8.0;KERNEL;**292**;Jul 10, 1995
 ;
PRE ; pre-install - kill existing 5.12 and 5.13 files
 ;
 N DIU
 S DIU="^XIP(5.12,",DIU(0)="D" D EN^DIU2  ;IA #10014
 S DIU="^XIP(5.13,",DIU(0)="D" D EN^DIU2  ;IA #10014
 Q
