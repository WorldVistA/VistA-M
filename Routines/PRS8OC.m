PRS8OC ;HISC/MGD-DECOMPOSITION, ON-CALL ;02/27/07
 ;;4.0;PAID;**63,92,112,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;The following MUMPS code is used to credit the appropriate
 ;categories on the timecard for work performed while On-Call.
 ;All hours during which an individual is identified as being
 ;On-Call are credited to blocks YD and YH (On Call Hrs) on
 ;the timecard.  Hours during an On-Call episode where an
 ;individual is actually called in to perform work are credited
 ;to blocks YA and YE (Sch CB OT) as appropriate.  This credit
 ;is given under the 2-hour minimum rule.  When OT work is
 ;performed during On-Call the actual On-Call Hours reported
 ;are reduced by the ACTUAL number of hours worked (not by the
 ;2-hour minimum).
 ;
 ;Called by Routines: PRS8ST
 ;
 ;C = On-Call
 ;c = OT during OC
 ;t = CT during OC
 ;
 S (I,D)=$S(T'>96:DAY,1:(DAY+1))
 S OC=$G(OC),OC(DAY)=$G(OC(DAY)),OC(DAY+1)=$G(OC(DAY+1)) ;oc variables
 S CC=$G(CC),CC(DAY)=$G(CC(DAY)),CC(DAY+1)=$G(CC(DAY+1)) ;CT on OC count
 S Y=35,Y(1)=1 D SET
 I VAR1="C" D:OC!(CC) OCS ;on-call episode (ot OR ct)
 S:"ct"[VAR1 OC=OC+1,OC(D)=OC(D)+1 S:VAR1="t" CC=CC+1,CC(D)=CC(D)+1
 I "ct"[VAR1,DAY>0,DAY<15 S CBCK(WK)=CBCK(WK)+1 ;count actual CB hrs
 Q:'OK!('$D(OC))
 I OC S Y=23 D OCS ;get rest of them
 K OC,CC,Y,D Q
 ;
OCS ; --- set On-Call minimum hours
 ;set YA/YE for PPI="W" or "V" else set OT
 I +NAWS=0 S Y=$S(CC:7,'DOUB:TOUR+19,1:23)
 I +NAWS S Y=$S(CC:7,1:TOUR+19)
 ;
 N X,Z,DD,TT,CCCNT,NEXTT,OCCNT,TIMECNT
 S TT=$S(T>96:T-96,1:T),TIMECNT=0
 S X=$E(DAY($S(T>96:DAY+1,1:DAY),"W"),TT)
 ;
 ; If the current segment is the last of the On-Call OR the last of
 ; the On-Call Callback and the next time segment is Unavailable ("-")
 ; or not a type of work ("0") check to see if OT/reg sched is prior
 ; to on call worked.
 ;
 S NEXTT=$S(T+1>96:T-95,1:TT+1) ; Next time segment
 I "C"[X!(("ct"[X)&("-0"[$E($S(T+1>96:DAY(DAY+1,"W"),1:DAY(DAY,"W")),NEXTT))) D
 .K XH S X=0 F Z=1:1:8-(OC(DAY)+$G(OC(DAY+1))) D  Q:"01"[X
 ..S DD=OC(DAY)+OC(DAY+1)+Z
 ..I TT-DD>0 S X=$E(DAY(DAY,"W"),TT-DD) S:X="O"&($E(DAY(DAY,"HOL"),TT-DD)=2) X="h"
 ..E  S X=$E(DAY(DAY-1,"W"),96+T-DD) S:X="O"&($E(DAY(DAY-1,"HOL"),96+T-DD)=2) X="h"
 ..I "123nHMLSWNARXYFGDUZq"[X S X=1 Q  ; on call abuts a reg sched TOD.
 ..E  I "EOhoscteQ"[X D  ; on call abuts time worked outside posted TOD.
 ...I "ct"'[X S TIMECNT=TIMECNT+1 ; Time already counted in WK(). 
 ...S XH=$S(X'="h":0,1:1),X=2
 ..E  S X=0
 ..Q
 .Q
 E  D  ; Check to see if OT/reg sched is after on call worked
 .K XH S X=0 F Z=1:1:8-(OC(DAY)+$G(OC(DAY+1))) D  Q:"01"[X
 ..S DD=OC(DAY)+OC(DAY+1)+Z
 ..I T+Z'>96 S X=$E(DAY(DAY,"W"),T+Z) S:X="O"&($E(DAY(DAY,"HOL"),T+Z)=2) X="h"
 ..E  S X=$E(DAY(DAY+1,"W"),T-96+Z) S:X="O"&($E(DAY(DAY+1,"HOL"),T-96+Z)=2) X="h"
 ..I "123nHMLSWNARXYFGDUZq"[X S X=1 Q  ; on call abuts a reg sched TOD.
 ..E  I "EOhoscteQ"[X D
 ...I "ct"'[X S TIMECNT=TIMECNT+1 ; Time already counted in WK(). 
 ...S XH=$S(X'="h":0,1:1),X=2
 ..E  S X=0
 ..Q
 .Q
 I $G(XH)'="" S:XH=1!'X Z=Z-1,X=2
 ;
 ; Check if Scheduled Call-Back OT crosses Midnight
 ;
 I '$D(CRSMID(D)),$E(DAY(DAY,"W"),1)="c",$E(DAY(DAY-1,"W"),96)="c" S FG=0 D  Q:FG=1
 .S CRSMID(D)=1
 .I OC<7 D  Q:FG=1
 ..; crosses midnight, check if its <2 hours, CRSMID variable set to 
 ..; only do on segment that cross mid, not others
 ..S CNTR=0 F CX=1:1:8-OC S:$E(DAY(DAY-1,"W"),97-CX)="c" CNTR=CNTR+1
 ..I OC+CNTR'>8 D
 ...S Y(1)=$S(X=1:OC,1:8-CNTR)
 ...I +NAWS=0 D CHOL ; Process everyone but AWS nurses
 ...I +NAWS D CHOL1 ; Process AWS nurses
 ...S (OC,OC(D),CC,CC(D))=0,FG=1
 ..Q
 ;
 ; Check if Comp Time crosses Midnight
 ;
 I '$D(CRSMID(D)),$E(DAY(DAY,"W"),1)="t",$E(DAY(DAY-1,"W"),96)="t" S FG=0 D  Q:FG=1
 .S CRSMID(D)=1
 .I OC<7 D  Q:FG=1
 ..; crosses midnight, check if its <2 hours, CRSMID variable set to 
 ..; only do on segment that cross mid, not others
 ..S CNTR=0 F CX=1:1:8-OC S:$E(DAY(DAY-1,"W"),97-CX)="t" CNTR=CNTR+1
 ..I OC+CNTR'>8 D
 ...S Y(1)=$S(X=1:OC,1:8-CNTR)
 ...I +NAWS=0 D CHOL ; Process everyone but AWS nurses
 ...I +NAWS D CHOL1 ; Process AWS nurses
 ...S (OC,OC(D),CC,CC(D))=0,FG=1
 ..Q
 ;
 I CC>0,CC<OC D  ;SPLIT SEGMENT, MUST DO TWICE (FOR CT THEN FOR OT)
 .F I=DAY:1:(DAY+1) I OC(I) D
 ..S (OCCNT,CCCNT)=0
 ..I X=2,OC(I)+TIMECNT<8 D   ; Add time if 2 hour minimum was not met.
 ...S TIMECNT=8-OC(I)-TIMECNT ; Amount of time short of the 2 hour min.
 ...;
 ...; If TIMECNT is an even number divide needed time equally among the
 ...; CT and OT.
 ...I TIMECNT#2=0 S CCCNT=TIMECNT/2,OCCNT=TIMECNT/2
 ...;
 ...; If TIMECNT is not an even number divide the time needed as equally
 ...; as possible among the CT and OT w/ remaining 15 minutes going to OC.
 ...I TIMECNT#2=1 S CCCNT=TIMECNT\2,OCCNT=(TIMECNT\2)+1
 ...;
 ..S Y(1)=$S(X=2:CC(I)+CCCNT,X:CC(I),OC(I)>7:CC(I),1:4),Y=7
 ..I +NAWS=0 D CHOL ; Process everyone but AWS nurses
 ..I +NAWS D CHOL1 ; Process AWS nurses
 ..S Y(1)=$S(X=2:OC(I)-CC(I)+OCCNT,X:OC(I)-CC(I),OC(I)>7:OC(I)-CC(I),1:4)
 ..S Y=$S('DOUB:TOUR+19,1:23)
 ..I +NAWS=0 D CHOL ; Process everyone but AWS nurses
 ..I +NAWS D CHOL1 ; Process AWS nurses
 ..Q
 .Q
 E  D  ;NOT SPLIT SEGMENT
 .F I=DAY:1:(DAY+1) I OC(I) D
 ..I OC(I)<8,X=2 D
 ...I T'=96 S OC(I)=8-TIMECNT
 ...I T=96,"ct"'[$E(DAY(DAY+1,"W"),1) S OC(I)=8-TIMECNT
 ..S Y(1)=$S(X:OC(I),OC(I)>7:OC(I),1:8)
 ..I +NAWS=0 D CHOL ; Process everyone but AWS nurses
 ..I +NAWS D CHOL1 ; Process AWS nurses
 ..Q
 .Q
 K OC,CC Q
 ;
CHOL ; --- Check for Holiday Callback
 S TMP=Y,Y=0
 ; Don't convert Overtime to Comptime
 I TMP'=7,$E(ENT,25),$$HOLIDAY^PRS8UT(PY,DFN,+D) S Y=24 ;ot on actual hol
 I 'Y,$E($G(DAY(I,"HOL")),$S(T>96:(T-96),1:T)) S Y=TOUR+28 ;holiday callback
 I 'Y S Y=TMP
 D SET S Y=$S(CC:7,'DOUB:TOUR+19,1:23)
 Q
 ;
SET ; --- set WK array
 S W=$S(I<8:1,1:2)
 I I<1!(I>14) Q
 I Y(1)>32,'DOUB,$P(C0,"^",12)="N",Y'=7 D
 .S $P(WK(W),"^",TOUR+15)=$P(WK(W),"^",TOUR+15)+(Y(1)-32)
 .S $P(WK(W),"^",Y)=$P(WK(W),"^",Y)+32 ;if FLSA=N set >8 = DA
 E  S $P(WK(W),"^",Y)=$P(WK(W),"^",Y)+Y(1)
 Q
 ;
CHOL1 ; Checks for AWS nurses
 N HT,J,K,T2ADD
 S K=0,TMP=Y,Y=0
 S T2ADD=$S(CC:Y(1)-CC,1:Y(1)-OC-CC)
 ; Apply normal checks for OT on Hol and Hol Callback
 I TMP'=7,$E(ENT,25),$$HOLIDAY^PRS8UT(PY,DFN,+D) S Y=24 ;ot on actual hol
 I 'Y,$E($G(DAY(I,"HOL")),$S(T>96:(T-96),1:T)) S Y=TOUR+28 ;holiday callback
 I 'Y S Y=TMP
 I Y=24!(Y=(TOUR+28)) D SET Q
 ; If not OT on Hol or Hol Callback Determine if we are setting OT or CT
 S K=$S(Y=7:CC,1:OC)
 F J=1:1:K D AWSWK ; Update actual time worked
 F J=1:1:T2ADD D AWSWK ; Update time added to reach 2 hour min
 Q
 ;
AWSWK ; Determine what type of time to add based on 8/day and 40/wk
 S HT=+$G(^TMP($J,"PRS8",D,"HT"))
 I HT'<32 S Y=$S(Y'=7:TOUR+15,1:Y) D SET1 Q
 I TH(W)'<160 S Y=$S(Y'=7:TOUR+19,1:Y) D SET1 Q
 I HT<32,TH(W)<160 S Y=9 D SET1
 Q
 ;
SET1 ; Set WK array for AWS nurses
 S $P(WK(W),"^",Y)=$P(WK(W),"^",Y)+1
 Q:HT'<32
 S TH=TH+1,TH(WK)=TH(WK)+1
 S ^TMP($J,"PRS8",DAY,"HT")=HT+1
 Q
