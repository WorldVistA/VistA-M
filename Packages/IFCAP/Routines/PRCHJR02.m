PRCHJR02 ;OI&T/KCL - IFCAP/ECMS INTERFACE PROCESS ACK FOR 2237 SEND;6/12/12
 ;;5.1;IFCAP;**167**;Oct 20, 2000;Build 17
 ;Per VHA Directive 2004-38, this routine should not be modified.
 ;
APPACK ;Process ACK (ORN^O08) msg
 ;This tag^routine is called from an entry in the HLO Application
 ;Registry (#779.2) file. It's responsible for receiving and
 ;processing application acknowledgment (ORN^O08) messages
 ;returned from eCMS. The application acknowledgment is being
 ;returned in response to a OMN^O07 message that was sent from
 ;IFCAP to eCMS containing a 2237 transaction.
 ;
 ; Input: At the point this tag is called, the HLO variable
 ;        HLMSGIEN is set to the IEN of the message in HLO
 ;        MESSAGES (#778) file.
 ;
 N PRCDUPE  ;duplicate msg error flag
 N PRCER    ;error returned by $$LOG^PRCHJTA
 N PRCERR   ;error returned by FIND1^DIC
 N PRCEVNT  ;input event array for $$LOG^PRCHJTA
 N PRCHDR   ;fields from the MSH segment, pass by ref
 N PRCI     ;subscript for looping thru work global
 N PRCJ     ;subscript for PRCEVNT("ERROR") array
 N PRCIDX1  ;index for potential multiple ERR segs
 N PRCIDX2  ;index for potential multiple ORC segs
 N PRCIDX3  ;index for potential multiple RQD segs
 N PRCMSG   ;administrative information about the msg
 N PRCMSGID ;msg control id (MSH-10)
 N PRCTRAN  ;2237 transaction #
 N PRCTXT   ;subscript for lines of text returned by ^DIWP
 N PRCWORK  ;work global ^XTMP that will contain parsed data fields
 N PRC410R  ;ien of record in (#410) file
 ;
 ;start parsing the ack msg
 I '$$STARTMSG^HLOPRS(.PRCMSG,HLMSGIEN,.PRCHDR) Q
 ;
 ;quit if not the expected msg
 I PRCMSG("BATCH") Q
 I PRCMSG("MESSAGE TYPE")'="ORN" Q
 I PRCMSG("EVENT")'="O08" Q
 ;
 ;get any MSH segment fields that are needed
 S PRCMSGID=$G(PRCHDR("MESSAGE CONTROL ID")) ;MSH-10
 ;
 ;initialize ^XTMP work global
 S PRCWORK="PRCHJRACK"_PRCMSGID
 K ^XTMP(PRCWORK)
 S ^XTMP(PRCWORK,0)=$$FMADD^XLFDT(DT,3)_U_DT_U_"IFCAP - Process eCMS ACK (ORN^O08) message for 2237 Send"
 ;
 ;step thru the msg segments and parse them
 S (PRCIDX1,PRCIDX2,PRCIDX3)=0
 F  Q:'$$NEXTSEG^HLOPRS(.PRCMSG,.PRCSEG)  D
 . I PRCSEG("SEGMENT TYPE")="MSA" D MSA(.PRCSEG,PRCWORK)
 . I PRCSEG("SEGMENT TYPE")="ERR" D ERR(.PRCSEG,PRCWORK,.PRCIDX1)
 . I PRCSEG("SEGMENT TYPE")="ORC" D ORC(.PRCSEG,PRCWORK,.PRCIDX2)
 . I PRCSEG("SEGMENT TYPE")="RQD" D RQD(.PRCSEG,PRCWORK,.PRCIDX3)
 ;
 ;now process the parsed data, quit if nothing in work global to process
 I '$D(^XTMP(PRCWORK,"MSA")) Q
 ;
 S PRCTRAN=$G(^XTMP(PRCWORK,"MSA","2237 TXN"))
 ;
 ;lookup record in (#410) file using 2237 transaction #
 S PRC410R=$$FIND1^DIC(410,"","X",$G(PRCTRAN),"","","PRCERR")
 Q:('PRC410R)!($D(PRCERR))
 ;
 ;if Application Accept DO block
 I $G(^XTMP(PRCWORK,"MSA","ACK CODE"))="AA" D
 . ;
 . ;store ECMS ACTIONUID in (#410) file
 . I '$$STOAUID(PRC410R,$G(^XTMP(PRCWORK,"MSA","ECMS ACTIONUID"))) Q
 . ;
 . ;store ECMS ITEMUID for each item on the 2237
 . S PRCI=0
 . F  S PRCI=$O(^XTMP(PRCWORK,"RQD",PRCI)) Q:PRCI=""  D
 . . I $G(^XTMP(PRCWORK,"ORC",PRCI,"ORDER CONTROL"))="UA" Q
 . . I '$$STOITID(PRC410R,$G(^XTMP(PRCWORK,"RQD",PRCI,"LINE ITEM")),$G(^XTMP(PRCWORK,"RQD",PRCI,"ECMS ITEMUID"))) Q
 . ;
 . ;log AA ack in IFCAP/ECMS TRANSACTION (#414.06) file
 . S PRCEVNT("MSGID")=$G(PRCMSGID)
 . S PRCEVNT("IEN410")=PRC410R
 . D LOG^PRCHJTA($G(PRCTRAN),$G(^XTMP(PRCWORK,"MSA","ECMS ACTIONUID")),2,.PRCEVNT,.PRCER)
 ;
 ;
 ;if Application Reject or Error DO block
 I ($G(^XTMP(PRCWORK,"MSA","ACK CODE"))="AR")!($G(^XTMP(PRCWORK,"MSA","ACK CODE"))="AE") D
 . ;
 . ;setup PRCEVNT array for call to LOG^PRCHJTA
 . S PRCEVNT("MSGID")=$G(PRCMSGID)
 . S PRCEVNT("IEN410")=PRC410R
 . S (PRCI,PRCJ)=0
 . ;for each error returned in ack, set parsed fields into error event array
 . F  S PRCI=$O(^XTMP(PRCWORK,"ERR",PRCI)) Q:PRCI=""  D
 . . ;check if this a duplicate msg error, set flag if it is
 . . I $G(^XTMP(PRCWORK,"ERR",PRCI,"APPERR ID"))=2 S PRCDUPE=1
 . . ;place error into error array
 . . S PRCJ=PRCJ+3 ;leave the 1 & 2 node open for additional text for call to PHMSG^PRCHJMSG
 . . S PRCEVNT("ERROR",PRCJ)="Error #: "_PRCI S PRCJ=PRCJ+1
 . . S PRCEVNT("ERROR",PRCJ)="Severity: "_$G(^XTMP(PRCWORK,"ERR",PRCI,"SEVERITY")) S PRCJ=PRCJ+1
 . . ;
 . . ;user error msg can be a string up to 250 chars so
 . . ;format into lines of 70 chars max using ^DIWP
 . . N DIWF,DIWL,DIWR,X
 . . S DIWL=1,DIWR=70,(DIWF,X)="" K ^UTILITY($J,"W")
 . . S X="Error Message: "_$G(^XTMP(PRCWORK,"ERR",PRCI,"USER MSG"))
 . . D ^DIWP
 . . S PRCTXT=0
 . . F  S PRCTXT=$O(^UTILITY($J,"W",1,PRCTXT)) Q:PRCTXT=""  D
 . . . S PRCEVNT("ERROR",PRCJ)=$G(^UTILITY($J,"W",1,PRCTXT,0)) S PRCJ=PRCJ+1
 . . ;
 . . S PRCEVNT("ERROR",PRCJ)="Original Message Control ID: "_$G(^XTMP(PRCWORK,"MSA","CONTROL ID")) S PRCJ=PRCJ+1
 . . S PRCEVNT("ERROR",PRCJ)="Segment ID: "_$G(^XTMP(PRCWORK,"ERR",PRCI,"SEG ID")) S PRCJ=PRCJ+1
 . . S PRCEVNT("ERROR",PRCJ)="Segment Sequence: "_$G(^XTMP(PRCWORK,"ERR",PRCI,"SEG SEQ")) S PRCJ=PRCJ+1
 . . S PRCEVNT("ERROR",PRCJ)="Field Position: "_$G(^XTMP(PRCWORK,"ERR",PRCI,"FIELD POS")) S PRCJ=PRCJ+1
 . . S PRCEVNT("ERROR",PRCJ)="Field Component: "_$G(^XTMP(PRCWORK,"ERR",PRCI,"COMP")) S PRCJ=PRCJ+1
 . . S PRCEVNT("ERROR",PRCJ)="Field Sub-Component: "_$G(^XTMP(PRCWORK,"ERR",PRCI,"SUBCOMP")) S PRCJ=PRCJ+1
 . . S PRCEVNT("ERROR",PRCJ)="Field Repetition: "_$G(^XTMP(PRCWORK,"ERR",PRCI,"FIELD REP")) S PRCJ=PRCJ+1
 . . S PRCEVNT("ERROR",PRCJ)="HL7 Error Code: "_$G(^XTMP(PRCWORK,"ERR",PRCI,"ERRCODE ID")) S PRCJ=PRCJ+1
 . . S PRCEVNT("ERROR",PRCJ)="HL7 Error Text: "_$G(^XTMP(PRCWORK,"ERR",PRCI,"ERRCODE TXT")) S PRCJ=PRCJ+1
 . . S PRCEVNT("ERROR",PRCJ)="Coding System: "_$G(^XTMP(PRCWORK,"ERR",PRCI,"ERRCODE SYS")) S PRCJ=PRCJ+1
 . . S PRCEVNT("ERROR",PRCJ)="Application Error Code: "_$G(^XTMP(PRCWORK,"ERR",PRCI,"APPERR ID")) S PRCJ=PRCJ+1
 . . S PRCEVNT("ERROR",PRCJ)="Application Error Text: "_$G(^XTMP(PRCWORK,"ERR",PRCI,"APPERR TXT"))
 . ;
 . ;log error(s) contained in PRCEVNT array into IFCAP/ECMS TRANSACTION (#414.06) file
 . D LOG^PRCHJTA($G(PRCTRAN),,2,.PRCEVNT,.PRCER)
 . ;
 . ;send mailman error notification msg to Accountable Officer
 . N PRCMSG1,PRCMSG2 ;input array 1 & 2 for PHMSG^PRCHJMSG, pass by ref
 . S PRCMSG1(1)=$G(PRCTRAN)
 . S PRCMSG1(2)=1 ;ack reject
 . S PRCMSG1(3)=$G(PRCHDR("DT/TM OF MESSAGE")) ;MSH-7
 . S PRCMSG1(7)="Please forward this message to appropriate OIT staff!"
 . ;if not a duplicate msg error, set 1 node of error PRCEVNT array, if dupe status won't be reset 
 . I '$G(PRCDUPE) S PRCEVNT("ERROR",1)="Status of request is being reset to 'Pending Accountable Officer Sig.'"
 . S PRCEVNT("ERROR",2)=""
 . M PRCMSG2=PRCEVNT("ERROR") ;merge error array into PRCMSG2 array
 . D PHMSG^PRCHJMSG(.PRCMSG1,.PRCMSG2) ;send msg
 . ;
 . ;if not a duplicate msg error, return 2237 to Accountable Officer and remove signatures
 . I '$G(PRCDUPE) D
 . . I '$$UPD443^PRCHJUTL(PRC410R,.PRCER) Q
 . . I '$$UPD410^PRCHJUTL(PRC410R,.PRCER) Q
 . ;
 . ;reset original msg purge date/time to 1 month in future for trouble-shooting
 . I '$$SETPURGE^HLOAPI3($G(PRCMSG("ACK TO IEN")),$$FMADD^XLFDT($$NOW^XLFDT,30)) Q
 ;
 Q
 ;
 ;
MSA(PRCSEG,PRCWRK) ;Parse MSA segment
 ;This procedure is used to retrieve the data elements from the
 ;MSA segment and place them into the ^XTMP work global.
 ;
 ;  Input:
 ;    PRCSEG - (required) Contains all the individual values parsed from the segment
 ;    PRCWRK - (required) Namespace of ^XTMP work global
 ;
 ; Output: None
 ;
 N PRCTMP ;temp var
 ;
 S ^XTMP(PRCWRK,"MSA","ACK CODE")=$$GET^HLOPRS(.PRCSEG,1) ;AA, AE, OR AR
 S ^XTMP(PRCWRK,"MSA","CONTROL ID")=$$GET^HLOPRS(.PRCSEG,2) ;control ID of original msg
 S PRCTMP=$$GET^HLOPRS(.PRCSEG,3) ;2237 number and eCMS ActionUID number separated by *
 S ^XTMP(PRCWRK,"MSA","2237 TXN")=$P($G(PRCTMP),"*")
 S ^XTMP(PRCWRK,"MSA","ECMS ACTIONUID")=$P($G(PRCTMP),"*",2)
 Q
 ;
 ;
ERR(PRCSEG,PRCWRK,PRCIDX) ;Parse ERR segment
 ;This procedure is used to retrieve the data elementsc from the
 ;ERR segment and place them into the ^XTMP work global.
 ;
 ;  Input:
 ;    PRCSEG - (required) Contains all the individual values parsed from the segment
 ;    PRCWRK - (required) Namespace of ^XTMP work global
 ;    PRCIDX - (required) Index for multiple ERR segments, passed by ref
 ;
 ; Output: None
 ;
 N PRCTMP ;temp var for any data conversion
 ;
 S PRCIDX=$G(PRCIDX)+1 ;increment index
 S PRCTMP=$$GET^HLOPRS(.PRCSEG,2,1)
 S ^XTMP(PRCWRK,"ERR",PRCIDX,"SEG ID")=$S(PRCTMP'="":PRCTMP,1:"n/a") ;field is not required
 S PRCTMP=$$GET^HLOPRS(.PRCSEG,2,2)
 S ^XTMP(PRCWRK,"ERR",PRCIDX,"SEG SEQ")=$S(PRCTMP'="":PRCTMP,1:"n/a") ;field is not required
 S PRCTMP=$$GET^HLOPRS(.PRCSEG,2,3)
 S ^XTMP(PRCWRK,"ERR",PRCIDX,"FIELD POS")=$S(PRCTMP'="":PRCTMP,1:"n/a") ;field is not required
 S PRCTMP=$$GET^HLOPRS(.PRCSEG,2,4)
 S ^XTMP(PRCWRK,"ERR",PRCIDX,"FIELD REP")=$S(PRCTMP'="":PRCTMP,1:"n/a") ;field is not required
 S PRCTMP=$$GET^HLOPRS(.PRCSEG,2,5)
 S ^XTMP(PRCWRK,"ERR",PRCIDX,"COMP")=$S(PRCTMP'="":PRCTMP,1:"n/a") ;field is not required
 S PRCTMP=$$GET^HLOPRS(.PRCSEG,2,6)
 S ^XTMP(PRCWRK,"ERR",PRCIDX,"SUBCOMP")=$S(PRCTMP'="":PRCTMP,1:"n/a") ;field is not required
 S ^XTMP(PRCWRK,"ERR",PRCIDX,"ERRCODE ID")=$$GET^HLOPRS(.PRCSEG,3,1)
 S ^XTMP(PRCWRK,"ERR",PRCIDX,"ERRCODE TXT")=$$GET^HLOPRS(.PRCSEG,3,2)
 S ^XTMP(PRCWRK,"ERR",PRCIDX,"ERRCODE SYS")=$$GET^HLOPRS(.PRCSEG,3,3)
 S PRCTMP=$$GET^HLOPRS(.PRCSEG,4) ;convert severity code to text
 S ^XTMP(PRCWRK,"ERR",PRCIDX,"SEVERITY")=$S(PRCTMP="E":"Error",PRCTMP="I":"Information",PRCTMP="W":"Warning",1:"Unknown")
 S ^XTMP(PRCWRK,"ERR",PRCIDX,"APPERR ID")=$$GET^HLOPRS(.PRCSEG,5,1)
 S ^XTMP(PRCWRK,"ERR",PRCIDX,"APPERR TXT")=$$GET^HLOPRS(.PRCSEG,5,2)
 S ^XTMP(PRCWRK,"ERR",PRCIDX,"USER MSG")=$$GET^HLOPRS(.PRCSEG,8)
 Q
 ;
 ;
ORC(PRCSEG,PRCWRK,PRCIDX) ;Parse ORC segment
 ;This procedure is used to retrieve the data elements from the
 ;ORC segment and place them into the ^XTMP work global.
 ;
 ;  Input:
 ;    PRCSEG - (required) Contains all the individual values parsed from the segment
 ;    PRCWRK - (required) Namespace of ^XTMP work global
 ;    PRCIDX - (required) Index for multiple ERR segments, passed by ref
 ;
 ; Output: None
 ;
 S PRCIDX=$G(PRCIDX)+1 ;increment index
 S ^XTMP(PRCWRK,"ORC",PRCIDX,"ORDER CONTROL")=$$GET^HLOPRS(.PRCSEG,1) ;OK if 2237 is accepted, UA if not
 S ^XTMP(PRCWRK,"ORC",PRCIDX,"2237 TXN")=$$GET^HLOPRS(.PRCSEG,2,1)
 S ^XTMP(PRCWRK,"ORC",PRCIDX,"ECMS ACTIONUID")=$$GET^HLOPRS(.PRCSEG,3,1)
 Q
 ;
 ;
RQD(PRCSEG,PRCWRK,PRCIDX) ;Parse RQD segment
 ;This procedure is used to retrieve the data elements from the
 ;RQD segment and place them into the ^XTMP work global.
 ;
 ;  Input:
 ;    PRCSEG - (required) Contains all the individual values parsed from the segment
 ;    PRCWRK - (required) Namespace of ^XTMP work global
 ;    PRCIDX - (required) Index for multiple ERR segments, passed by ref
 ;
 ; Output: None
 ;
 S PRCIDX=$G(PRCIDX)+1 ;increment index
 S ^XTMP(PRCWRK,"RQD",PRCIDX,"LINE ITEM")=$$GET^HLOPRS(.PRCSEG,1)
 S ^XTMP(PRCWRK,"RQD",PRCIDX,"ECMS ITEMUID")=$$GET^HLOPRS(.PRCSEG,2,1)
 Q
 ;
 ;
STOAUID(PRC410R,PRCAUID,PRCERR) ;Store eCMS ActionUID
 ;This function is used to store the following field into
 ;a record in the CONTROL POINT ACTIVITY (#410) file:
 ;
 ; Field Name      Field #
 ; --------------  -------
 ; ECMS ACTIONUID  103
 ;
 ;  Input:
 ;  PRC410R - (required) IEN of record in CONTROL POINT ACTIVITY (#410) file
 ;  PRCAUID - (required) ECMS ACTIONUID field value to be filed  
 ;
 ; Output:
 ;   Function Value - returns 1 on success, 0 on failure
 ;           PRCERR - (optional) on failure, an error message is returned,
 ;                    pass by ref
 ;
 N PRCRSLT ;function result
 N PRCIENS ;iens string for FM data array
 N PRCFDA  ;FM data array
 ;
 S PRC410R=+$G(PRC410R)
 S PRCAUID=$G(PRCAUID)
 S PRCRSLT=0
 S PRCERR="ECMS ACTIONUID not filed: Invalid input parameters"
 ;
 I PRC410R>0,($D(^PRCS(410,PRC410R))),(PRCAUID]"") D
 . K PRCERR
 . S PRCIENS=PRC410R_","
 . S PRCFDA(410,PRCIENS,103)=PRCAUID
 . D FILE^DIE("K","PRCFDA","PRCERR")
 . ;
 . ;quit on filer error
 . I $D(PRCERR) S PRCERR="ECMS ACTIONUID not filed: "_$G(PRCERR("DIERR","1","TEXT",1)) Q
 . ;
 . ;success
 . S PRCRSLT=1
 ;
 Q PRCRSLT
 ;
 ;
STOITID(PRC410R,PRCIT,PRCITID,PRCERR) ;Store eCMS ItemUID
 ;This function is used to store the following field into
 ;a record in the ITEM (#410.02) multiple of the CONTROL
 ;POINT ACTIVITY (#410) file:
 ;
 ; Field Name      Field #
 ; --------------  -------
 ; ECMS ITEMUID    100
 ;
 ;  Input:
 ;  PRC410R - (required) IEN of record in CONTROL POINT ACTIVITY (#410) file
 ;    PRCIT - (required) Line Item Number
 ;   PRCTID - (required) ECMS ITEMUID field value to be filed 
 ;
 ; Output:
 ;   Function Value - returns 1 on success, 0 on failure
 ;           PRCERR - (optional) on failure, an error message is returned,
 ;                    pass by ref
 ;
 N PRCRSLT ;function result
 N PRCIENS ;iens string for FM data array
 N PRCFDA  ;FM data array
 ;
 S PRC410R=+$G(PRC410R)
 S PRCIT=+$G(PRCIT)
 S PRCITID=$G(PRCITID)
 S PRCRSLT=0
 S PRCERR="ECMS ITEMUID not filed: Invalid input parameters"
 ;
 I PRC410R>0,$D(^PRCS(410,PRC410R)),PRCIT>0,PRCITID]"" D
 . ;resolve Line Item Number to Item entry's ien and setup iens string for FM data array
 . S PRCIENS=$O(^PRCS(410,PRC410R,"IT","B",PRCIT,0))_","_PRC410R_","
 . S PRCFDA(410.02,PRCIENS,100)=PRCITID
 . K PRCERR
 . D FILE^DIE("K","PRCFDA","PRCERR")
 . ;
 . ;quit on filer error
 . I $D(PRCERR) S PRCERR="ECMS ITEMUID not filed: "_$G(PRCERR("DIERR","1","TEXT",1)) Q
 . ;
 . ;success
 . S PRCRSLT=1
 ;
 Q PRCRSLT
