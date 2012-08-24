ICD1824P   ;;ALB/JAT - 2007 FY DRG GROUPER UPDATE; 7/27/05 14:50
 ;;18.0;DRG Grouper;**24**;Oct 13,2000;Build 5
 ;       
 Q
 ;
EN ;
 ; add/update/inactivate DRG code file 80.2
 D ADDDRG^ICD1824A
 ; update operation/procedure code file 80.1
 D PRO^ICD1824A
 ; update diagnosis code file 80
 D DIAG^ICD1824C
 ; do DRG reclassification changes
 D DIAG^ICD1824N
 D GI^ICD1824G
 D PRO^ICD1824O
 D ID^ICD1824O
 S ^DD(80,0,"VRRV")="24^3061001"
 S ^DD(80.1,0,"VRRV")="24^3061001"
 S ^DD(80.2,0,"VRRV")="24^3061001"
 Q
