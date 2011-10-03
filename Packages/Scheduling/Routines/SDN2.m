SDN2 ;ALB/CAW - Misc. No-Show Utilities; 4/28/92
 ;;5.3;Scheduling;**445**;Aug 13, 1993
 ;
NS ; Cancel inpatient appt when no-showed
 ;
 W !,*7,"Inpatient Appointments cannot reflect No-Show status!"
 Q
 D UPDT(I)
 W !!,"...OK    New Status: ",$P($$STATUS^SDAM1(DFN,I,SC,^DPT(DFN,"S",I,0)),";",3)
 S $P(^DPT(DFN,"S",I,0),U,15)=$O(^SD(409.2,"B","INPATIENT STATUS",0))
 Q
UPDT(SD) ; Event Driver and pattern update
 N DA,DIV,HSI1,I,S,SB1,SCI,SD1,SD17,SDDIF1,SDQ,SDRT,SDNSF,SDATA,SDPL,SDSC,SDSY,SDSX,SDTIME,SDTTM,SI1,SL1,SS,ST,STR
 S S=SD,I=SC,SDNSF=1,STR="#@!$* XXWVUTSRQPONMLKJIHGFEDCBA0123456789jklmnopqrstuvwxyz"
 D STAT^SDM2,CAN^SDM2
 Q
