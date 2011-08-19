VAQFIL15 ;ALB/JRP - MESSAGE FILING;12-MAY-93
 ;;1.5;PATIENT DATA EXCHANGE;**6**;NOV 17, 1993
PATIENT(MESSNUM,PARSARR,TRANPTR) ;FILE PATIENT BLOCK
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
 ;CHECK INPUT
 S:($G(MESSNUM)="") MESSNUM=1
 Q:($G(PARSARR)="") "-1^Did not pass reference to parsing array"
 Q:('$D(@PARSARR@(MESSNUM))) "-1^Did not pass valid message number"
 Q:('$D(@PARSARR@(MESSNUM,"PATIENT",1))) "-1^Message did not contain a patient block"
 S TRANPTR=+$G(TRANPTR)
 Q:(('TRANPTR)!('$D(^VAT(394.61,TRANPTR)))) "-1^Did not pass a valid transaction"
 ;DECLARE VARIABLES
 N TMP,ERR,STRING,KEY1,KEY2,DECSTR,NAME,PID,SSN,DOB
 N SENSITVE,ENCRYPT,DECRYPT,TYPE
 ;MAKE SURE IT'S A PATIENT BLOCK
 S TMP=$G(@PARSARR@(MESSNUM,"PATIENT",1,1))
 S:(TMP=" ") TMP=""
 Q:((TMP="")!(TMP'="$PATIENT")) "-1^Not a patient block"
 S TMP=$G(@PARSARR@(MESSNUM,"PATIENT",1,9))
 S:(TMP=" ") TMP=""
 Q:((TMP="")!(TMP'="$$PATIENT")) "-1^Not a valid patient block"
 ;GET MESSAGE TYPE
 S TMP=$$STATYPE^VAQFIL11(MESSNUM,PARSARR)
 Q:($P(TMP,"^",1)="-1") "-1^Could not determine message type"
 S TYPE=$P(TMP,"^",2)
 ;ACK & RETRANSMIT DON'T HAVE PATIENT BLOCK
 Q:((TYPE="ACK")!(TYPE="RET")) "-1^Message type does not require patient block"
 ;GET ENCRYPTION FLAG
 S ENCRYPT=+$G(@PARSARR@(MESSNUM,"PATIENT",1,2))
 ;SET UP DECRYPTION CALL
 S DECRYPT=$$DECMTHD^VAQFIL11(MESSNUM,PARSARR,2)
 Q:((ENCRYPT)&(DECRYPT="")) "-1^Encryption method not contained in header block"
 S:(ENCRYPT) DECRYPT=("S DECSTR="_DECRYPT)
 S:('ENCRYPT) DECRYPT="S DECSTR=STRING"
 ;GET KEYS
 S KEY1=$$KEY^VAQFIL13(MESSNUM,PARSARR,1)
 S KEY2=$$KEY^VAQFIL13(MESSNUM,PARSARR,0)
 Q:((ENCRYPT)&((KEY1="")!(KEY2=""))) "-1^Could not determine decryption keys"
 ;GET NAME
 S STRING=$G(@PARSARR@(MESSNUM,"PATIENT",1,3))
 S:(STRING=" ") STRING=""
 X DECRYPT
 S NAME=DECSTR
 ;GET PID
 S STRING=$G(@PARSARR@(MESSNUM,"PATIENT",1,4))
 S:(STRING=" ") STRING=""
 X DECRYPT
 S PID=DECSTR
 ;GET SSN (REMOVE DASHES)
 S STRING=$G(@PARSARR@(MESSNUM,"PATIENT",1,5))
 S:(STRING=" ") STRING=""
 X DECRYPT
 S SSN=$TR(DECSTR,"-","")
 ;GET DOB
 S STRING=$G(@PARSARR@(MESSNUM,"PATIENT",1,6))
 S:(STRING=" ") STRING=""
 X DECRYPT
 S DOB=DECSTR
 ;CONVERT IMPRECISE DATES TO ACCEPTIBLE FORMAT (IF REQUIRED)
 S DOB=$$IMPDTE^VAQUTL95(DOB)
 S:(DOB="-1") DOB=""
 ;GET SENSITIVITY FLAG
 S STRING=$G(@PARSARR@(MESSNUM,"PATIENT",1,8))
 S:(STRING=" ") STRING=""
 X DECRYPT
 S SENSITVE=$S((+DECSTR):"YES",1:"NO")
 ;MAKE SURE SOME PATIENT IDENTIFICATION WAS PASSED
 Q:((NAME="")&(PID="")&(SSN="")) "Identity of patient not contained in patient block"
 ;ONLY STORE PATIENT DEFINITION WHEN NOT RESULTS
 I (TYPE'="RES") D  Q:(ERR) ERR
 .S ERR=0
 .I $$FILEINFO^VAQFILE(394.61,TRANPTR,10,NAME) S ERR="-1^Could not file patient's name ("_NAME_")" Q
 .I $$FILEINFO^VAQFILE(394.61,TRANPTR,13,PID) S ERR="-1^Could not file patient's PID ("_PID_")" Q
 .I $$FILEINFO^VAQFILE(394.61,TRANPTR,11,SSN) S ERR="-1^Could not file patient's SSN ("_SSN_")" Q
 .I $$FILEINFO^VAQFILE(394.61,TRANPTR,12,DOB) S ERR="-1^Could not file patient's date of birth ("_DOB_")" Q
 .S ERR=0
 ;STORE REMOTE SENSITIVITY
 S ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,.04,SENSITVE)
 Q:(ERR) "-1^Could not file patient's sensitivity ("_SENSITVE_")"
 Q 0
