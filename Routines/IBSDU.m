IBSDU ;ALB/TMP - ACRP API UTILITIES ;16-SEP-97
 ;;2.0;INTEGRATED BILLING;**91,249,366**;21-MAR-94;Build 3
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SCAN(IBINDX,IBVAL,IBFILTER,IBCBK,IBCLOSE,IBQUERY,IBDIR,IBZXERR) ; Scan encountrs
 ;  *** NOTE *** When using this call, the variable passed as IBQUERY
 ;               must be  newed or killed in the calling program
 ; IBINDX = index name property of the query object 
 ; IBVAL = array of data elements for start/end of search
 ;         IBVAL("DFN") = patient DFN
 ;         IBVAL("BDT") = begin date
 ;         IBVAL("EDT") = end date
 ;         IBVAL("VIS") = encounter file ien
 ; IBFILTER = the executable code to use to screen entries
 ; IBCBK = the executable scan callback code to create the result set
 ; IBCLOSE = Flag that says whether or not to close the QUERY object
 ;         1 = Perform close     0 or null = Do not close object
 ; IBQUERY = the # of the current query, if not a new query.  If passed
 ;          by reference and query closed, this variable will be nulled
 ; IBDIR = the direction of the scan (optional)
 ;         null, undefined or FORWARD : Scan forwards
 ;         BACKWARD : Scan backwards
 ; IBZXERR = the name of the error array to be returned (or none if null)
 ;
 N QUERY
 S QUERY=$G(IBQUERY)
 I $G(IBZXERR)="" K ^TMP("DIERR",$J)
 I $G(IBZXERR)'="" K @IBZXERR
 I '$G(QUERY) D
 .D OPEN^SDQ(.IBQUERY,$G(IBZXERR)) Q:'$G(IBQUERY)
 .D INDEX^SDQ(.IBQUERY,IBINDX,"SET",$G(IBZXERR))
 .I $G(IBFILTER)'="" D FILTER^SDQ(.IBQUERY,IBFILTER,"SET",$G(IBZXERR))
 .D SCANCB^SDQ(.IBQUERY,IBCBK,"SET",$G(IBZXERR))
 I $G(QUERY) D ACTIVE^SDQ(.IBQUERY,"FALSE","SET",$G(IBZXERR))
 D SETINDX(.IBQUERY,IBINDX)
 D ACTIVE^SDQ(.IBQUERY,"TRUE","SET",$G(IBZXERR))
 S:$G(IBDIR)="" IBDIR="FORWARD"
 D SCAN^SDQ(.IBQUERY,IBDIR,$G(IBZXERR))
 I $G(IBCLOSE) D CLOSE(.IBQUERY)
 I $G(IBZXERR)="" K ^TMP("DIERR",$J)
 Q
 ;
CLOSE(IBQUERY) ; Close the query
 N IBERROR
 G:'$G(IBQUERY) CLOSEQ
 D CLOSE^SDQ(.IBQUERY)
CLOSEQ Q
 ;
SETINDX(IBQUERY,IBINDX) ;
 I IBINDX="PATIENT/DATE" D PAT,DATE
 I IBINDX="DATE/TIME" D DATE
 I IBINDX="PATIENT" D PAT
 I IBINDX="VISIT" D VIS
 Q
 ;
PAT ; Verify patient
 D PAT^SDQ(.IBQUERY,$G(IBVAL("DFN")),"SET",$G(IBZXERR))
 Q
 ;
DATE ; Verify date range
 D DATE^SDQ(.IBQUERY,$G(IBVAL("BDT")),$G(IBVAL("EDT")),"SET",$G(IBZXERR))
 Q
 ;
VIS ; Verify visit
 D VISIT^SDQ(.IBQUERY,$G(IBVAL("VIS")),"SET",$G(IBZXERR))
 Q
 ;
EPTR(IBOE) ; Function returns extended pointer for encounter (IBOE) 0-node
 Q $$ER^SDOE(IBOE)
 ;
SCE(IBOE,PC,NODE,IBZXERR) ; Returns the specific piece or entire node of the enctr
 ; NODE = the node to return ... if undefined, the 0-node is assumed
 ; If PC is null or undefined, the whole node is returned, otherwise
 ;   just the PC-piece is returned
 ; IBZXERR = the name of the array where errors should be passed back in
 ;       (pass in quotes I.E.: "IBERR").  If no name passed, errors are
 ;       not returned
 N IBX
 S:$G(NODE)="" NODE=0
 I '$G(PC),NODE=0 S IBX=$$GETOE^SDOE(IBOE,$G(IBZXERR)) G SCEQ
 D GETGEN^SDOE(IBOE,"IBX",$G(IBZXERR))
 S IBX=$S($G(PC):$P($G(IBX(NODE)),U,+PC),1:$G(IBX(NODE)))
 ;
SCEQ I $G(IBZXERR)="" K ^TMP("DIERR",$J)
 Q IBX
 ;
