IBCNEDEP ;DAOU/ALA - Process Transaction Records ;17-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,300,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  This program finds records needing HL7 msg creation
 ;  Periodically check for stop request for background task
 ;
 ;  Variables
 ;    RETR = # retries allowed
 ;    MGRP = Msg Mailgroup
 ;    FAIL = # of days before failure
 ;    FMSG = Failure Mailman flag
 ;    TMSG = Timeout Mailman flag
 ;    FLDT = Failure date
 ;    FUTDT = Future transmission date
 ;    DFN = Patient IEN
 ;    PAYR = Payer IEN
 ;    DTCRT = Date Created
 ;    BUFF = Buffer File IEN
 ;    NRETR = # of retries accomplished
 ;    IHCNT = Count of successful HL7 msgs
 ;    QUERY = Type of msg
 ;    EXT =  Which extract produced record
 ;    SRVDT = Service Date
 ;    IRIEN = Insurance Record IEN
 ;    NTRAN = # of transmissions accomplished
 ;    OVRIDE = Override Flag
 ;    BNDL = Bundle Verification Flag
 ;
EN ;  Entry point
 ;
 ;  Start processing of data
 K ^TMP("HLS",$J),^TMP("IBQUERY",$J)
 ; Initialize count for periodic TaskMan check
 S IBCNETOT=0
 ;
 ;  Get IB Site Parameters
 S IBCNEP=$G(^IBE(350.9,1,51))
 S RETR=+$P(IBCNEP,U,6),BNDL=$P(IBCNEP,U,23)
 S MGRP=$$MGRP^IBCNEUT5()
 S FAIL=$P(IBCNEP,U,5),TMSG=$P(IBCNEP,U,7),FMSG=$P(IBCNEP,U,20)
 S FLDT=$$FMADD^XLFDT(DT,-FAIL)
 ; Statuses
 ;   1 = Ready To Transmit
 ;   2 = Transmitted
 ;   4 = Hold
 ;   6 = Retry
 ;
HLD ;  Go through the 'Hold' statuses, see if ready to be 'retried'
 S IEN=""
 F  S IEN=$O(^IBCN(365.1,"AC",4,IEN)) Q:IEN=""  D  Q:$G(ZTSTOP)
 . ; Update count for periodic check
 . S IBCNETOT=IBCNETOT+1
 . ; Check for request to stop background job, periodically
 . I $D(ZTQUEUED),IBCNETOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . ;
 . S FUTDT=$P($G(^IBCN(365.1,IEN,0)),U,9)
 . ;
 . ;  If the future date is today, set status to 'Retry',
 . ;  DON'T clear future transmission date. (Need date to see if this is the first
 . ;  time that the payer asked us to resubmit this inquiry.)
 . I FUTDT'>DT D SST^IBCNEUT2(IEN,6) ;D
 . ;. NEW DA,DIE,DR
 . ;. S DA=IEN,DIE="^IBCN(365.1,",DR=".09///@" D ^DIE
 ;
 ; Exit based on stop request
 I $G(ZTSTOP) G EXIT
 ;
TMT ;  If the status is 'Transmitted' - is this a 'Retry' or
 ;  'Comm Failure'
 S IEN=""
 F  S IEN=$O(^IBCN(365.1,"AC",2,IEN)) Q:IEN=""  D  Q:$G(ZTSTOP)
 . ; Update count for periodic check
 . S IBCNETOT=IBCNETOT+1
 . ; Check for request to stop background job, periodically
 . I $D(ZTQUEUED),IBCNETOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . ;
 . NEW TDATA,DTCRT,BUFF,DFN,PAYR,XMSUB,VERID
 . S TDATA=$G(^IBCN(365.1,IEN,0))
 . S DFN=$P(TDATA,U,2),PAYR=$P(TDATA,U,3)
 . S DTCRT=$P(TDATA,U,6)\1,BUFF=$P(TDATA,U,5)
 . S VERID=$P(TDATA,U,11)
 . ;
 . ;  Check against the Failure Date
 . I DTCRT>FLDT Q
 . ;
 . ;  If retries are defined
 . I RETR>0 D  Q
 .. ;
 .. ;  Send timeout mail msg
 .. I PAYR'=$$FIND1^DIC(365.12,"","X","~NO PAYER") D TMRR^IBCNEDEQ
 .. D SST^IBCNEUT2(IEN,6)
 . ;
 . ; If no retries defined, set to fail
 . D SST^IBCNEUT2(IEN,5)
 . ;
 . ;  For msg in the Response file set the status to
 . ; 'Comm Failure'
 . D RSTA^IBCNEUT7(IEN)
 . ;
 . ;  Set Buffer symbol to 'B12' (Comm Failure)
 . I BUFF'="" D BUFF^IBCNEUT2(BUFF,15)
 . ;
 . I PAYR=$$FIND1^DIC(365.12,"","X","~NO PAYER") Q
 . ;
 . ; Issue comm fail MailMan msg only for ver'ns
 . I VERID="V" D CERR^IBCNEDEQ
 ;
 ; Exit for stop request
 I $G(ZTSTOP) G EXIT
 ;
