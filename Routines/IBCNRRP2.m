IBCNRRP2 ;DAOU/CMW - IBCNR GROUP PLAN WORKSHEET COMPILE ;03-MAR-2004
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; ePHARM GROUP PLAN WORKSHEET REPORT
 ;
 ; Input variables from IBCNRRP1:
 ;   IBCNRRTN = "IBCNRRP1"
 ;   IBCNRSPC("BEGDT") = Start Date for date range
 ;   IBCNRSPC("ENDDT") = End Date for date range
 ;   IBCNRSPC("SORT") = 1 - By Insurance/Group; 2 - Total Claims
 ;                      3 - Total Charges; 4 - BIN/PCN Exceptions
 ; Output variables passed to IBCNRRP3:
 ;   ^XTMP(IBCNRRTN)
 ; Must call at EN tag
 Q
 ;
EN(IBCNRRTN,IBCNRSPC) ; Entry point
 ;
 ; Initialize variables
 N IBCNRDT,IBCNRDT1,IBCNRDT2,IBCNRPY,IBCNRPYR,IBCNRPTR
 N IBCNRTOT,IBCNRSRT,RPTDATA,IEN,IBCNRRUN
 N IBPNM,IBPIEN,ERR,PC,PYR,IBCNRBCI
 ;
 I '$D(ZTQUEUED),$G(IOST)["C-" W !!,"Compiling report data ..."
 ;
 ; Total responses selected
 S IBCNRTOT=0
 ;
 ; Kill scratch global
 K ^XTMP(IBCNRRTN)
 ;
 ; Initialize looping variables
 S IBCNRDT2=$G(IBCNRSPC("ENDDT"))
 S IBCNRDT1=$G(IBCNRSPC("BEGDT"))
 S IBCNRSRT=$G(IBCNRSPC("SORT"))
 S IBCNRRUN=$$HTE^XLFDT($H,1)
 S ^XTMP(IBCNRRTN,0)=DT_U_(DT+10000)_U_"Scratch Global for IBCNR GROUP PLAN WORKSHEET report"
 S ^XTMP(IBCNRRTN,0,0)=IBCNRDT1_"^"_IBCNRDT2_"^"_IBCNRRUN
 ;
 ; Loop through the Bill/Claims file 
 ;  Authorization Date Cross-Reference
 ; xref APD3 - Authorized Claims only
 ; xref APD - All entered Claims
 S IBCNRDT=$O(^DGCR(399,"APD3",IBCNRDT1),-1)
 F  S IBCNRDT=$O(^DGCR(399,"APD3",IBCNRDT)) Q:IBCNRDT=""!($P(IBCNRDT,".",1)>IBCNRDT2)  D  Q:$G(ZTSTOP)
 . S IBCNRBCI=0
 . F  S IBCNRBCI=$O(^DGCR(399,"APD3",IBCNRDT,IBCNRBCI)) Q:'IBCNRBCI  D  Q:$G(ZTSTOP)
 .. ; Update selected count
 .. S IBCNRTOT=IBCNRTOT+1
 .. ;I $D(ZTQUEUED),IBCNRTOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 QUIT
 .. ;
 .. ; Now get the data for the report - build tmp FILE
 .. D GETDATA(IBCNRBCI)
 ;
EXIT ; EN Exit point
 Q
 ;
 ;
GETDATA(IEN) ; Retrieve data for this inquiry and response(s)
 ; Output: 
 ;  
 N GP0,LIM
 N IBCNRBI1,IBCNRCHG,IBCNRGRP,IBCNRINS,IBCOV,IBCVRD
 ;
 S IBCNRBI1=$G(^DGCR(399,IBCNRBCI,"I1")) Q:$G(IBCNRBI1)=""
 S IBCNRCHG=$P($G(^DGCR(399,IBCNRBCI,"U1")),U)
 ; get insurance co and group
 S IBCNRINS=$P($G(IBCNRBI1),U),IBCNRGRP=$P($G(IBCNRBI1),U,18)
 I '$G(IBCNRINS)!'$G(IBCNRGRP) Q
 ; chk for inactive insurance
 I $P($G(^DIC(36,IBCNRINS,0)),U,5) Q
 ;chk for active group
 S GP0=$G(^IBA(355.3,IBCNRGRP,0))
 I $P(GP0,U,11)=1 Q
 ;chk for pharm plan coverage
 S IBCOV=$O(^IBE(355.31,"B","PHARMACY",""))
 S LIM="",IBCVRD=0
 F  S LIM=$O(^IBA(355.32,"B",IBCNRGRP,LIM)) Q:LIM=""  D
 . I $P(^IBA(355.32,LIM,0),U,2)=IBCOV D
 .. S IBCVRD=$P(^IBA(355.32,LIM,0),U,4)
 I $G(IBCVRD)=0 Q
 ;
 I '$D(^XTMP(IBCNRRTN,IBCNRINS,IBCNRGRP)) D
 . S ^XTMP(IBCNRRTN,IBCNRINS,IBCNRGRP)="0^0"
 S $P(^XTMP(IBCNRRTN,IBCNRINS,IBCNRGRP),U)=$P(^XTMP(IBCNRRTN,IBCNRINS,IBCNRGRP),U)+1
 S $P(^XTMP(IBCNRRTN,IBCNRINS,IBCNRGRP),U,2)=$P(^XTMP(IBCNRRTN,IBCNRINS,IBCNRGRP),U,2)+IBCNRCHG
 ;
GETDATX ; GETDATA exit point
 Q
 ;
 ;
