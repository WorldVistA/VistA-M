IBCNSU3 ;ALB/TMP - Functions for billing decisions; 08-AUG-95
 ;;2.0;INTEGRATED BILLING;**43,80**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PTCOV(DFN,IBVDT,IBCAT,ANYINS) ; Determine if patient is covered for coverage category on a visit dt
 ; Function returns 1 if covered, 0 if not covered
 ; DFN - ifn of patient (req)
 ; IBVDT - fileman format visit date (req)
 ; IBCAT - entry in file 355.31 limitation of coverage category (req)
 ; ANYINS - optional parameter, but if passed by reference, returns 0 if
 ;         no active insurance at all and 1 if any active insurance found
 N IBCOV,IBDD,PLAN,POLCY
 S (IBCOV,ANYINS)=0
 I $G(DFN)=""!($G(IBCAT)="")!($G(IBVDT)="") G PTCOVQ ; Required fields not present
 S IBCAT=$O(^IBE(355.31,"B",IBCAT,"")) G:IBCAT="" PTCOVQ
 S IBVDT=IBVDT\1
 D ALL^IBCNS1(DFN,"IBDD",1,IBVDT) ;All active ins policies returned in IBDD array
 S ANYINS=($O(IBDD(0))'="") ;Set flag for any active insurance found
 S POLCY=0 F  S POLCY=$O(IBDD(POLCY)) Q:'POLCY  D  Q:IBCOV
 .S PLAN=$P($G(IBDD(POLCY,0)),U,18) Q:PLAN=""
 .S IBCOV=$$PLCOV(PLAN,IBVDT,IBCAT)
 .I 'IBCOV,$D(^IBA(355.7,"APP",DFN,POLCY,+$P($G(^IBE(355.31,+IBCAT,0)),U,3)))'=0 S IBCOV=1
PTCOVQ Q IBCOV
 ;
PLCOV(IBPL,IBVDT,IBCAT,COMMENT) ; Determine if a specific plan covers a category of coverage as of a date and returns comments
 ; IBPL - pointer to file 355.3 group insurance plan (req)
 ; IBVDT - fileman format visit date (req)
 ; IBCAT -  pointer to file 355.31 limitation of coverage category (req)
 ; COMMENT - if passed by reference and the coverage is conditional will contain limitation comments
 N CATLIM,X,Y K COMMENT
 S CATLIM=$O(^IBA(355.32,"APCD",IBPL,IBCAT,+$O(^IBA(355.32,"APCD",IBPL,IBCAT,-(IBVDT+1))),""))
 S X=$S(CATLIM="":1,1:+$P($G(^IBA(355.32,CATLIM,0)),U,4))
 I X>1 S COMMENT=CATLIM,Y=0 F  S Y=$O(^IBA(355.32,CATLIM,2,Y)) Q:'Y  S COMMENT(Y)=$G(^IBA(355.32,CATLIM,2,Y,0))
 Q X
 ;
RIDERS(DFN,IBCDFN,RIDERS) ; Returns all Riders (355.7) associated with a patient's policy in array if RIDERS is passed by reference
 N Y K RIDERS
 I +$G(DFN),+$G(IBCDFN) S Y=0 F  S Y=$O(^IBA(355.7,"APP",DFN,IBCDFN,Y)) Q:'Y  S RIDERS(Y)=$P($G(^IBE(355.6,Y,0)),U,1)
 Q