RET ;  If status is 'Retry'
 S IEN=""
 F  S IEN=$O(^IBCN(365.1,"AC",6,IEN)) Q:IEN=""  D  Q:$G(ZTSTOP)
 . ; Update count for periodic check
 . S IBCNETOT=IBCNETOT+1
 . ; Check for request to stop background job, periodically
 . I $D(ZTQUEUED),IBCNETOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . ;
 . NEW TDATA,NRETR,PAYR,BUFF,DFN,MSG,RIEN,HIEN,XMSUB,VERID
 . S TDATA=$G(^IBCN(365.1,IEN,0))
 . S NRETR=$P(TDATA,U,8),PAYR=$P(TDATA,U,3)
 . S BUFF=$P(TDATA,U,5),DFN=$P(TDATA,U,2)
 . S VERID=$P(TDATA,U,11)
 . S NRETR=NRETR+1
 . ;
 . ;  If retries are finished, set to fail
 . I NRETR>RETR D  Q
 .. D SST^IBCNEUT2(IEN,5)
 .. ;
 .. ;  Set Buffer symbol to 'B12' (Comm Failure)
 .. I BUFF'="" D BUFF^IBCNEUT2(BUFF,15)
 .. ;
 .. ;  For msg in the Response file set the status to
 .. ; 'Comm Failure'
 .. D RSTA^IBCNEUT7(IEN)
 .. I PAYR=$$FIND1^DIC(365.12,"","X","~NO PAYER") Q
 .. ;
 .. I VERID="V" D CERE^IBCNEDEQ
 . ; If generating retry, set eIV status to comm failure (5) for
 . ; remaining related responses
 . D RSTA^IBCNEUT7(IEN)
 ;
 ; Exit for stop request
 I $G(ZTSTOP) G EXIT
 ;
FIN ; Prioritize requests for statuses 'Retry' and 'Ready to Transmit'
 ;
 ;  Separate inquiries into verifications, identifications,
 ;  and "fishes" - VNUM = Priority of output
 F STA=1,6 S IEN="" D
 . F  S IEN=$O(^IBCN(365.1,"AC",STA,IEN)) Q:IEN=""  D
 .. S IBDATA=$G(^IBCN(365.1,IEN,0)) Q:IBDATA=""
 .. S QUERY=$P(IBDATA,U,11),DFN=$P(IBDATA,U,2),OVRIDE=$P(IBDATA,U,14)
 .. S PAYR=$P(IBDATA,U,3)
 .. I QUERY="V" S VNUM=3
 .. I QUERY'="V" D
 ... I PAYR=$$FIND1^DIC(365.12,,"X","~NO PAYER") S VNUM=5 Q
 ... S VNUM=4
 .. I OVRIDE'="" D
 ... I PAYR=$$FIND1^DIC(365.12,,"X","~NO PAYER") S VNUM=2 Q
 ... S VNUM=1
 .. S ^TMP("IBQUERY",$J,VNUM,DFN,IEN)=""
 ;
LP ;  Loop through priorities, process as either verifications
 ;  or identifications
 S VNUM="",IHCNT=0
 F  S VNUM=$O(^TMP("IBQUERY",$J,VNUM)) Q:VNUM=""  D  Q:$G(ZTSTOP)!$G(QFL)=1
 . I VNUM=1!(VNUM=3) D VER Q
 . ;D ID
 ;
EXIT ;  Finish
 K BUFF,CNT,D,D0,DA,DFN,DI,DIC,DIE,DISYS,DQ,DR,DTCRT,EXT,FAIL,FLDT,FUTDT
 K FRDT,FMSG,GT1,HCT,HIEN,HL,HLCDOM,HLCINS,HLCS,HLCSTCP,HLDOM,HLECH,%I,%H
 K HLEID,HLFS,HLHDR,HLINST,HLIP,HLN,HLPARAM,HLPROD,HLQ,HLRESLT,XMSUB
 K HLSAN,HLTYPE,HLX,IBCNEP,IBCNHLP,IEN,IN1,IRIEN,MDTM,MGRP,MSGID,TOT
 K NRETR,NTRAN,OVRIDE,PAYR,PID,QFL,QUERY,RETR,RSIEN,SRVDT,STA,TRANSR,X
 K ZMID,^TMP("IBQUERY",$J),Y,DOD,DGREL,TMSG,RSTYPE,OMSGID,QFL
 K IBCNETOT,HLP,SUBID,VNUM,BNDL,IBDATA,PATID
 Q
 ;
