SDECPAT1 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ; BEN:
 ;   Input - DFN
 ;   Output - 1 = Yes
 ;            0 = No
 ;           -1 = No/old tribe or unable.
 ;
BEN(DFN) ;PEP - Return BEN/Non-BEN Status.
 I '$G(DFN) Q -1
 I '$D(^AUPNPAT(DFN)) Q -1
 NEW AUPN,AUPNTR,Y,X
 S Y=1
 D ENP^SDECDIQ1(9000001,DFN,"1108;1109.9;1111","AUPN(","I")
 I AUPN(1108,"I")'>0 Q -1 ;no tribe
 D ENP^SDECDIQ1(9999999.03,AUPN(1108,"I"),".04;.02","AUPNTR(")
 I AUPNTR(.04)="YES" Q -1 ;old tribe code
 F X="000","970" I AUPNTR(.02)=X S Y=0 Q  ;non-indian tribes
 I 'Y Q Y
 I 999=AUPNTR(.02),AUPN(1109.9)>0 Q 1 ;unspecified ,Quantum>0
 Q Y
 ;
