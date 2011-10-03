SDPFSS ;ALB/SCK - Patient Financial Services System  ;22-APR-2005
 ;;5.3;Scheduling;**430**;Aug 13, 1993
 ;
 Q
 ;
EVENT ; Entry point for PFSS Protocol event.  This procedure will manage the IBB event actions.
 ;
 N SDEVENT,SDTEST,SDBEFORE,SDAFTER,SDMSG,SDARRAY,SDCNT,SDPRV,SDERR,SDERRMSG,SDNODE,SDOK
 N IBBDFN,IBBAPLR,IBBEVENT,IBBPV1,IBBPV2,IBBARFN
 ;
 ; Check conditions before proceeding
 Q:'$G(DFN)
 Q:'$$CHECK
 Q:$$TESTPAT^VADPT(DFN)
 ;
 ; Call the ICN API to generate an ICN if one does not exist for the patient.
 S SDOK=$$ICNLC^MPIF001(DFN)
 I SDOK<0 D
 . D ERRMSG^SDPFSS2(SDOK)
 ;
 ; Get event type
 S SDEVENT=$S($D(SDAMEVT):$$GET1^DIQ(409.66,SDAMEVT,.01),1:"OTHER")
 I SDEVENT="CHECK-OUT",+$G(SDPFSFLG) S SDEVENT="DELETE CO"
 ;
 S SDBEFORE=$P($G(SDATA("BEFORE","STATUS")),U,3)
 S SDAFTER=$P($G(SDATA("AFTER","STATUS")),U,3)
 ;
 I SDEVENT="CHECK-IN" D
 . I SDBEFORE="ACT REQ/CHECKED IN"&(SDAFTER["NO ACTION TAKEN") S SDEVENT="DELETE CI"
 ;
 I SDEVENT="NO-SHOW" D
 . I SDBEFORE="NO-SHOW"&(SDAFTER["NO ACTION TAKEN") S SDEVENT="DELETE NS"
 ;
 S IBBDFN=DFN
 S IBBAPLR=""
 S IBBEVENT=$$GETEVT^SDPFSS2(SDEVENT)
 ;
 ; Call the Scheduling Appointment Data API to retrieve appointment data
 K ^TMP($J,"SDAMA301")
 S SDARRAY(1)=$G(SDT)_";"_$G(SDT)
 S SDARRAY(2)=$G(SDCL)
 S SDARRAY(4)=$G(DFN)
 S SDARRAY("FLDS")="1;2;3;8;9;10;11;13;14;15;16;17;18"
 S SDCNT=$$SDAPI^SDAMA301(.SDARRAY)
 ;
 ; check for any errors in the TMP global
 I SDCNT<0 D
 . S SDERR=$O(^TMP($J,"SDAMA301",0))
 . I SDERR D
 . . S SDERRMSG=^TMP($J,"SDAMA301",SDERR)
 . . S SDERR=SDERR_"^"_SDERRMSG
 . E  D
 . . S SDERR="-1^Undefined error returned by SDAPI"
 . D ERRMSG^SDPFSS2(SDERR)
 . ; Null out the data global for further processing
 . S ^TMP($J,"SDAMA301",DFN,SDCL,SDT)=""
 ;
 I SDCNT=0 D
 . S SDERR="-1^No appointments were returned by SDAPI"_"^"_DFN_"^"_SDT_"^"_SDCL
 . D ERRMSG^SDPFSS2(SDERR)
 ;
 ; Build data arrays for PFSS Account API
 S SDNODE=$G(^TMP($J,"SDAMA301",DFN,SDCL,SDT))
 S IBBPV1(2)="O"
 S IBBPV1(3)=SDCL
 S IBBPV1(4)=+$P(SDNODE,U,10)
 S IBBPV1(10)=+$P(SDNODE,U,18)
 S IBBPV1(18)=$P($P(SDNODE,U,13),";",1)
 S IBBPV1(51)=$P(SDNODE,U,15)
 S IBBPV1(25)=$S(SDEVENT="DELETE CI":"",1:$P(SDNODE,U,9))
 S IBBPV1(41)=$P($P(SDNODE,U,14),";",1)
 I "A05,A38"[IBBEVENT
 E  S IBBPV1(44)=SDT
 ;
 S IBBPV2(7)=$P($P(SDNODE,U,8),";",1)
 I "A05,A38"[IBBEVENT S IBBPV2(8)=SDT
 S IBBPV2(24)=$P($P(SDNODE,U,3),";",1)
 S IBBPV2(46)=$P(SDNODE,U,16)
 ;
 I SDEVENT="CHECK-OUT" D
 . S SDPRV=$$ENCPRV^SDPFSS2(DFN,$G(SDVSIT))
 . S IBBPV1(45)=$P(SDNODE,U,11)
 I +$G(SDPRV)'>0 S SDPRV=$$DEFPRV^SDPFSS2(SDCL)
 ;
 I SDEVENT="DELETE CO" S IBBPV1(45)="",SDPRV=""
 S IBBPV1(7)=$P($G(SDPRV),U,1)
 ;
 S IBBARFN=$S(SDEVENT="MAKE":"",1:$$GETARN^SDPFSS2(SDT,DFN,SDCL))
B1 ; Call the Get Account API and retrieve the account number reference
 S SDANR=$$GETACCT^IBBAPI(IBBDFN,IBBARFN,IBBEVENT,IBBAPLR,.IBBPV1,.IBBPV2)
 ;
 ;  If this is a "Make" appt., then create a new entry in the Appointment Acct. No. Reference File
 I SDEVENT="MAKE",+$G(SDANR)>0 D
 . S SDOK=$$FILE(DFN,SDT,SDCL,SDANR)
 . I 'SDOK D
 . . S SDERRMSG=$S($P($G(SDOK),U,2)]"":$P($G(SDOK),U,2),1:"Unable to File Account Number Reference")
 . . D ERRMSG^SDPFSS2(SDERRMSG)
 K ^TMP($J,"SDAMA301")
 Q
 ;
CHECK() ; Check routine for unit testing to allow for on/off PFSS Switch
 N RSLT,X
 ;
 ; Check if the PFSS Switch Status API call is installed
 ; If it is, then return the status of the switch, otherwise
 ; return 0
 I $T(SWSTAT^IBBAPI)'="" S RSLT=+$$SWSTAT^IBBAPI
 Q +$G(RSLT)
 ;
FILE(DFN,SDT,SDCLN,SDANR) ;  Procedure to validate and load appointment information and account number reference into file #409.55
 ;
 ; Input
 ;    DFN    - Patient IEN in File #2
 ;    SDT    - Appointment Date/Time in Fileman format
 ;    SDCLN  - Clinic IEN in Hospital Location File, #44
 ;    SDANR  - Account Number Reference from IBB
 ;
 ; Output
 ;    1 - If entry successfully created
 ;   -1^error message - if load is unsuccessful
 ;
 N FDA,FDAIEN,ERR
 ;
 I '$G(DFN) S ERR="-1^MISSING DFN" G FILEQ
 I '$D(^DPT(DFN)) S ERR="-1^INVALID PATIENT ENTRY" G FILEQ
 I '$G(SDT) S ERR="-1^MISSING APPOINTMENT DATE/TIME" G FILEQ
 I '$G(SDCLN) S ERR="-1^MISSING CLINIC LOCATION" G FILEQ
 I '$D(^SC(SDCLN)) S ERR="-1^INVALID HOSPITAL LOCATION ENTRY" G FILEQ
 I '$G(SDANR) S ERR="-1^No Account Number Reference provided" G FILEQ
 ;
 S FDA(1,409.55,"+1,",.01)=SDT
 S FDA(1,409.55,"+1,",.02)=DFN
 S FDA(1,409.55,"+1,",.03)=SDCLN
 S FDA(1,409.55,"+1,",.04)=SDANR
 D UPDATE^DIE("","FDA(1)","FDAIEN","ERR")
 ;
 I '$D(ERR) S ERR=1
FILEQ Q $G(ERR)