VER ;  Initialize HL7 variables protocol for Verifications
 S IBCNHLP="IBCNE IIV RQV OUT"
 D INIT^IBCNEHLO
 ;
 S DFN=""
 F  S DFN=$O(^TMP("IBQUERY",$J,VNUM,DFN)) Q:DFN=""  D  Q:$G(ZTSTOP)
 . ;
 . ;  If the INQUIRE SECONDARY INSURANCES flag is 'yes',
 . ;  bundle verifications together, send a continuation pointer
 . I VNUM=3,BNDL D  Q:QFL
 .. S TOT=0,IEN="",QFL=0
 .. F  S IEN=$O(^TMP("IBQUERY",$J,VNUM,DFN,IEN)) Q:IEN=""  S TOT=TOT+1
 . ;
 . S IEN="",OMSGID="",QFL=0,CNT=0
 . F  S IEN=$O(^TMP("IBQUERY",$J,VNUM,DFN,IEN)) Q:IEN=""  D  Q:$G(ZTSTOP)
 .. ; Update count for periodic check
 .. S IBCNETOT=IBCNETOT+1
 .. ; Check for request to stop background job, periodically
 .. I $D(ZTQUEUED),IBCNETOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 .. ;
 .. D PROC I PID="" Q
 .. ;
 .. I BNDL S HLP("CONTPTR")=$G(OMSGID)
 .. ; D GENERATE^HLMA(HLEID,"GM",1,.HLRESLT,"",.HLP)
 .. D GENERATE^HLMA(IBCNHLP,"GM",1,.HLRESLT,"",.HLP)
 .. K ^TMP("HLS",$J),HLP
 .. ;
 .. ;  If not successful
 .. I $P(HLRESLT,U,2)]"" D HLER^IBCNEDEQ Q
 .. ;  If successful
 .. D SCC^IBCNEDEQ
 .. I BNDL D
 ... I CNT=1 S OMSGID=MSGID
 ;
 K HL,IN1,GT1,PID,DFN,^TMP($J,"HLS")
 Q
 ;
ID ;  Send Identification Msgs
 ;
 ;  Initialize the HL7 variables based on the HL7 protocol
 S IBCNHLP="IBCNE IIV RQI OUT"
 D INIT^IBCNEHLO
 ;
 S DFN=""
 F  S DFN=$O(^TMP("IBQUERY",$J,VNUM,DFN)) Q:DFN=""  D  Q:$G(ZTSTOP)!QFL
 . ; Update count for periodic check
 . S IBCNETOT=IBCNETOT+1
 . ; Check for request to stop background job, periodically
 . I $D(ZTQUEUED),IBCNETOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . ;
 . S TOT=0,IEN="",CNT=0,OMSGID="",QFL=0
 . ;
 . ;  Get the total # of identification msgs for a patient
 . F  S IEN=$O(^TMP("IBQUERY",$J,VNUM,DFN,IEN)) Q:IEN=""  S TOT=TOT+1
 . ;
 . ;  For each identification transaction generate an HL7 msg
 . F  S IEN=$O(^TMP("IBQUERY",$J,VNUM,DFN,IEN)) Q:IEN=""  D
 .. D PROC
 .. ;
 .. I VNUM=4 S HLP("CONTPTR")=$G(OMSGID)
 .. ; D GENERATE^HLMA(HLEID,"GM",1,.HLRESLT,"",.HLP)
 .. D GENERATE^HLMA(IBCNHLP,"GM",1,.HLRESLT,"",.HLP)
 .. K ^TMP("HLS",$J),HLP
 .. ;
 .. ;  If not successful
 .. I $P(HLRESLT,U,2)]"" D HLER^IBCNEDEQ Q
 .. ;
 .. ;  If successful
 .. D SCC^IBCNEDEQ
 .. I VNUM=4 D
 ... I CNT=1 S OMSGID=MSGID
 ;
 Q
 ;
PROC ;  Process TQ record
 S TRANSR=$G(^IBCN(365.1,IEN,0))
 S DFN=$P(TRANSR,U,2),PAYR=$P(TRANSR,U,3),BUFF=$P(TRANSR,U,5)
 S QUERY=$P(TRANSR,U,11),EXT=$P(TRANSR,U,10),SRVDT=$P(TRANSR,U,12)
 S IRIEN=$P(TRANSR,U,13),HCT=0,NTRAN=$P(TRANSR,U,7),NRETR=$P(TRANSR,U,8)
 S SUBID=$P(TRANSR,U,16),OVRIDE=$P(TRANSR,U,14),STA=$P(TRANSR,U,4)
 S FRDT=$P(TRANSR,U,17),PATID=$P(TRANSR,U,19)
 ;
 ;  Build the HL7 msg
 S HCT=HCT+1,^TMP("HLS",$J,HCT)="PRD|NA"
 D PID^IBCNEHLQ I PID=""!(PID?."*") Q
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=$TR(PID,"*","")
 D GT1^IBCNEHLQ I GT1'="",GT1'?."*" S HCT=HCT+1,^TMP("HLS",$J,HCT)=$TR(GT1,"*","")
 D IN1^IBCNEHLQ I IN1'="",IN1'?."*" D
 . S HCT=HCT+1
 . I VNUM=1 S ^TMP("HLS",$J,HCT)=$TR(IN1,"*","") Q
 . I VNUM=2,'BNDL S ^TMP("HLS",$J,HCT)=$TR(IN1,"*","") Q
 . S CNT=CNT+1
 . S $P(IN1,HLFS,22)=TOT,$P(IN1,HLFS,21)=CNT
 . S ^TMP("HLS",$J,HCT)=$TR(IN1,"*","")
 Q
