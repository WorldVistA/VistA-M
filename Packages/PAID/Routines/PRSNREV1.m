PRSNREV1 ;WOIFO/DAM - Nursing Education Validation Report II;060409
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
DSPLY(PRSIEN,PRSNOPT,NURSE,STOP) ; Entry point to gather POC Nurse 
 ;                         Education Data from file 450
 ;INPUT:
 ;   PRSIEN: Nurse ien 450
 ;   BEG,END: FileMan begin and end dates for report
 ;
 D INFO^PRSNRAS1
 N INDEX,CNT
 S (INDEX,CNT)=0
 D DATA(PRSIEN,PRSNOPT,NURSE,.STOP)
 ;
 K PRSNAME,PRSNSSN,PRSNTL,SKILMIX,ROLE,PRSNLNG,PRSNTWD,PRSNPOC1,PRSDY
 K PPIEN,PRSL,PRSNDAY,STARTDT,STDE,BOC,OCC,ASN,EDU,YEAR
 Q
 ;
 ;
HDR(PRSNOPT) ;Display header
 ;
 W @IOF
 S PG=PG+1
 W $P("Nursing Education Validation Report^Nurse Position and Pay Information",U,PRSNOPT)," Report"
 W "   Run Date: ",$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3),"  Page: ",$J(PG,3)
 ;nurse education validation
 I PRSNOPT=1 D
 . W !!,"Nurse Name",?21,"BOC/",?27,"Assignment Code",?47,"PAID Education Level"
 . W !,"Last 4 SSN",?21,"OCC",?27,"Nurse Role",?47,"Year Degree Earned"
 . QUIT
 ;nurse position and pay
 E  D
 . W !!,"Nurse Name",?21,"BOC/",?27,"Assignment Code",?47,"Grade/Step",?60,"Salary"
 . W !,"Last 4 SSN",?13,"CC",?21,"OCC",?27,"Nurse Role",?47,"Yr. of Ser.",?60,"Salary Start Date"
 . QUIT
 W !,"--------------------------------------------------------------------------------"
 ;
 QUIT
 ;
DATA(PRSIEN,PRSNOPT,NURSE,STOP) ;Extract display data from POCD array and get external date
 ;
 N JOB,ED,A,B,PRSNA,ROLE
 S (BOC,OCC,ASN,EDU,YEAR)=0
 ;
 S ROLE=$P($G(NURSE),U,2)
 S JOB=$$GETCODES^PRSNUT01(PRSIEN)    ;Job codes
 S BOC=$P(JOB,U)
 S OCC=$P(JOB,U,2)
 S ASN=$P(JOB,U,7)  ;External value of job assignment code
 ;nurse education validation
 I PRSNOPT=1 D
 . S ED=$$GETDEG^PRSNUT01(PRSIEN)   ;Education level & year degree earned
 . S EDU=$P(ED,U)
 . S YEAR=$P(ED,U,2)
 . QUIT
 ;nurse position and pay
 I PRSNOPT=2 D
 . S PRSNA=^PRSPC(PRSIEN,0),YEAR=$P(PRSNA,U,31) S:YEAR YEAR=$E(DT,1,3)-$E(YEAR,1,3)
 . S A=$P(PRSNA,U,29),B=$L(A),$P(PRSNA,U,29)=$S(A<1000:A,1:$E(A,1,B-6)_","_$E(A,B-5,B))
 . S A=$P(PRSNA,U,28),$P(PRSNA,U,28)=$E(A,4,5)_"/"_$E(A,6,7)_"/"_$E(A,2,3)
 . QUIT
 D PRT(PRSNOPT)
 ;
 QUIT
 ;
PRT(PRSNOPT) ;
 ;print education vaidation report
 I PRSNOPT=1 D
 . W !!,$E(PRSNAME,1,19),?21,BOC,"/",?27,$E(ASN,1,19),?47,$E(EDU,1,30)
 . W !,$E(PRSNSSN,6,9),?21,OCC,?27,$E(ROLE,1,19),?47,YEAR
 ;print position and pay report
 E  D
 .  W !!,$E(PRSNAME,1,19),?21,BOC,"/",?27,$E(ASN,1,19),?47,$P(PRSNA,U,14),"-",$P(PRSNA,U,39),?60,"$",$P(PRSNA,U,29)
 .  W !,$E(PRSNSSN,6,9),?13,$P(JOB,U,4),?21,OCC,?27,$E(ROLE,1,19),?49,YEAR,?60,$P(PRSNA,U,28)
 ;
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDR(PRSNOPT)
 Q
