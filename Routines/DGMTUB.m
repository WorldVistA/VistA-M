DGMTUB ;ALB/RMO/CAW,CPM,LBD - Means Test Billing Utilities ; 7/22/02 9:32am
 ;;5.3;Registration;**33,456,481**;Aug 13, 1993
 ;
BIL(DFN,DGDT) ;Determine if patient is pending adjudication
 ;        or category C and has agreed to pay the deductible
 ;         Input  -- DFN   Patient IEN
 ;                   DGDT  Date/Time
 ;         Output -- 1=TRUE and 0=FALSE
 N MT0,MTI,TDAT,EDAT,BILL,STOP
 S (BILL,STOP)=0
 I '$G(DFN) G BILQ
 S:'$G(DGDT) DGDT=DT
 ;
 S TDAT=-(DGDT+.1)
 F  S TDAT=$O(^DGMT(408.31,"AID",1,DFN,TDAT)) Q:'TDAT!STOP  D
 .S MTI=0 F  S MTI=$O(^DGMT(408.31,"AID",1,DFN,TDAT,MTI)) Q:'MTI!STOP  D
 ..S MT0=$G(^DGMT(408.31,MTI,0)) Q:'$G(^("PRIM"))  ; not primary MT
 ..;
 ..; - evaluate the test if the category isn't 'REQUIRED'
 ..I MT0,$P(MT0,"^",3)'=1 D
 ...S EDAT=$S($P(MT0,"^",3)=3:+MT0,1:$P(MT0,"^",7))
 ...;
 ...; - if the patient is not billable on the evaluation date, quit
 ...I EDAT\1=(DGDT\1),'$$CK(MT0) S STOP=1 Q
 ...;
 ...; - if the test effective date is prior to the evaluation date,
 ...;   obtain the billable status and quit
 ...I EDAT'>DGDT S BILL=$$CK(MT0),STOP=1
 ;
BILQ Q BILL
 ;
BILST(DFN) ;Determine the last date patient was pending adjudication
 ;        or category C and agreed to pay the deductible
 ;         Input  -- DFN   Patient IEN
 ;         Output -- Last effective date
 N DGDT,DGENDT,DGMT0,DGMTI,DGMTIDT,DGSTDT
 S (DGDT,DGENDT,DGSTDT)=""
 I '$G(DFN) G BILSTQ
 I $$BIL(DFN,DT) S DGDT=DT G BILSTQ
 ;
 S DGMTIDT="" F  S DGMTIDT=$O(^DGMT(408.31,"AID",1,DFN,DGMTIDT)) Q:DGMTIDT=""!(DGDT)  D
 .S DGMTI=0 F  S DGMTI=$O(^DGMT(408.31,"AID",1,DFN,DGMTIDT,DGMTI)) Q:DGMTI=""!(DGDT)  D
 ..I $D(^DGMT(408.31,DGMTI,0)),$G(^("PRIM")) S DGMT0=^(0) D CKDT
 ;
BILSTQ Q +$P($G(DGDT),".")
 ;
CKDT ;Check the date of test
 N DGMTS,X,X1,X2,Y
 S Y=$$CK(DGMT0) S DGMTS=$P(DGMT0,"^",3) S:Y DGSTDT=$P(DGMT0,"^",7) S:'Y DGENDT=$S(DGMTS=1:DGENDT,DGMTS=3:$P(DGMT0,"^"),1:$P(DGMT0,"^",7))
 I DGSTDT S:'DGENDT DGDT=DT I DGENDT S X1=DGENDT,X2=-1 D C^%DTC S DGDT=X
 Q
 ;
CK(DGMT0) ;Check if patient is pending adjudication or category C
 ;        and has agreed to pay the deductible
 ;        Add check for GMT status (DG*5.3*456)
 ;         Input  -- DGMT0  Annual Means Test 0th node
 ;         Output -- 1=TRUE and 0=FALSE
 N DGMTATP,DGMTS,Y
 S DGMTS=$P(DGMT0,"^",3),DGMTATP=$P(DGMT0,"^",11)
 I ("^2^6^16^"[("^"_DGMTS_"^"))&(DGMTATP'=0) S Y=1
 Q +$G(Y)
 ;
GMT(DFN,DGDT) ;Determine if patient is GMT Copay Required as of the date
 ;        specified
 ;         Input  -- DFN   Patient IEN
 ;                   DGDT  Date/Time
 ;         Output -- 1=Patient had GMT status or Pending Adjudication
 ;                      for GMT as of date specified
 ;                   0=Patient did not have GMT status
 ;
 N DGMT,DGSTA,DGMT0,DGMTG
 I '$G(DFN) Q 0
 S:'$G(DGDT) DGDT=DT
 ; Get last primary means test with status other than Required
 S DGMT=$$LVMT^DGMTU(DFN,DGDT),DGSTA=$P(DGMT,U,4)
 I DGSTA="G" Q 1  ; status = GMT copay required
 S DGMT0=$G(^DGMT(408.31,+DGMT,0)),DGMTG=$P(DGMT0,U,27)
 I DGMTG="" Q 0
 ; If status = Pending Adjudication and GMT Threhold is greater than
 ; MT Threshold, then patient is Pending Adjudication for GMT
 I DGSTA="P",DGMTG>$P(DGMT0,U,12) Q 1
 Q 0
