SPNPRI18 ;SD/WDE/Post action for patch 18 12/2/2002 14:23
 ;;2.0;Spinal Cord Dysfunction;**18**;01/02/1997
 ;
EN ;
 S SPNDFN=0 F  S SPNDFN=$O(^SPNL(154,SPNDFN)) Q:'+SPNDFN  D DOD
ZAP ;
 K SPNDFN
 Q
DOD ;
 ;date of death update
 D LOOP^SPNDODCK(SPNDFN) ; Update Reg Status based on DOD file 2
 D LOOP2^SPNDODCK(SPNDFN) ; Updating Reg Status
 Q
