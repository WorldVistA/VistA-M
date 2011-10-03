IVMUFNC4 ;ALB/KCL - IVM UTILITIES ; 12/21/00 3:15pm
 ;;2.0;INCOME VERIFICATION MATCH;**1,9,13,18,34**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
DAT1(X,Y) ; extrinsic function - convert FM date to displayable (mm/dd/yy) format.
 ;
 ;  Input - X as FM date.time
 ;          Y [optional] equal to 1 if time is to be returned
 ;
 ; Output - IVMDATE as (mm/dd/yy) and optional output of time, if $G(Y)
 ;
 N IVMDATE,T
 S IVMDATE=$S(X:$TR($$FMTE^XLFDT(X,"2DF")," ","0"),1:"")
 I $G(Y) S T="."_$E($P(X,".",2)_"000000",1,7) I T>0 S IVMDATE=IVMDATE_" "_$S($E(T,2,3)>12:$E(T,2,3)-12,1:+$E(T,2,3))_":"_$E(T,4,5)_$S($E(T,2,5)>1200:" pm",1:" am")
 Q IVMDATE
 ;
 ;
DAT2(Y) ; extrinsic function - convert FM date to displayable (mmm dd yyyy) format
 ;
 ;  Input - Y as FM date
 ;
 ; Output - Y as displayable (mmm dd yyyy) date
 ;
 N %
 Q:Y']"" "" D D^DIQ
 Q Y
 ;
 ;
STATE1(X) ; extrinsic function - convert state abbreviation to state pointer
 ;
 ;  Input - X as state abbreviation
 ;
 ; Output - pointer to STATE (#5) file
 ;
 Q:'$D(X) ""
 S X=$E(X,1,2)
 Q $S(X="":X,1:+$O(^DIC(5,"C",X,0)))
 ;
 ;
PT(DFN) ; Returns patient name^long patient id^short patient id,
 ; or null if not found.
 ;  Input:    DFN  --  Pointer to the patient in file #2
 N X S X=""
 I $G(DFN) S X=$G(^DPT(+DFN,0)) I X'="" S X=$P(X,"^",1)_"^"_$P($G(^DPT(DFN,.36)),"^",3,4)
 Q X
 ;
 ;
NTE(DFN,IVMOUT,IVMMTDT) ; - entry point to get comments from a specified means test
 ;
 ; This function returns an array (specified by the user) which contains
 ; the comments associated with a specified means Test.  The comments
 ; are formatted in HL7 NTE segments.
 ;
 ;  Input:      DFN  as internal entry number from PATIENT (#2) file
 ;           IVMOUT  as specified reference array
 ;          IVMMTDT  as date of desired means test (default to latest MT)
 ;
 ; Output:   IVMOUT  array passed by reference containing comments
 ;                   formatted in HL7 NTE segments.
 ;
 ;
 N CTR,NODE,IVMDA,IVMIEN
 I '$G(DFN) G ENQ
 S IVMIEN=+$$LST^DGMTU(DFN,$S($G(IVMMTDT):IVMMTDT,1:DT))
 I $G(^DGMT(408.31,IVMIEN,"C",0))]"" D GET
ENQ Q
 ;
 ;
GET ; - get comment nodes and place in array
 S (CTR,IVMDA)=0
 F  S IVMDA=$O(^DGMT(408.31,IVMIEN,"C",IVMDA)) Q:'IVMDA  D
 .S NODE=$G(^DGMT(408.31,IVMIEN,"C",IVMDA,0))
 .I 'CTR,NODE="" Q  ; line feed from screen editor, maybe?
 .F  S CTR=CTR+1,IVMOUT(CTR)="NTE^"_CTR_"^^"_$E(NODE,1,120) Q:$L(NODE)'>120  S NODE=$E(NODE,121,255)
 Q
 ;
 ;
MSH(IVMNOMSH,IVMFLL,IVMREC,IVMCT,IVMCNTID) ; --
 ; Description: Message header processing for HL7 full data transmissions (Z07).
 ;
 ;  Input:
 ;    IVMNOMSH - (optional) if IVMNOMSH=1, means MSH segment should
 ;               not be built
 ;      IVMFLL - (optional) flag for creating MSA, QRD segments for FULL
 ;               query transmission, $G(IVMFLL) means yes. 
 ;      IVMREC - (optional) ien of #301.9001 multiple
 ;       IVMCT - count of segments transmitted, pass by reference
 ;
 ;   HL7 Variables:
 ;       HLMTN - HL7 message type name
 ;       HLECH - HL7 encoding characters
 ;       HLSDT - a flag that indicates that the data to be sent is
 ;               stored in the ^TMP("HLS") global array
 ;       HLMID - message id from CREATE^HLTF
 ;       HLEID - protocol id
 ;          HL - array of protocol data from INIT^HLFNC2
 ;
 ; Output:
 ;  ^TMP("HLS",$J,IVMCT) global array containing all segments of the HL7 message that the VistA application wishes to send.  The HLSDT and IVMCT variables are defined above.
 ;  IVMCNTID - as HL7 message control id concatenated with batch message counter, pass by reference
 ;
 N MID,RESULT
 D INIT^HLFNC2(HLEID,.HL)
 ;
 ;if MSH segment not needed, still need to compute IVMCNTID (msg controll id)
 I $G(IVMNOMSH) S IVMCNTID=$P($G(^TMP("HLS",$J,IVMCT-2)),HLFS,10)
 ;
 ; if not MSH segment, then build MSH segment
 I '$G(IVMNOMSH) D
 .S IVMCT=IVMCT+1
 .;
 .; - call HL7 utility to build MSH segment, set event type code
 .; for full transmission in MSH segment
 .S MID=HLMID_"-"_HLEVN
 .D MSH^HLFNC2(.HL,MID,.RESULT)
 .S ^TMP("HLS",$J,IVMCT)=RESULT
 .;
 .; - concatenate counter to msg control id (used for batch msgs)
 .D MSGID(.IVMCT)
 ;
 ; if flag for query response, create MSA & QRD segments
 I $G(IVMFLL) D
 .;
 .; - get query MSH segment control id of query message received from IVM
 .S IVMHLMID=$P($G(^IVM(301.9,1,10,+IVMREC,0)),"^",4)
 .;
 .; - create MSA segment, message control id must be referenced in
 .;   response to query (full trans) sent back to IVM
 .S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)="MSA"_HLFS_"AA"_HLFS_IVMHLMID_HLFS
 .;
 .; - get QRD segment of query message received from IVM
 .S IVMQRD=$G(^IVM(301.9,1,10,+IVMREC,"ST"))
 .;
 .; - create QRD segment, must be transmitted back to IVM when
 .;   responding to query rec'd from IVM
 .S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=IVMQRD
 ;
 Q
 ;
 ;
