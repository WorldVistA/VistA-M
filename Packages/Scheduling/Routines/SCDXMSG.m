SCDXMSG ;ALB/JRP - AMB CARE TRANSMISSION BUILDER;06-MAY-1996 ; 12/20/01 4:46pm
 ;;5.3;Scheduling;**44,56,70,77,85,96,121,128,66,247,245,387,466**;AUG 13, 1993;Build 2
 ;
SNDZ00 ;Main entry point for the sending of ADT-Z00 batch messages to
 ; the National Patient Care Database
 ;
 ;Input  : None
 ;Output : None
 ;
SD70 ; added w/ patch SD*5.3*70 to reset transmit flags if needed
 N SDEND,SDSTA D EN^SCDXUTL5
 ;
 ;Declare variables
 N X,X1,X2,%H
 N XMITPTR,NOACKBY,XMITDATE,SCDXEVNT,MAXBATCH,MAXLINE,BATCHCNT,MSGNUM
 N LINECNT,MSHLINE,XMITLIST,XMITERR,HL7XMIT,ERROR,IPCNT
 N HLEID,HL,HLECH,HLFS,HLQ,HLMID,HLMTIEN,HLDT,HLDT1,MSGID,HLRESLT,HLP
 ;Set message count limit for batch message
 S MAXBATCH=100
 ;Set line count limit for batch message Note max 160K char. MM Message
 S MAXLINE=$P($G(^SD(404.91,1,"AMB")),U,8) S:'MAXLINE MAXLINE=2000
 ;Initialize global locations
 S XMITERR="^TMP(""SCDX-XMIT-BLD"","_$J_",""ERRORS"")"
 S HL7XMIT="^TMP(""HLS"","_$J_")"
 K @XMITERR,@HL7XMIT
 ;Get lag time for acks from NPCDB (default to T-LAG)
 S NOACKBY=+$P($G(^SD(404.91,1,"AMB")),"^",4)
 S:('NOACKBY) NOACKBY=2
 ;Determine T-LAG @ 11:59:59 PM
 S X1=$$DT^XLFDT()
 S X2=0-NOACKBY
 S NOACKBY=$$FMADD^XLFDT(X1,X2)_".235959"
 ;Flag transmissions that haven't been acked by T-LAG for retransmission
 S XMITDATE=""
 F  S XMITDATE=+$O(^SD(409.73,"AACNOACK",XMITDATE)) Q:(('XMITDATE)!(XMITDATE>NOACKBY))  D
 .S XMITPTR=""
 .F  S XMITPTR=+$O(^SD(409.73,"AACNOACK",XMITDATE,XMITPTR)) Q:('XMITPTR)  D
 ..;Mark entry with retransmit event (POSTMASTER is causer of event)
 ..D STREEVNT^SCDXFU01(XMITPTR,0,"",.5)
 ..;Can no longer receive database credit - delete x-ref and quit
 ..I +$$XMIT4DBC^SCDXFU04(XMITPTR)>3 K ^SD(409.73,"AACNOACK",XMITDATE,XMITPTR) Q  ;SD*5.3*247
 ..;Turn transmission flag on
 ..D XMITFLAG^SCDXFU01(XMITPTR)
 ;Get pointer to sending event
 S HLEID=+$O(^ORD(101,"B","SCDX AMBCARE SEND SERVER FOR ADT-Z00",0))
 ;Sending event not found - send error bulletin - done
 I ('HLEID) D ERRBULL^SCDXMSG2("Unable to initialize HL7 variables - protocol not found") Q
 ;Initialze HL7 variables
 D INIT^HLFNC2(HLEID,.HL)
 ;Unable to initialize HL7 variables - send error bulletin - done
 I ($O(HL(""))="") D ERRBULL^SCDXMSG2($P(HL,"^",2)) Q
 ;Create batch message
 D CREATE^HLTF(.HLMID,.HLMTIEN,.HLDT,.HLDT1)
 ;Unable to create batch message - send error bulletin - done
 I ('HLMTIEN) D ERRBULL^SCDXMSG2("Unable to create batch HL7 message") Q
 ;Initialize message count
 S BATCHCNT=0,IPCNT=0
 ;Initialize message number
 S MSGNUM=1
 ;Initialize line count
 S LINECNT=1
 N VALER,VALERR
 ;this global contains the validation errors if any.
 S VALER="^TMP(""SCDXVALID"",$J)"
 ;Loop through list of [deleted] encounters requiring transmission
 S SCDXEVNT=""
 F  S SCDXEVNT=+$O(^SD(409.73,"AACXMIT",SCDXEVNT)) Q:('SCDXEVNT)  D
 .S XMITPTR=""
 .F  S XMITPTR=+$O(^SD(409.73,"AACXMIT",SCDXEVNT,XMITPTR)) Q:('XMITPTR)  D
 ..N OENODE,PARENT,FILERR
 ..S VALERR="^TMP(""SCDXVALID"",$J,"_XMITPTR_")"
 ..;Bad entry in cross reference - delete cross reference and quit
 ..I ('$D(^SD(409.73,XMITPTR))) K ^SD(409.73,"AACXMIT",SCDXEVNT,XMITPTR) Q
 ..;Make sure entry points to an existing encounter - delete entry
 ..; and quit if it doesn't
 ..S X=^SD(409.73,XMITPTR,0)
 ..S X1=+$P(X,"^",2)
 ..S X2=+$P(X,"^",3)
 ..S OENODE=$S($G(^SCE(+X1,0)):^(0),1:$G(^SD(409.74,+X2,1))),PARENT=$P(OENODE,"^",6)
 ..I (((X1)&('$D(^SCE(X1))))!((X2)&('$D(^SD(409.74,X2))))) S ERROR=$$DELXMIT^SCDXFU03(XMITPTR) Q
 ..; if SD*5.3*70 cleanup not complete, recheck date of encounter for range
 ..I $G(SDEND) Q:$$CHKD(X1,X2)
 ..;If inpatient appointment, delete entry and quit
 ..;Commented to allow transmission of inpatient to NPCD; SD*5.3*387
 ..;I ($$INPATENC^SCDXUTL(XMITPTR)) S ERROR=$$DELXMIT^SCDXFU03(XMITPTR) Q
 ..;If test patient, delete entry and quit
 ..I $$TESTPAT^VADPT($P($$EZN4XMIT^SCDXFU11(XMITPTR),"^",2)) S ERROR=$$DELXMIT^SCDXFU03(XMITPTR) Q
 ..;If child encounter, delete entry, flag parent for xmit, and quit
 ..I PARENT D  Q
 ...S ERROR=$$DELXMIT^SCDXFU03(XMITPTR)
 ..;NPCD will not accept for database credit - clean up and quit
 ..I +$$XMIT4DBC^SCDXFU04(XMITPTR)>3 D  Q  ;SD*5.3*247
 ...;Past database close-out date - delete previously reported errors
 ...D DELAERR^SCDXFU02(XMITPTR)
 ...;Turn off transmission flag
 ...D XMITFLAG^SCDXFU01(XMITPTR,1)
 ..;Calculate message control ID
 ..S MSGID=HLMID_"-"_MSGNUM
 ..;Put [deleted] encounter into transmission
 ..S ERROR=$$BUILDHL7^SCDXMSG0(XMITPTR,.HL,MSGID,HL7XMIT,LINECNT,VALERR)
 ..;[Deleted] encounter not added to transmission
 ..I ERROR<0,$O(@VALERR@(0))']"" D VALIDATE^SCMSVUT0("INTERNAL","","V900",VALERR,0)
 ..D DELAERR^SCDXFU02(XMITPTR,0)
 ..I $O(@VALERR@(0))]"" S FILERR=$$FILEVERR^SCMSVUT2(XMITPTR,VALERR)
 ..I ERROR<0 Q
 ..;Increment line count
 ..S LINECNT=LINECNT+ERROR
 ..;Increment message count
 ..S BATCHCNT=BATCHCNT+1
 ..;Increment message number
 ..S MSGNUM=MSGNUM+1
 ..;Increment inpatient count
 ..I $$INPATENC^SCDXUTL(XMITPTR) S IPCNT=IPCNT+1
 ..;Create entry in ACRP Transmission History file (#409.77)
 ..S X=$$CRTHIST^SCDXFU10(XMITPTR,HLDT,MSGID,HLMID)
 ..;Update transmission info for [deleted] encounter
 ..D XMITDATA^SCDXFU03(XMITPTR,HLDT,MSGID,HLMID)
 ..;Turn off transmission flag for [deleted] encounter
 ..D XMITFLAG^SCDXFU01(XMITPTR,1)
 ..;Delete all errors previously reported for [deleted] encounter
 ..D DELAERR^SCDXFU02(XMITPTR)
 ..;Reached max size for batch
 ..I ((MSGNUM>MAXBATCH)!(LINECNT>MAXLINE)) D
 ...;Send batch message - immediate priority
 ...S HLP("PRIORITY")="I"
 ...D GENERATE^HLMA(HLEID,"GB",1,.HLRESLT,HLMTIEN,.HLP)
 ...;Re-initialize HL7 message
 ...K @HL7XMIT
 ...;Re-initialize HL7 variables
 ...K HL,HLRESLT,HLP,HLMID,HLMTIEN,HLDT,HLDT1
 ...S HLEID=+$O(^ORD(101,"B","SCDX AMBCARE SEND SERVER FOR ADT-Z00",0))
 ...D INIT^HLFNC2(HLEID,.HL)
 ...;Create new batch message
 ...D CREATE^HLTF(.HLMID,.HLMTIEN,.HLDT,.HLDT1)
 ...;Re-initialize line count
 ...S LINECNT=1
 ...;Re-initialize message number
 ...S MSGNUM=1
 ;Check for unsent batch message
 I ($O(@HL7XMIT@(0))) D
 .;Send batch message - immediate priority
 .S HLP("PRIORITY")="I"
 .D GENERATE^HLMA(HLEID,"GB",1,.HLRESLT,HLMTIEN,.HLP)
 N ERRCNT,IPERR
 S ERRCNT=$$COUNT^SCMSVUT2(VALER)
 S IPERR=$$IPERR^SCMSVUT2(VALER)
 ;Send completion bulletin
 D CMPLBULL^SCDXMSG2(BATCHCNT,ERRCNT,IPCNT,IPERR)
 ;Clean up global arrays used
 K @XMITERR,@HL7XMIT,@VALER
 ;Determine if updating of Hospital Location file hasn't completed AND
 ; if today is past the OPC to HL7 cut over date
 I ('$P($G(^SD(404.91,1,"AMB")),"^",7)) I ($$DATE^SCDXUTL(DT)) D
 .;Task updating of Hospital Location file
 .N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 .S ZTRTN="HOPUP^SCMSP"
 .S ZTDESC="REQUIRE PROVIDER AND DIAGNOSIS FOR CHECKOUT FROM CLINICS"
 .S ZTDTH="NOW"
 .S ZTIO=""
 .D ^%ZTLOAD
 ;Done
 Q
 ;
CHKD(X1,X2) ; if clean-up still in progress for SD*5.3*70, check date
 N SDELE
 I X1,+$G(^SCE(X1,0))>SDEND Q 1
 I X2 S SDELE=+$G(^SD(409.74,X2,1)) I SDELE>SDSTA D:SDELE<SDEND  Q 1
 . D KILL^SCDXUTL5("^SD(409.74,",X2)
 . D KILL^SCDXUTL5("^SD(409.73,",XMITPTR)
 Q 0
