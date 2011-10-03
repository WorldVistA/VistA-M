VAQFIL16 ;ALB/JRP - MESSAGE FILING;14-MAY-93
 ;;1.5;PATIENT DATA EXCHANGE;**4,16,20**;NOV 17, 1993
SEGMENT(MESSNUM,PARSARR,TRANPTR) ;FILE SEGMENT BLOCK
 ;INPUT  : MESSNUM - Message number in transmission (not XMZ)
 ;                   (defaults to 1)
 ;         PARSARR - Parsing array (full global reference)
 ;         TRANPTR - Pointer to VAQ - TRANSACTION file
 ;         (As defined by MailMan)
 ;         XMFROM, XMREC,XMZ
 ;OUTPUT : 0 - Success
 ;         -1^Error_Text - Error
 ;NOTES  : It is the responsibility of the calling program to correct
 ;         the transaction being updated if an error occurs.
 ;
 N VAQCSEG
 ;CHECK INPUT
 S:($G(MESSNUM)="") MESSNUM=1
 Q:($G(PARSARR)="") "-1^Did not pass reference to parsing array"
 Q:('$D(@PARSARR@(MESSNUM))) "-1^Did not pass valid message number"
 Q:('$D(@PARSARR@(MESSNUM,"PATIENT",1))) "-1^Message did not contain a patient block"
 S TRANPTR=+$G(TRANPTR)
 Q:(('TRANPTR)!('$D(^VAT(394.61,TRANPTR)))) "-1^Did not pass a valid transaction"
 ;DECLARE VARIABLES
 N TMP,ERR,SEGMENT,OFFSET,TMPARR,TIMLIM,OCCLIM
 S TMPARR="^TMP(""VAQ-TMP"","_$J_")"
 K @TMPARR
 ;MAKE SURE IT'S A SEGMENT BLOCK
 S TMP=$G(@PARSARR@(MESSNUM,"SEGMENT",1,1))
 S:(TMP=" ") TMP=""
 Q:((TMP="")!(TMP'="$SEGMENT")) "-1^Not a segment block"
 ;DETERMINE SEGMENTS ALREADY IN TRANSACTION
 S TMP=""
 F  S TMP=$O(^VAT(394.61,TRANPTR,"SEG","B",TMP)) Q:(TMP="")  D
 .S SEGMENT=$P($G(^VAT(394.71,TMP,0)),"^",1)
 ;FILE SEGMENTS
 S OFFSET=1
 S TMP=""
 F  S OFFSET=$O(@PARSARR@(MESSNUM,"SEGMENT",1,OFFSET)) Q:(OFFSET="")  D  Q:((TMP="$$SEGMENT")!(OFFSET=""))
 .S TMP=$G(@PARSARR@(MESSNUM,"SEGMENT",1,OFFSET))
 .Q:(TMP="$$SEGMENT")
 .S:(TMP=" ") TMP=""
 .Q:(TMP="")
 .;CONVERT ABBREVIATION TO POINTER
 .S SEGMENT=+$O(^VAT(394.71,"C",TMP,""))
 .Q:('SEGMENT)
 .Q:($P($G(^VAT(394.71,SEGMENT,0)),"^",1)="")
 .S VAQCSEG=SEGMENT,SEGMENT="`"_SEGMENT
 .;S VAQCSEG=$P(^VAT(394.71,SEGMENT,0),"^"),SEGMENT="`"_SEGMENT
 .;GET TIME LIMIT
 .S OFFSET=$O(@PARSARR@(MESSNUM,"SEGMENT",1,OFFSET)) Q:(OFFSET="")
 .S TMP=$G(@PARSARR@(MESSNUM,"SEGMENT",1,OFFSET))
 .Q:(TMP="$$SEGMENT")
 .S:(TMP=" ") TMP=""
 .;LIMITS NOT PASSED (BACK UP A LINE)
 .I (TMP'="") I (+$O(^VAT(394.71,"C",TMP,""))) S OFFSET=OFFSET-1 Q
 .S TIMLIM=TMP
 .;GET OCCURRENCE LIMIT (NEXT LINE IN MESSAGE)
 .S OFFSET=$O(@PARSARR@(MESSNUM,"SEGMENT",1,OFFSET)) Q:(OFFSET="")
 .S TMP=$G(@PARSARR@(MESSNUM,"SEGMENT",1,OFFSET))
 .Q:(TMP="$$SEGMENT")
 .S:(TMP=" ") TMP=""
 .S OCCLIM=TMP
 .;FILE NAME, TIME AND OCCURRENCE LIMITS
 .S ERR=$$FILESEG^VAQFILE2(394.61,TRANPTR,80,VAQCSEG,TIMLIM,OCCLIM)
 I (TMP'="$$SEGMENT") K @TMPARR Q "-1^Not a valid segment block"
 ;DON'T DELETE SEGMENTS
 K @TMPARR Q 0