DISND(IBOE,IBOE0,PC,NODE) ; Returns the specific piece or all pieces of "DIS"
 ; (disposition) of the PATIENT file entry for the encounter IBOE
 ; NODE = the node to return ... if undefined, the 0-node is assumed
 ; If PC is null or undefined, the whole node is returned, otherwise
 ;   just the PC-piece is returned
 ; IBOE0 = 0-node of encounter file (optional)
 N DATA,IBOE0
 S:$G(NODE)="" NODE=0
 I $G(IBOE0)="" S IBOE0=$$SCE(IBOE)
 S DATA=$G(^DPT(+$P(IBOE0,U,2),"DIS",+$$EPTR^IBSDU(IBOE),NODE))
 S:$G(PC) DATA=$P(DATA,U,+PC)
 Q DATA
 ;
LAST(IBDFN) ; Returns the patient's Last Appointment
 ; ARRAYS IN DFN MUST BE LOCAL or ^TMP or ^UTILITY
 ; pass in single DFN or an open array reference (local or global)
 ; for array of patients, array will = last appt
 ; if '$d(array(dfn)) returned then unknown for that patient
 ; Unknown - cannot be determined, N/A - patient has none
 ; 
 ;
 N IBARRAY,DFN,DATA,X K ^TMP($J,"SDAMA301")
 I 'IBDFN,$E(IBDFN)="^",$E(IBDFN,1,5)'="^TMP(",$E(IBDFN,1,9)'="^UTILITY(" S DATA="INVALID DFN" G LASTQ
 I IBDFN,$$GETICN^MPIF001(IBDFN)<1!($$IFLOCAL^MPIF001(IBDFN)) S DATA="Unknown" G LASTQ
 I 'IBDFN S DFN=0 F  S DFN=$O(@(IBDFN_DFN_")")) Q:'DFN  I $$GETICN^MPIF001(DFN)<1!($$IFLOCAL^MPIF001(DFN)) K @(IBDFN_DFN_")")
 I 'IBDFN,$D(@($E(IBDFN,1,$L(IBDFN)-1)_$S(IBDFN[",":")",1:"")))<9 S DATA=0 G LASTQ
 S IBARRAY(1)=";"_DT
 S IBARRAY(3)="R;I;NT"
 S IBARRAY(4)=IBDFN
 S IBARRAY("FLDS")=1
 I IBDFN S IBARRAY("MAX")=-1
 S IBARRAY("PURGED")=1
 S IBARRAY("SORT")="P"
 S DATA=$$SDAPI^SDAMA301(.IBARRAY)
 I IBDFN S DATA=$S(DATA=0:"N/A",DATA=-1:-1,1:$O(^TMP($J,"SDAMA301",IBDFN,0)))
 I 'IBDFN S (DATA,DFN)=0 F  S DFN=$O(@(IBDFN_DFN_")")) Q:'DFN  S X=$O(^TMP($J,"SDAMA301",DFN,9999999),-1),@(IBDFN_DFN_")")=$S(X:X,1:"N/A"),DATA=DATA+1
 ;
LASTQ K ^TMP($J,"SDAMA301")
 Q DATA
 ;
NEXT(IBDFN) ; Returns the patient's Next Appointment
 ; ARRAYS IN DFN MUST BE LOCAL or ^TMP or ^UTILITY
 ; pass in single DFN or an open array reference (local or global)
 ; for array of patients, array will = next appt
 ; if '$d(array(dfn)) returned then unknown for that patient
 ; Unknown - cannot be determined, N/A - patient has none
 ; Pass DATA by reference for list or $$ return for single
 ; 
 ;
 N IBARRAY,DFN,DATA,X K ^TMP($J,"SDAMA301")
 I 'IBDFN,$E(IBDFN)="^",$E(IBDFN,1,5)'="^TMP(",$E(IBDFN,1,9)'="^UTILITY(" S DATA="INVALID DFN" G NEXTQ
 I IBDFN,$$GETICN^MPIF001(IBDFN)<1!($$IFLOCAL^MPIF001(IBDFN)) S DATA="Unknown" G NEXTQ
 I 'IBDFN S DFN=0 F  S DFN=$O(@(IBDFN_DFN_")")) Q:'DFN  I $$GETICN^MPIF001(DFN)<1!($$IFLOCAL^MPIF001(DFN)) K @(IBDFN_DFN_")")
 I 'IBDFN,$D(@($E(IBDFN,1,$L(IBDFN)-1)_$S(IBDFN[",":")",1:"")))<9 S DATA=0 G NEXTQ
 S IBARRAY(1)=DT
 S IBARRAY(3)="R;I;NT"
 S IBARRAY(4)=IBDFN
 S IBARRAY("FLDS")=1
 I IBDFN S IBARRAY("MAX")=1
 S IBARRAY("SORT")="P"
 S DATA=$$SDAPI^SDAMA301(.IBARRAY)
 I IBDFN S DATA=$S(DATA=0:"N/A",DATA=-1:-1,1:$O(^TMP($J,"SDAMA301",IBDFN,0)))
 I 'IBDFN S (DATA,DFN)=0 F  S DFN=$O(@(IBDFN_DFN_")")) Q:'DFN  S X=$O(^TMP($J,"SDAMA301",DFN,0)),@(IBDFN_DFN_")")=$S(X:X,1:"N/A"),DATA=DATA+1
 ;
NEXTQ K ^TMP($J,"SDAMA301")
 Q DATA
 ;
