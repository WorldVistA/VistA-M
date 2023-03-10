PXRMERRH ;SLC/PKR - Error handling routines. ;01/22/2021
 ;;2.0;CLINICAL REMINDERS;**4,17,18,47,45,42**;Feb 04, 2005;Build 245
 ;
 ;=================================================================
DERRHRLR ;PXRM error handler. Send a MailMan message to the mail group defined
 ;by the site and put the error in the error trap.
 ;References to %ZTER covered by DBIA #1621.
 N CNT,ERR,ERROR,INDEX,MGIEN,MGROUP,NL,XMDUZ,XMSUB,XMY,XMZ
 S ERROR=$$EC^%ZOSV
 ;Ignore the "errors" the unwinder creates.
 I ERROR["ZTER" D UNWIND^%ZTER
 ;If it is a framestack error do not try to send the message
 I ERROR["FRAMESTACK" Q
 ;Make sure we don't loop if there is an error during procesing of
 ;the error handler.
 N $ET S $ET="D ^%ZTER,DCLEAN^PXRMERRH,UNWIND^%ZTER"
 ;
 ;Save the error then put it in the error trap, this saves the correct
 ;last global reference.
 D ^%ZTER
 ;
 ;If this is a test run write out the error.
 ;I $G(PXRMDEBG) W !,ERROR
 ;
 K ^TMP("PXRMXMZ",$J)
 S CNT=0
 S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="The following error occurred while saving general findings:"
 S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)=ERROR
 S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="Please contact the help desk for assistance."
 S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)=" "
 S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="See below for the data that was not saved:"
 D ACOPY^PXRMUTIL("DATA","ERR()")
 S INDEX=0 F  S INDEX=$O(ERR(INDEX)) Q:INDEX'>0  S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)=ERR(INDEX)
 ;
 S MGIEN=$G(^PXRM(800,1,"MGFE"))
 ;If the mail group has not been defined tell the user.
 I MGIEN="" D
 . S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)=" "
 . S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="You received this message because your IRM has not set up a mailgroup"
 . S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="to receive Clinical Reminder errors; please notify them."
 ;
 D SEND^PXRMMSG("PXRMXMZ","ERROR SAVING DATA","",DUZ)
 ;
 ;I '$G(PXRMDEBG) D DCLEAN
 S RETURN(0)="-1^A Mumps error occurred while saving data."
 D UNWIND^%ZTER
 Q
 ;
 ;=================================================================
