IVMUFNC ;ALB/MLI/PHH/SCK,TDM - IVM GENERIC FUNCTIONS ; 6/30/08 4:11pm
 ;;2.0;INCOME VERIFICATION MATCH;**3,11,17,34,95,94,115**;21-OCT-94;Build 28
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine contains generic calls for use throughout IVM
 ;
INIT(EID,HL,INT) ; initialize variables for 1.6 HL7/IVM
 S EID=$G(EID),INT=$G(INT)
 S HLDAP="IVM" D INIT^HLFNC2(EID,.HL,INT)
 S (HLEVN,IVMCT)=0 ; initialize segment and message counters
 ;;D NOW^%DTC S HLSDT=%
 Q
 ;
 ;
CLEAN ; clean-up variables for HL7/IVM (as defined by call to INIT)
 D KILL^HLTRANS
 K HLEVN,HLMTN,HLSDT,IVMCT
 Q
 ;
 ;
BATCH ; put BHS and BTS segments into TMP global
 ;
 ;  Input - HLMTN as HL7 message type being sent in this batch (REQUIRED)
 ;          HLEVN as number of HL7 messages in batch (REQUIRED)
 ;          IVMCT as subscript in TMP global where BTS segment goes (REQ)
 ;          HLSEC (optional) as security (see BHS^HLFNC1)
 ;          HLMSA (optional) as message ack variables (see BHS^HLFNC1)
 ;
 ;      ****Also assumes all HL7 variables returned from****
 ;          INIT^HLTRANS are defined
 ;
 Q  ; LINE ADDED FOR HL7 1.6
 S HLSEC=$G(HLSEC),HLMSA=$G(HLMSA)
 S ^TMP("HLS",$J,HLSDT,0)=$$BHS^HLFNC1(HLMTN,HLSEC,HLMSA)
 S ^TMP("HLS",$J,HLSDT,IVMCT)="BTS"_HLFS_HLEVN ; trailer
 Q
 ;
 ;
IVM(DFN,IVMDT) ; extrinsic function - should this pt be transmitted to IVM?
 ;
 ;  Input - DFN as internal entry number of PATIENT file
 ;          IVMDT as date of test (default DT)
 ;
 ; Output - 1 if pt should be sent to IVM, 0 otherwise
 ;
 N X,Y
 S DFN=$G(DFN) I '$D(^DPT(+DFN,0)) G IVMQ
 S IVMDT=$S($G(IVMDT):IVMDT,1:DT)
 S X=$$LST^DGMTU(DFN,IVMDT)
 I $E($P(X,"^",2),1,3)'=$E(IVMDT,1,3) K IVMDT G IVMQ ; not in same year
 S X=$G(^DGMT(408.31,+X,0)) I 'X G IVMQ ; can't find MT entry for date
 I $P(X,"^",3)=6 S:'$$INS(DFN,IVMDT) Y=1 G IVMQ ; C/no insurance...send
 I $P(X,"^",3)'=4 G IVMQ ; not cat A
 I ($P(X,"^",4)-$P(X,"^",15)>$P(X,"^",12))!$P(X,"^",10) G IVMQ ; income-deduct expenses>threshold (hardship) or adjudicated
 S Y=1
IVMQ Q +$G(Y)
 ;
 ;
INS(DFN,IVMDT) ; extrinsic function to see if pt has active insurance
 ;
 ;  Input - DFN as internal entry number of PATIENT file
 ;          IVMDT [optional] as date to compute ins coverage for
 ;
 ; Output - 1 if yes, 0 if no
 ;
 Q $S($$INSUR^IBBAPI(DFN,$G(IVMDT))=1:1,1:0)
 ;
 ;
MAIL(IVMGRP) ; Transmit to members of Mail Group. Before D MAIL^IVMUFNC()
 ; set XMSUB = to subject   and  set IVMTEXT array to message.
 ;
 ;Input:
 ;  IVMGRP - optional parameter, = to name of a mailgroup to send the
 ;           message to.  If not sent, the IVM Site Parameter file is
 ;           used to determine the mailgroup.
 ;
 N DIFROM,XMDUZ,XMTEXT,XMSTRIP,XMROU,XMY,XMZ,XMDF
 S XMDF=""
 S XMDUZ="IVM PACKAGE"
 S XMTEXT="IVMTEXT("
 I '$L($G(IVMGRP)) D
 .S IVMGRP=$P($G(^XMB(3.8,+$P($G(^IVM(301.9,1,0)),"^",2),0)),"^")
 S XMY("G."_IVMGRP_"@"_^XMB("NETNAME"))=""
 D ^XMD
 K IVMTEXT,XMDUZ,XMSUB,XMTEXT,XMY
 Q
 ;
 ;
