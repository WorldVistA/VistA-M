ORERRH ; SLC/AGP - Error handling routines;10/09/18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**377**;Dec 17, 1997;Build 582
 ;
ACOPY(REF,OUTPUT) ;Copy all the descendants of the array reference into a linear
 ;array. REF is the starting array reference, for example A or
 ;^TMP("OR",$J). OUTPUT is the linear array for the output. It
 ;should be in the form of a closed root, i.e., A() or ^TMP($J,).
 ;Note OUTPUT cannot be used as the name of the output array.
 N DONE,IND,LEN,NL,OROOT,OUT,PROOT,ROOT,START,TEMP
 I REF="" Q
 S NL=0
 S OROOT=$P(OUTPUT,")",1)
 S PROOT=$P(REF,")",1)
 ;Build the root so we can tell when we are done.
 S TEMP=$NA(@REF)
 S ROOT=$P(TEMP,")",1)
 S REF=$Q(@REF)
 I REF'[ROOT Q
 S DONE=0
 F  Q:(REF="")!(DONE)  D
 . S START=$F(REF,ROOT)
 . S LEN=$L(REF)
 . S IND=$E(REF,START,LEN)
 . S NL=NL+1
 . S OUT=OROOT_NL_")"
 . S @OUT=PROOT_IND_"="_@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 Q
 ;
BUILDMSG(TYPE,ERROR) ;
 N CNT,ERR,INDEX
 I TYPE=1 D  Q
 .S CNT=0
 .S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="The following error occurred while saving PCE Data:"
 .S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)=ERROR
 .S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="Please contact the help desk for assistance."
 .S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)=" "
 .S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="See below for the data that was not saved:"
 .S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="NOTEIEN: "_+$G(NOTEIEN)
 .s CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="LOCATION: "_+$G(ORLOC)
 .D ACOPY("PCELIST","ERR()")
 .S INDEX=0 F  S INDEX=$O(ERR(INDEX)) Q:INDEX'>0  S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)=ERR(INDEX)
 Q
 ;
 ;=================================================================
ERRHRLR(TYPE,HEADER) ;PCE Save Data error handler. Send a MailMan message to the OR CACS mail group
 ;by the site and put the error in the error trap.
 ;References to %ZTER covered by DBIA #1621.
 N ERROR,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 S ERROR=$$EC^%ZOSV
 ;Ignore the "errors" the unwinder creates.
 I ERROR["ZTER" D UNWIND^%ZTER
 ;Make sure we don't loop if there is an error during procesing of
 ;the error handler.
 N $ET S $ET="D ^%ZTER,CLEAN^ORERRH,UNWIND^%ZTER"
 ;
 ;Save the error then put it in the error trap, this saves the correct
 ;last global reference.
 D ^%ZTER
 ;
 ;
 S XMDUZ="CPRS, SEARCH",XMSUB=HEADER,XMTEXT="^TMP(""OR MSG"",$J,",XMY(DUZ)="",XMY("G.OR CACS")=""
 K ^TMP("OR MSG",$J)
 D BUILDMSG(TYPE,ERROR)
 ;
 D ^XMD
 ;
 D CLEAN
 S RESULT(0)="-1^"
 S RESULT(1)="A Mumps error occurred while saving data."
 D UNWIND^%ZTER
 Q
 ;
 ;=================================================================
CLEAN ;Clean-up scratch arrays
 K ^TMP("OR MSG")
 Q
 ;
