XU8P685 ;BP/BDT - Post-Install for XU*8*685
 ;;8.0;KERNEL;**685**;Jul 10, 1995;Build 2
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;  Post Installation Routine for patch XU*8.0*685
POST ;
 N XU685
 D PATCH^ZTMGRSET(685)
 Q
