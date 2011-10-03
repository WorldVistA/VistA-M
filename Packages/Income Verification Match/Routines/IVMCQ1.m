IVMCQ1 ;ALB/KCL - API FOR FINANCIAL QUERIES (continued) ; 7/6/01 1:10pm
 ;;2.0;INCOME VERIFICATION MATCH;**17,23,34,63**;21-OCT-94
 ;
QUERY(DFN,USER,NOTIFY,OPTION,ERROR,RECENT) ; Build/send HL7 financial query for a patient.
 ;
 ;  Input:
 ;      DFN - ien of patient record in PATIENT file (required)
 ;     USER - user initiating the query.  Pointer to NEW USER
 ;            file. (optional)
 ;   NOTIFY - flag to determine if user should be notified when a
 ;            query reply is received. (optional)
 ;   OPTION - option query is initiated from. Ien of record in
 ;            OPTION file. (optional) 
 ;   RECENT - a flag, if set to 1, a check will be done to determine
 ;            if a query is currently open OR recently sent(optional)
 ;
 ; Output:
 ;  Function Value: 1 on success, 0 on failure
 ;   ERROR - if failure, returns error msg (pass by reference)
 ;
 N DATA,DG,DGENDA
 N HLDA,HLDAN,HLDAP,HLDT,HLDT1,HLECH,HLERR,HLEVN,HLFS,HLMID,HLMTN,HLNDAP,HLNDAP0,HLPID,HLQ,HLSDT,HLVER
 N IVMCID,IVMIEN,IVMPAT,IVMQRY,SUCCESS,XMTEXT
 N HL,HLEID
 ;
 S SUCCESS=0
 ;
 ; check if DCD messaging is active
 I '$$DCDON^IVMUPAR1() S ERROR="MESSAGING IS DISABLED." G Q2
 I $G(IVMZ10)="UPLOAD IN PROGRESS" S ERROR="FINANCIAL UPLOAD IS IN PROGRESS" G Q2
 ;
 ; for synchronization and to avoid multiple queries on the same day
 ; for the same patient, LOCK the IVM FINANCIAL QUERY LOG file before
 ; doing two query checks...
 L +^IVM(301.62,"ADT1",DFN):15
 I '$T S ERROR="UNABLE TO SEND A QUERY AT THIS TIME" G Q2
 ;
 ; if RECENT flag, quit if query is currently open OR just sent
 I $G(RECENT)=1,$$RECENT(DFN) S ERROR="A FINANCIAL QUERY IS CURRENTLY OPEN OR JUST SENT" G Q2
 ;
 ; regardless of RECENT flag, check to see if a query has already been
 ; sent out for this patient today...
 I $$SENT^IVMCQ2(DFN) S ERROR="A FINANCIAL QUERY HAS ALREADY BEEN SENT FOR THIS PATIENT TODAY" G Q2
 ;
 ; no query RECENT or SENT today.  set a stub record in 301.62 and
 ; release the lock.  the stub will contain the patient DFN and
 ; today's date so that the "ADT1" x-ref is set and subsequent checks
 ; both in DG and IVM processes will find a query sent today...
 S DATA(.01)=DFN
 S DATA(.02)=$$NOW^XLFDT
 S IVMIEN=$$ADD^DGENDBS(301.62,,.DATA)
 L -^IVM(301.62,"ADT1",DFN)
 K DATA
 K ^TMP("HLS",$J)                                        ;IVM*2*63
 ;
 ; init HL7 variables
 S HLMTN="QRY"
 S HLDAP="IVM"
 S HLEID="VAMC "_$P($$SITE^VASITE,"^",3)_" QRY-Z10 SERVER"
 S HLEID=$O(^ORD(101,"B",HLEID,0))
 D INIT^HLFNC2(HLEID,.HL)
 I $G(HL)]"" S HLERR=$P(HL,"^",2)
 S HLEVN=0 ; init msg event counter
 S HLSDT=$$NOW^XLFDT
 I $D(HLERR) S ERROR="HL7 INITIALIZATION ERROR - "_HLERR G QUERYQ
 ;
 ; get patient identifiers
 I '$$GETPAT^IVMUFNC(DFN,.IVMPAT) S ERROR="PATIENT NOT FOUND" G QUERYQ
 I (IVMPAT("DOB")="") S ERROR="PATIENT DATE OF BIRTH IS REQUIRED" G QUERYQ
 I (IVMPAT("SSN")="") S ERROR="PATIENT SSN IS REQUIRED" G QUERYQ
 I (IVMPAT("SEX")="") S ERROR="PATIENT SEX IS REQUIRED" G QUERYQ
 I "MF"'[IVMPAT("SEX") S ERROR="PATIENT SEX IS NOT VALID" G QUERYQ
 ;
 ; build HL7 financial query (QRY) message components...
 D QRD
 D QRF
 ;
 ; send the message...
 S HLARYTYP="GM"
 S HLFORMAT=1
 D GENERATE^HLMA(HLEID,HLARYTYP,HLFORMAT,.HLRESLT)
 I $P($G(HLRESLT),"^",2)]"" S HLERR=$P(HLRESLT,"^",3)
 I $D(HLERR) S ERROR="HL7 TRANSMISSION ERROR - "_HLERR G QUERYQ
 ;
 ;S IVMCID=$G(MID)
 S IVMCID=+HLRESLT
 ;
 ; update our record in the LOG file...
 S DATA(.03)=0
 S DATA(.04)=$G(USER)
 S DATA(.05)=IVMCID
 S DATA(.06)=""
 S DATA(.07)=$G(OPTION)
 S DATA(.08)=$S($G(NOTIFY):1,1:0)
 S DGENDA=IVMIEN
 I '$$UPD^DGENDBS(301.62,.DGENDA,.DATA) S ERROR="UPDATE OF RECORD "_IVMIEN_" IN 301.62 FAILED!" G QUERYQ
 ;
 S SUCCESS=1
 ;
