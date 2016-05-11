SDECPTPC ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ;=================================================================
USESD() Q 1   ;$G(DUZ("AG"))'="I"
 ; Get the primary provider
OUTPTPR(DFN) ;EP
 Q $$OUTPTPR^SDUTL3(DFN)
 ;N PCP
 ;S PCP=$$GET1^DIQ(9000001,DFN,.14,"I")
 ;Q $S(PCP:PCP_U_$P(^VA(200,PCP,0),U),1:"")
 ; Get team
OUTPTTM(DFN) ;EP
 Q $$OUTPTTM^SDUTL3(DFN)
