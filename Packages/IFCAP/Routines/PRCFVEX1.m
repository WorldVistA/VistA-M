PRCFVEX1 ;WASH IRM/KCMO;SERVER to process returned DUNS numbers; ;8/26/96  11:33
 ;;5.0;IFCAP;**84**;4/21/95
 ;
 Q:XQSUB'["EDV"  ; Must be one of our Messages
 N FACID,XMSER,XMZ,IEN,DUNS,CURR,I K ^TMP($J)
 S FACID=$P($G(^XTV(8989.3,1,"XUS")),U,17) ;Default Institution KSP
 S XMZ=XQMSG
 ;
REC ; -- Read the Msg lines, Parse and Process
 X XMREC G STAT:XMER<0 D  G REC
 . Q:$P(XMRG,U)'[FACID  ; -- Line must begin with Station Number
 . S IEN=$P(XMRG,U,2),DUNS=$P($P(XMRG,U,3),"|")
 . ; -- Ensure Record Exists
 . I '$D(^PRC(440,+IEN,0))#2 Q  ;
 . ; -- Get Current Value if any, either file or report
 . S CURR=$P($G(^PRC(440,+IEN,7)),U,12) I CURR'=DUNS D  Q  ;
 . . ;I $L(CURR) S ^TMP($J,+IEN)="Record: "_IEN_"  Current: "_CURR_"  D&B: "_DUNS_" *Data has been edited since Extract run."
 . . ; -- Validate the Data using silent FM
 . . K TMP D VAL^DIE(440,+IEN_",","18.3","",DUNS,.X)
 . . I X["^" S ^TMP($J,+IEN)="Record: "_IEN_"  D&B: "_DUNS_"  *Failed Validation" Q
 . . ; -- File it, FDA created in validation
 . . S TMP(440,+IEN_",",18.3)=DUNS D FILE^DIE("","TMP")
 . . I $D(DIERR)#2 S ^TMP($J,+IEN)="Record: "_IEN_"  D&B: "_DUNS_"  *Unable to File" Q
 Q
STAT ; -- Mail the Discrepency Report
 I $O(^TMP($J,0))>0 D  ;
 . N XMSUB,XMTEXT,XMDUZ,XMY
 . S ^TMP($J,.5)="The following DUNS# were not filed in the VENDOR file"
 . S ^TMP($J,.6)="and will need to be entered manually."
 . S ^TMP($J,.7)=" "
 . S XMSUB="IFCAP Vendor DUNS Upload Discrepency Report"
 . S XMTEXT="^TMP($J,",XMY("G.EDV")="",XMDUZ="PRCFVEX1" D ^XMD
JOB ; -- Mail the Job Completion Message
 ;N XMSUB,XMTEXT,XMDUZ,XMY K ^TMP($J)
 ;S ^TMP($J,1)="The Dun & Bradstreet message: "
 ;S ^TMP($J,2)="",^TMP($J,3)="    "_XQSUB,^TMP($J,4)=""
 ;S ^TMP($J,5)="has been processed successfully."
 ;S XMSUB="IFCAP VENDOR DUNS BULLETIN",XMTEXT="^TMP($J,",XMY("G.EDV")="",XMDUZ="SERVER: PRCFVEX" D ^XMD
REM ; -- Remove the Msg from the Server Queue Basket
 S XMSER="S."_XQSOP D REMSBMSG^XMA1C
 Q