QUERYQ ; exit and clean-up
 D KILL^HLTRANS
 K ^TMP("HLS",$J)       ;IVM*2*63 - K ^TMP("HLS",$J,HLSDT)
Q2 ;
 L -^IVM(301.62,"ADT1",DFN)
 Q SUCCESS
 ;
QUERY2(DFN,USER,NOTIFY,OPTION,ERROR,RECENT) ; Build/send HL7 financial query for a patient.
 ;
 ; Same input/output parameters as described in module QUERY above.
 ;
 I $$QUERY($G(DFN),$G(USER),$G(NOTIFY),$G(OPTION),.ERROR,$G(RECENT))
 Q
 ;
QRD ; Build (HL7) QRD segment for patient
 ;
 N IVMQRD
 ; date/time query generated...
 S $P(IVMQRD,HLFS,1)=$$HLDATE^HLFNC(HLSDT)
 ; query format code (record-oriented format)...
 S $P(IVMQRD,HLFS,2)="R"
 ; query priority (immediate)...
 S $P(IVMQRD,HLFS,3)="I"
 ; query ID (patient's DFN)...
 S $P(IVMQRD,HLFS,4)=DFN
 ; quantity-limited request (1 record)...
 S $P(IVMQRD,HLFS,7)="1~RD"
 ; "who" subject filter (=SSN)...
 S $P(IVMQRD,HLFS,8)=IVMPAT("SSN")
 ; "what" subject filter (=financial)...
 S $P(IVMQRD,HLFS,9)="FIN"
 ; what department data code (=income year)...
 S $P(IVMQRD,HLFS,10)=$$HLDATE^HLFNC($$LYR^DGMTSCU1(DT))
 ; query results level (full results)...
 S $P(IVMQRD,HLFS,12)="T"
 S ^TMP("HLS",$J,1)="QRD"_HLFS_IVMQRD
 Q
 ;
 ;
QRF ; Build HL7 (QRF) segment for patient
 ;
 N IVMQRF
 ; "where" subject filter (=IVM)...
 S $P(IVMQRF,HLFS,1)="IVM"
 ; what user qualifier (DOB)...
 S $P(IVMQRF,HLFS,4)=$$HLDATE^HLFNC(IVMPAT("DOB"))
 ; other subject query filter (SEX)...
 S $P(IVMQRF,HLFS,5)=IVMPAT("SEX")
 S ^TMP("HLS",$J,2)="QRF"_HLFS_IVMQRF
 Q
 ;
RECENT(DFN) ; Determine if a patient has a financial query that is open OR recently responded to (last 2 minutes)
 ;
 ;  Input: DFN - ien of patient record in PATIENT file
 ; Output: returns 1 if open query, otherwise returns 0.
 ;
 N IVMQRY,IVMIEN,RECENT
 S RECENT=0
 S IVMIEN=$$LASTQRY^IVMCQ2($G(DFN))
 I IVMIEN,$$GET^IVMCQ2(IVMIEN,.IVMQRY) D
 .I 'IVMQRY("STATUS") S RECENT=1 Q
 .I (($$NOW^XLFDT-IVMQRY("RESPONSE"))<.0003) S RECENT=1
 Q RECENT
