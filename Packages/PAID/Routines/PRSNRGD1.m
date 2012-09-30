PRSNRGD1 ;WOIFO/KJS - Nursing LOCATION DETAIL Report II;08022011
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
DSPLY(PRSIEN,NURSE,STOP) ; Entry point to gather POC Nurse 
 ;                         Education Data from file 450
 ;INPUT:
 ;   PRSIEN: Nurse ien 450
 ;   BEG,END: FileMan begin and end dates for report
 ;
 D INFO^PRSNRAS1
 N INDEX,CNT
 S (INDEX,CNT)=0
 D DATA(PRSIEN,NURSE,.STOP)
 ;
 K PRSNAME,PRSNSSN,PRSNTL,SKILMIX,ROLE,PRSNLNG,PRSNTWD,PRSNPOC1,PRSDY
 K PPIEN,PRSL,PRSNDAY,STARTDT,STDE,BOC,OCC,ASN,EDU,YEAR
 Q
 ;
 ;
HDR ;Display header
 ;
 W @IOF
 S PG=PG+1
 W "Nursing Location Detail Report"
 W ?45,"Run Date: ",$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3),"  Page: ",$J(PG,3)
 W !!,"Nurse Name",?21,"SSN",?27,"Nurse Role",?48,"BOC",?52,"OCC",?58,"CC",?64,"Assign",?75,"Nurse"
 W !,?64,"Code",?76,"FTEE"
 W !,"--------------------------------------------------------------------------------"
 ;
 QUIT
 ;
DATA(PRSIEN,NURSE,STOP) ;Extract display data from POCD array and get external date
 ;
 N JOB,ED,A,B,PRSNA,ROLE
 S (BOC,OCC,ASN,EDU,YEAR)=0
 ;
 S ROLE=$P($G(NURSE),U,2)
 S JOB=$$GETCODES^PRSNUT01(PRSIEN)    ;Job codes
 S BOC=$P(JOB,U)
 S OCC=$P(JOB,U,2)
 S ASN=$P(JOB,U,3)
 S CC=$P(JOB,U,4)
 S PRSNA=^PRSPC(PRSIEN,0),YEAR=$P(PRSNA,U,31) S:YEAR YEAR=$E(DT,1,3)-$E(YEAR,1,3)
 S A=$P(PRSNA,U,29),B=$L(A),$P(PRSNA,U,29)=$S(A<1000:A,1:$E(A,1,B-6)_","_$E(A,B-5,B))
 S A=$P(PRSNA,U,28),$P(PRSNA,U,28)=$E(A,4,5)_"/"_$E(A,6,7)_"/"_$E(A,2,3)
 S NORHRS=$P(PRSNA,U,16)
 S FTEE=NORHRS/80,TOTFTEE=TOTFTEE+FTEE,TOTNUR=TOTNUR+1
 D PRT
 ;
 QUIT
 ;
PRT ;
 W !,$E(PRSNAME,1,19),?21,$E(PRSNSSN,6,9),?27,$E(ROLE,1,19),?48,BOC,?52,OCC,?58,CC,?64,ASN,?76,$J(FTEE,4,2)
 ;
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDR
 Q
