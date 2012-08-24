PRSNEC ;WOIFO/PLT - Correct Release Nurse POC Data ; 08/14/2009  7:56 AM
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT
 ;
ENT ;option entry
 N PRSNCR,PRSNG,PRSNDT,PPI,PRSNDAY,PRSNPP,DFN,PRSNSTS
 ;prsncr="" if poc a/e, =1 if correct release, =eat i from eta post employee time
 S PRSNCR=1
 D ACCESS^PRSNUT02(.A,"E",DT,"")
 I $P($G(A(0)),U,2)="E" D  Q
 .W !,$P(A(0),U,3)
 S PRSNG=A(0)_"^"_$O(A(0))_"^"_A($O(A(0))) K A
Q1 S %DT="AEPX",%DT("A")="Enter Date to Correct Released POC Record: ",%DT("B")="T-1" D ^%DT G:Y<1 EXIT
 S PRSNDT=Y,Y=$G(^PRST(458,"AD",Y)),PPI=$P(Y,"^",1),PRSNDAY=$P(Y,"^",2)
 I PPI="" D EN^DDIOL("Pay Period is Not Open Yet!") G EXIT
 S PRSNPP=$P(^PRST(458,PPI,0),U)_U_$P(^(2),U,PRSNDAY)
 ;selecting a nurse
Q2 S Y=$$PICKNURS^PRSNUT03($P(PRSNG,U,2),$P(PRSNG,U,4)) G Q1:Y<1
 S DFN=+Y
 I $P($G(^PRSN(451,PPI,"E",DFN,0)),U,2)'="R" W !!,"POC Record has a status - ",$S($P($G(^(0)),U,2)="A":"APPROVED",$P($G(^(0)),U,2)="E":"ENTERED",1:"Unknown or no POC data entered")," and it is not released yet!" G Q2
 S PRSNSTS=$P($G(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY,0)),U,2)
 I PRSNSTS="A" W !!,"The Correct Released POC Record has a status - APPROVED, ask Coordinator to",!,"return the record for editing." G Q2
 D CREL G Q2
 ;
EXIT QUIT
 ;
CREL ;start correct released poc time record
 N PRSNVER,PRSNVERO,PRSNX,PRSNEW,PRSNG,PRSNA,PRSNUR,PRSNQ,PRSNLOC,PRSNPC
 ;+prsng=0 in single nurse mode, =1 in alphabetical batch mode
 S $P(PRSNG,U)=0
 S PRSNX="",PRSNEW=""
 L +^PRSN(451,PPI,"E",DFN):0 E  W !!,"File is in use, Try it later!" QUIT
 S PRSNVER=$O(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY,"V",":"),-1)
 I PRSNSTS="E" G EDIT
 S PRSNVERO=PRSNVER,PRSNVER=PRSNVER+1
 I PRSNVERO="" G MISSED
 ;add a new version # in subfile #451.999 in subfile #451.99
 K X,Y
 I '$D(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY,"V",PRSNVER)) S X=PRSNVER D ADD^PRSU1B1(.X,.Y,"451;;"_PPI_"~451.09;;"_DFN_";~451.99;;"_PRSNDAY_";9~451.999;^PRSN(451,PPI,""E"",DFN,""D"",PRSNDAY,""V"",",PRSNVER) S:Y>0 $P(PRSNEW,U,4)=1
 I '$D(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY,"V",PRSNVER)) W !,"Nurse POC file in use, try it later!" G DLOCK
 ;copy (correct) released version 'prsnvero' to a new version 'prsnver'
 S PRSNA=0
 F  S PRSNA=$O(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY,"V",PRSNVERO,"T",PRSNA)) QUIT:'PRSNA  S A=^(PRSNA,0) D
 . N X,Y
 . S X=$P(A,U)
 . S X("DR")="1////"_$P(A,U,2)_";2////"_$P(A,U,3)_";3////"_$P(A,U,4)_";4////"_$P(A,U,5)_";5////"_$P(A,U,6)_";6////"_$P(A,U,7)_";7////"_$P(A,U,8)_";8////"_$P(A,U,9)_";9////"_$P(A,U,10)
 . D ADD^PRSU1B1(.X,.Y,"451;;"_PPI_"~451.09;;"_DFN_"~451.99;;"_PRSNDAY_"~451.999;;"_PRSNVER_";~451.9999;^PRSN(451,PPI,""E"",DFN,""D"",PRSNDAY,""V"",PRSNVER,""T"",",PRSNA)
 . QUIT
 ;
EDIT ;start editing
 D SMAN^PRSNEE
DLOCK L -^PRSN(451,PPI,"E",DFN)
 QUIT
 ;
MISSED ;No previous POC entry before PP was released, needs ETA record for default
 S PRSNX="",PRSNQ="",PRSNUR=$$ISNURSE^PRSNUT01(DFN)
 I 'PRSNUR G DLOCK
 S $P(PRSNUR,U,5)=$$EXTERNAL^DILFD(451.1,3,,$P(PRSNUR,U,4),)
 K PRSNPC
 ;get default time segments array prsnpc of poc time segments from eta
 D ETAPOC^PRSNEE0
 ;
 ;quit if eta posted, poc with eta default but no tour/exceptions
ADD I PRSNPC,PRSNQ!$P(PRSNQ,U,3),$O(PRSNPC(""))="" G DLOCK
 ;add day # in subfile #451.99 in subfile #451.09
 I '$D(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY)) K X,Y S X=PRSNDAY D ADD^PRSU1B1(.X,.Y,"451;;"_PPI_"~451.09;;"_DFN_";9~451.99;^PRSN(451,PPI,""E"",DFN,""D"",",PRSNDAY) S:Y $P(PRSNEW,U,3)=1
 I '$D(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY)) W !,"Nurse POC file in use, try it later!" G DLOCK
 ;add version # in subfile #451.999 in subfile #451.99
 I '$D(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY,"V",PRSNVER)) K X,Y S X=PRSNVER D ADD^PRSU1B1(.X,.Y,"451;;"_PPI_"~451.09;;"_DFN_";~451.99;;"_PRSNDAY_";9~451.999;^PRSN(451,PPI,""E"",DFN,""D"",PRSNDAY,""V"",",PRSNVER) S:Y $P(PRSNEW,U,4)=1
 I '$D(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY,"V",PRSNVER)) W !,"Nurse POC file in use, try it later!" G DLOCK
 G EDIT
 ;
 ;for example (347,14308,3,"")
NURSE(PPI,DFN,PRSNDAY,PRSNDT) ;test one single nurse
 S PRSNCR=1,PRSNEW="",PRSNG=0
 S PRSNPP=$P(^PRST(458,PPI,0),U)_U_$P(^(2),U,PRSNDAY)
 D CREL
 QUIT
 ;