MSGID(IVMCT) ; --
 ; Description: Put the batch number (HL7 msg event counter) into MSH
 ; segment. Concatinate msg control id with hyphen msg event counter.
 ;
 ;  Input:
 ;       IVMCT - count of segments transmitted, pass by reference
 ;
 ;   HL7 Variables:
 ;       HLEVN - HL7 message event counter (# of events in an HL7 msg)
 ;       HLSDT - a flag that indicates that the data to be sent is
 ;                stored in the ^TMP("HLS") global array
 ;        HLFS - HL7 field separator
 ;
 ; Output:
 ;  ^TMP("HLS",$J,IVMCT) global array containing all segments of the HL7 message that the VistA application wishes to send.  The HLSDT and IVMCT variables are defined above.
 ;
 ; included logic to extract first piece of field (HL7 1.6 upgrade)
 ; just in case it has already been set
 S IVMCNTID=$P($P($G(^TMP("HLS",$J,IVMCT)),HLFS,10),"-",1)
 S IVMCNTID=IVMCNTID_"-"_HLEVN
 S $P(^TMP("HLS",$J,IVMCT),HLFS,10)=IVMCNTID
 Q
 ;
 ;
IEN(X) ; Get the ien for a segment from HL7 SEGMENT (#771.3) file
 ;  Input:  X  --  .01 field from file #771.3
 N DIC,Y
 S DIC="^HL(771.3,",DIC(0)="F" D ^DIC
 Q +Y
 ;
 ;
BTCLM(DFN,INDATE) ; --
 ; Description: This function will be used to find a patients Beneficiary Travel claim record for the current income year.
 ;
 ;  Input:
 ;      DFN - internal entry number of Patient (#2) file
 ;   INDATE - (optional) date that will be used to determine income year
 ;            to begin claim search
 ;
 ; Output:
 ;     Function Value - returns the internal entry number of the
 ;                      patients Beneficiary Travel claim record
 ;                      for the current income year, otherwise NULL.
 ;
 ; if DFN not passed, exit
 S IVMCLAIM="" I '$G(DFN) G BTCLMQ
 ;
 ; if INDATE not passed, default to today
 S INDATE=$S($D(INDATE):INDATE,1:DT)
 ;
 ; get most recent Beneficiary Travel claim for vet (reverse $O)
 S IVMCLAIM=$O(^DGBT(392,"C",DFN,IVMCLAIM),-1)
 ;
 ; if claim date not greater than 1/1 of INDATE year-1, set to null
 I $G(IVMCLAIM)'>($E(INDATE,1,3)-2_1231.999999) S IVMCLAIM=""
 ;
 ;
BTCLMQ Q IVMCLAIM
 ;
 ;
LD(DFN) ; --
 ; Description: This function will return a date based on the patient's
 ; last Means Test or Copay test.
 ;   1) The current year will be checked for a MT/CT, if found the
 ;      current date will be returned.  
 ;   2) The prior year will be checked for a MT/CT, if found the
 ;      last day (12/31) of prior year will be returned.
 ;   3) Otherwise, the current date will be returned.
 ;
 ;  Input:
 ;     DFN - as patient IEN
 ;
 ; Output:
 ;   Function Value - as date based on patient's last MT/CT
 ;
 N IVMLAST,IVMLD
 ;
 ; current date (default)
 S IVMLD=DT
 ;
 ; get date of last MT/CT for patient based on current date
 S IVMLAST=$P($$LST^DGMTCOU1(DFN,IVMLD),"^",2)
 ;
 D  ; drop out of do block if condition true
 .;
 .; if MT/CT not found
 .I 'IVMLAST Q
 .;
 .; if date of last MT/CT = current year
 .I $E(IVMLAST,1,3)=$E(DT,1,3) Q
 .;
 .; if date of last MT/CT = previous year, use end-of-previous year
 .I $E(IVMLAST,1,3)=($E(DT,1,3)-1) S IVMLD=$E(DT,1,3)-1_1231 Q
 ;
 Q IVMLD
