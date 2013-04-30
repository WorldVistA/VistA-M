SCMCPRE ;ALB/REW - PCMM Post-init ; 2 May 1996
 ;;5.3;Scheduling;**41**;AUG 13, 1993
EN ;
 D MESS("PCMM Pre-init Actions:","!")
 D MESS("  ...done")
 Q
 ;
MESS(TEXT,FORMAT) ;
 S TEXT=$G(TEXT,"")
 S FORMAT=$G(FORMAT,"!")
 D EN^DDIOL(TEXT,"",FORMAT)
 Q
KILLFILE(FILE) ;
 N DIU
 D MESS("Deleting File "_FILE,"!")
 S DIU(0)="D"
 S DIU=FILE
 D EN^DIU2
 Q
 ;