ERRHDLR ;PXRM error handler. Send a MailMan message to the mail group defined
 ;by the site and put the error in the error trap.
 ;References to %ZTER covered by DBIA #1621.
 N ERROR,MGIEN,MGROUP,NL,REMINDER,XMDUZ,XMSUB,XMY,XMZ
 S ERROR=$$EC^%ZOSV
 ;Ignore the "errors" the unwinder creates.
 I ERROR["ZTER" D UNWIND^%ZTER
 ;If it is a framestack error do not try to send the message
 I ERROR["FRAMESTACK" Q
 ;Make sure we don't loop if there is an error during procesing of
 ;the error handler.
 N $ET S $ET="D ^%ZTER,CLEAN^PXRMERRH,UNWIND^%ZTER"
 ;
 ;Save the error then put it in the error trap, this saves the correct
 ;last global reference.
 D ^%ZTER
 ;
 ;If this is a test run write out the error.
 I $G(PXRMDEBG) W !,ERROR
 ;
 K ^TMP("PXRMXMZ",$J)
 S ^TMP("PXRMXMZ",$J,1,0)="The following error occurred:"
 S ^TMP("PXRMXMZ",$J,2,0)=ERROR
 I +$G(PXRMITEM)>0 S REMINDER=$P(^PXD(811.9,PXRMITEM,0),U,1)
 E  S PXRMITEM=999999,REMINDER="?"
 S ^TMP("PXRMXMZ",$J,3,0)="While evaluating reminder "_REMINDER
 S ^TMP("PXRMXMZ",$J,4,0)="For patient DFN="_$G(PXRMPDEM("DFN"))
 S ^TMP("PXRMXMZ",$J,5,0)="The time of the error was "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S ^TMP("PXRMXMZ",$J,6,0)="See the error trap for complete details."
 S NL=6
 ;Look for specific error text to append to the message.
 I $D(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","ERROR TRAP")) D
 . N ESOURCE,IND
 . S ESOURCE=""
 . F  S ESOURCE=$O(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","ERROR TRAP",ESOURCE)) Q:ESOURCE=""  D
 .. S IND=0
 .. F  S IND=$O(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","ERROR TRAP",ESOURCE,IND)) Q:IND=""  D
 ... S NL=NL+1
 ... S ^TMP("PXRMXMZ",$J,NL,0)=^TMP(PXRMPID,$J,PXRMITEM,"FERROR","ERROR TRAP",ESOURCE,IND)
 ;
 S MGIEN=$G(^PXRM(800,1,"MGFE"))
 ;If the mail group has not been defined tell the user.
 I MGIEN="" D
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" "
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="You received this message because your IRM has not set up a mailgroup"
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="to receive Clinical Reminder errors; please notify them."
 ;
 D SEND^PXRMMSG("PXRMXMZ","ERROR EVALUATING CLINICAL REMINDER","",DUZ)
 I ERROR["VCPT",ERROR["PXPXRM" D VCPTINDEXREPAIR(PXRMPDEM("DFN"),ERROR)
 ;
 ;If the reminder exists mark that an error occured.
 I PXRMITEM=999999 Q
 S ^TMP(PXRMPID,$J,PXRMITEM,"FERROR","ERROR TRAP")=""
 N DEFARR,DUE,DUEDATE,FREQ,FIEVAL,PCLOGIC,RESDATE
 S (DUE,DUEDATE,FREQ,FIEVAL,PCLOGIC,RESDATE)=""
 D DEF^PXRMLDR(PXRMITEM,.DEFARR)
 D OUTPUT^PXRMOUTD(5,.DEFARR,PCLOGIC,DUE,DUEDATE,RESDATE,FREQ,.FIEVAL)
 ;
 ;Set the first line of ^TMP("PXRHM") to ERROR.
 S ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM)="ERROR"
 ;
 I '$G(PXRMDEBG) D CLEAN
 D UNWIND^%ZTER
 Q
 ;
 ;=================================================================
CLEAN ;Clean-up scratch arrays
 K ^TMP("PXRM",$J)
 I $D(PXRMPID) K ^TMP(PXRMPID,$J)
 Q
 ;
DCLEAN ;
 Q
 ;
 ;=================================================================
NODEF(IEN) ;Non-existent reminder definition.
 N SUBJ
 K ^TMP("PXRMXMZ",$J)
 S ^TMP("PXRMXMZ",$J,1,0)="A request was made to evaluate a non-existent reminder; the IEN is "_IEN_"."
 S SUBJ="Attempt to evaluate a non-existent reminder"
 D SEND^PXRMMSG("PXRMXMZ",SUBJ,"",DUZ)
 K ^TMP("PXRMXMZ",$J)
 D ^%ZTER
 Q
 ;
 ;=================================================================
NOINDEX(FTYPE,IEN,FILENUM) ;Error handling for missing index.
 N ETEXT,SUBJ
 K ^TMP("PXRMXMZ",$J)
 S ETEXT(1)=""
 S ETEXT(2)="Warning: Index for file number "_FILENUM_" does not exist or is not complete."
 I FTYPE="D" S ETEXT(3)="Reminder "_IEN_" will not be properly evaluated!"
 I FTYPE="TR" S ETEXT(3)="Term "_IEN_" will not be properly evaluated!"
 I FTYPE="TX" S ETEXT(3)="Taxonomy "_IEN_" will not be properly evaluated!"
 I $D(PXRMPID) D
 . S ^TMP(PXRMPID,$J,PXRMITEM,"WARNING","MISSING INDEX")=ETEXT(2)
 . S ^TMP(PXRMPID,$J,PXRMITEM,"INFO","MISSING INDEX")=ETEXT(2)
 ;Mail out the error message.
 S ^TMP("PXRMXMZ",$J,1,0)=ETEXT(2)
 S ^TMP("PXRMXMZ",$J,2,0)=ETEXT(3)
 S ^TMP("PXRMXMZ",$J,3,0)="Patient DFN="_$G(PXRMPDEM("DFN"))_", User DUZ="_DUZ_", Reminder="_$G(PXRMITEM)
 S SUBJ="Problem with index for file number "_FILENUM
 D SEND^PXRMMSG("PXRMXMZ",SUBJ,"",DUZ)
 K ^TMP("PXRMXMZ",$J)
 Q
 ;
 ;=================================================================
VCPTINDEXREPAIR(DFN,ERROR) ;Repair for reminder evaluation errors caused by
 ;V CPT index entries that were not deleted when the V CPT entry was
 ;deleted.
 N CPT,DATE,DONE,PP,SUBJECT,TEMP,VCPTIEN
 K ^TMP("PXRMXMZ",$J)
 ;Get VCPT IEN.
 S TEMP=$P(ERROR,"^AUPNVCPT(",2)
 S VCPTIEN=$P(TEMP,",",1)
 I +VCPTIEN'>0 Q
 ;Check for a spurious error and send a message
 ;if one is found.
 I $D(^AUPNVCPT(VCPTIEN)) D  Q
 . S SUBJECT="V CPT Index Spurious Error"
 . S ^TMP("PXRMXMZ",$J,1,0)="The error:"
 . S ^TMP("PXRMXMZ",$J,2,0)=ERROR
 . S ^TMP("PXRMXMZ",$J,3,0)="appears to be spurious because the V CPT entry exists."
 . S ^TMP("PXRMXMZ",$J,4,0)="Please enter a ticket so this can be examined."
 . D SEND^PXRMMSG("PXRMXMZ",SUBJECT,"",DUZ)
 . K ^TMP("PXRMXMZ",$J)
 ;Delete the Index entries and send a message.
 S DONE=0,PP=""
 F  S PP=$O(^PXRMINDX(9000010.18,"PPI",DFN,PP)) Q:(DONE)!(PP="")  D
 . S CPT=""
 . F  S CPT=$O(^PXRMINDX(9000010.18,"PPI",DFN,PP,CPT)) Q:(DONE)!(CPT="")  D
 .. S DATE=""
 .. F  S DATE=$O(^PXRMINDX(9000010.18,"PPI",DFN,PP,CPT,DATE)) Q:(DONE)!(DATE="")  D
 ... I $D(^PXRMINDX(9000010.18,"PPI",DFN,PP,CPT,DATE,VCPTIEN)) D
 .... K ^PXRMINDX(9000010.18,"PPI",DFN,PP,CPT,DATE,VCPTIEN)
 .... K ^PXRMINDX(9000010.18,"IPP",CPT,PP,DFN,DATE,VCPTIEN)
 .... S DONE=1
 ....;Send the message
 .... S SUBJECT="V CPT Index Repair"
 .... S ^TMP("PXRMXMZ",$J,1,0)="The Clinical Reminder Index entries related to the error:"
 .... S ^TMP("PXRMXMZ",$J,2,0)=ERROR
 .... S ^TMP("PXRMXMZ",$J,3,0)="have been deleted, no further action is required."
 .... S ^TMP("PXRMXMZ",$J,4,0)="DFN="_DFN
 .... S ^TMP("PXRMXMZ",$J,5,0)="PP="_PP
 .... S ^TMP("PXRMXMZ",$J,6,0)="CPT="_CPT
 .... S ^TMP("PXRMXMZ",$J,7,0)="Date="_DATE
 .... S ^TMP("PXRMXMZ",$J,8,0)="V CPT IEN="_VCPTIEN
 .... D SEND^PXRMMSG("PXRMXMZ",SUBJECT,"",DUZ)
 .... K ^TMP("PXRMXMZ",$J)
 Q