LTD(DFN,IVMQUERY) ; Find Last Treatment Date
 ;  Input:       DFN -- pointer to the patient in file #2
 ;          IVMQUERY("LTD") -- # of the QUERY that is currently open or
 ;                      undefined, zero, or null if no QUERY opened for
 ;                      last treatment date
 ; Output:  LTD -- Last Treatment Date (really last date seen at
 ;                                      the facility)
 ;
 N LTD,SDSTOP,X,Z,IVMQ
 ;
 ; - need a patient
 S IVMQ=$G(IVMQUERY("LTD"))
 I '$G(DFN) S LTD=0 G LTDQ
 ;
 ; - if current inpatient, set LTD = today and quit
 I $G(^DPT(DFN,.105)) S LTD=DT G LTDQ
 ;
 ; - get the last discharge date
 S LTD=+$O(^DGPM("ATID3",DFN,"")) S:LTD LTD=9999999.9999999-LTD\1 S:LTD>DT LTD=DT
 ;
 ; - get the last registration date and compare to LTD
 S X=+$O(^DPT(DFN,"DIS",0)) I X S X=9999999-X\1 S:X>LTD LTD=X
 ;
 ; - get the last appointment or stop after LTD (if any)
 K ^TMP("DIERR",$J)
 I $G(IVMQ) D ACTIVE^SDQ(.IVMQ,"FALSE","SET") ;clear QUERY results
 I '$G(IVMQ) D
 .D OPEN^SDQ(.IVMQ) Q:'$G(IVMQ)
 .D INDEX^SDQ(.IVMQ,"PATIENT/DATE","SET")
 .D SCANCB^SDQ(.IVMQ,"I $S($P(SDOE0,U,8)=2:1,$P(SDOE0,U,8)=1:$$APPT^IVMUFNC(SDOE0),1:0) S LTD=SDOE0\1,SDSTOP=1","SET")
 .S IVMQUERY("LTD")=IVMQ
 ;
 D PAT^SDQ(.IVMQ,DFN,"SET")
 D DATE^SDQ(.IVMQ,LTD+.000001,9999999,"SET")
 D ACTIVE^SDQ(.IVMQ,"TRUE","SET")
 D SCAN^SDQ(.IVMQ,"BACKWARD")
 K ^TMP("DIERR",$J)
 ;
LTDQ ;
 Q $S(LTD:$$HLDATE^HLFNC(LTD),1:HLQ)
 ;
APPT(SDOE0) ;Determine if appt associated with encounter is in a valid state
 ; Quit when Outpatient Encounter STATUS is CHECKED OUT
 Q:$P(SDOE0,U,12)=2 1
 ; Quit when Outpatient Encounter STATUS is ACTION REQUIRED and the
 ; Appointment Status is SCHEDULED/KEPT
 N DGARRAY,SDCNT,SDSTAT,SDDTTM S DGARRAY("FLDS")=3,DGARRAY(4)=+$P(SDOE0,U,2)
 S DGARRAY(1)=$P(SDOE0,U),DGARRAY("SORT")="P",DGARRAY("MAX")=1
 S SDCNT=$$SDAPI^SDAMA301(.DGARRAY),SDSTAT=""
 I SDCNT>0 D
 .S SDDTTM=$O(^TMP($J,"SDAMA301",DGARRAY(4),0))
 .I SDDTTM S SDSTAT=$P($P($G(^TMP($J,"SDAMA301",DGARRAY(4),SDDTTM)),U,3),";")
 K ^TMP($J,"SDAMA301")
 Q:(($P(SDOE0,U,12)=14)&(SDSTAT="R")) 1
 Q 0
 ;
OUTTR(IVMINT,IVMPAR,IVMST) ; - Transform IVMINT to a displayable value
 ;  Input:   IVMINT  --  internal value of demographic element
 ;                       received from IVM
 ;           IVMPAR  --  Zeroth node of the entry in file #301.92
 ;                       for the demographic element IVMINT
 ;            IVMST  --  [optional] pointer to the STATE (#5) file
 ;                       Required to transform the county code
 ;  Output:  IVMOUT  --  Displayable value for IVMINT
 ;
 N IVMOUT,Z S IVMOUT=IVMINT
 I $G(IVMINT)=""!($G(IVMPAR)="") S IVMOUT="" G OUTTRQ
 ;
 ; - use special transform for county
 I $G(IVMST),$P(IVMPAR,"^",2)="PID12" S IVMOUT=$P($G(^DIC(5,IVMST,1,IVMINT,0)),"^")
 ;
 ; - transform the internal value if necessary
 I $P(IVMPAR,"^",6) S IVMOUT=$$EXPAND($P(IVMPAR,"^",4),$P(IVMPAR,"^",5),IVMINT)
 ;
OUTTRQ Q IVMOUT
 ;
 ;
EXPAND(FILE,FIELD,VALUE) ; - returns internal data in an output format
 N Y,C S Y=VALUE
 I 'FILE!('FIELD)!(VALUE="") G EXPQ
 S Y=VALUE,C=$P(^DD(FILE,FIELD,0),"^",2) D Y^DIQ
EXPQ Q Y
 ;
 ;
GETPAT(DFN,IVMPAT) ;
 ; Description: Used to obtain identifying information for a patient
 ; in the PATIENT file and place it in the IVMPAT() array.
 ;
 ;  Input:
 ;   DFN - ien of patient in PATIENT file
 ;
 ; Output:
 ;  Function Value - 1 on success, 0 on failure
 ;   IVMPAT - (pass by reference) On success, this array will contain
 ;    the patient identifing information. Array subscripts are:
 ;      "DFN"  - ien PATIENT file
 ;      "NAME" - patient name
 ;      "SSN"  - patient Social Security Number
 ;      "DOB"  - patient date of birth (FM format)
 ;      "SEX"  - patient sex
 ;      "ICN"  - patient ICN
 ;
 N IVMNODE
 Q:'$G(DFN) 0
 K IVMPAT S IVMPAT=""
 ;
 ; obtain patient record
 S IVMNODE=$G(^DPT(DFN,0))
 Q:IVMNODE="" 0
 ;
 S IVMPAT("DFN")=DFN
 S IVMPAT("NAME")=$P(IVMNODE,"^")
 S IVMPAT("SEX")=$P(IVMNODE,"^",2)
 S IVMPAT("DOB")=$P(IVMNODE,"^",3)
 S IVMPAT("SSN")=$P(IVMNODE,"^",9)
 S IVMPAT("ICN")=$$GETICN^MPIF001(DFN)
 Q 1
 ;
LOOKUP(SSN,DOB,SEX,ERROR) ;
 ;Description: This function will do a search for the patient based on
 ;the identifying information provided. The function will be successful
 ;only if a single patient is found matching the identifiers provided.
 ;
 ;Inputs:
 ;  SSN - patient Social Security Number
 ;  DOB - patient date of birth (FM format)
 ;  SEX - patient sex
 ;Outputs:
 ;  Function Value - patient DFN if successful, 0 otherwise
 ;  ERROR - if unsuccessful, an error message is returned (optional, pass by reference)
 ;
 N DFN,NODE
 ;
 I $G(SSN)="" S ERROR="INVALID SSN" Q 0
 S DFN=$O(^DPT("SSN",SSN,0))
 I 'DFN S ERROR="SSN NOT FOUND" Q 0
 I $O(^DPT("SSN",SSN,DFN)) S ERROR="MULTIPLE PATIENTS MATCHING SSN" Q 0
 S NODE=$G(^DPT(DFN,0))
 I $P(NODE,"^",2)'=SEX S ERROR="SEX DOES NOT MATCH" Q 0
 I $E($P(NODE,"^",3),1,3)'=$E(DOB,1,3) S ERROR="DOB DOES NOT MATCH" Q 0
 I $E($P(NODE,"^",3),4,5),$E($P(NODE,"^",3),4,5)'=$E(DOB,4,5) S ERROR="DOB DOES NOT MATCH" Q 0
 Q DFN
 ;
MATCH(DFN,ICN,DOB,SEX,CFLG,ERROR) ;
 ;Description: This function will try to match the patient based on
 ;the identifying information provided. The function will be
 ;successful only if the patient is found matching the identifiers
 ;provided.
 ;
 ;Inputs:
 ;  DFN  - patient DFN
 ;  ICN  - patient ICN
 ;  DOB  - patient date of birth (FM format)
 ;  SEX  - patient sex
 ;  CFLG - Compare Flag (Default="IDS", I=ICN, D=DOB, S=Sex)
 ;Outputs:
 ;  Function Value: 1 - patient matched successfully, 0 - otherwise
 ;  ERROR - if unsuccessful, an error message is returned (optional, pass by reference)
 N NODE
 I $G(DFN)="" S ERROR="INVALID DFN" Q 0
 I $G(CFLG)="" S CFLG="IDS"
 S NODE=$G(^DPT(DFN,0)) I NODE="" S ERROR="DFN NOT FOUND" Q 0
 I CFLG["I",$$GETICN^MPIF001(DFN)'=$G(ICN) S ERROR="ICN DOES NOT MATCH" Q 0
 I CFLG["S",$P(NODE,"^",2)'=$G(SEX) S ERROR="SEX DOES NOT MATCH" Q 0
 I CFLG["D",$E($P(NODE,"^",3),1,3)'=$E($G(DOB),1,3) S ERROR="DOB DOES NOT MATCH" Q 0
 I CFLG["D",$E($P(NODE,"^",3),4,5),$E($P(NODE,"^",3),4,5)'=$E($G(DOB),4,5) S ERROR="DOB DOES NOT MATCH" Q 0
 Q 1
PARSPID3(PID3,PID3ARY) ;
 ;Description: This function will parse seq 3 of PID segment
 ;Input :   PID3  -  Array for seq. 3 of PID segment
 ;Output:   PID3ARY("NI") -  Value - ICN
 ;          PID3ARY("PI") -  Value - DFN
 I $D(PID3(3)) D
 .I $O(PID3(3,"")) D  Q
 ..S COMP=0 F  S COMP=$O(PID3(3,COMP)) Q:COMP=""  D
 ...I $P(PID3(3,COMP),$E(HLECH),5)="PI" S PID3ARY("PI")=$P(PID3(3,COMP),$E(HLECH))
 ...I $P(PID3(3,COMP),$E(HLECH),5)="NI" S PID3ARY("NI")=$P(PID3(3,COMP),$E(HLECH))
 .I $P(PID3(3),$E(HLECH),5)="PI" S PID3ARY("PI")=$P(PID3(3),$E(HLECH))
 Q
