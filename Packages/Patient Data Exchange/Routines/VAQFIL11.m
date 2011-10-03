VAQFIL11 ;ALB/JRP - MESSAGE FILING;12-MAY-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
HEADER ;CONTINUATION FOR VAQFIL10
 ; DECLARATIONS DONE IN $$HEADER^VAQFIL10
 ;FILE RECEIVING MESSAGE STATUS
 S ERR=0
 S ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,.02,"VAQ-RCVE")
 I (ERR) S:(NEWTRAN) TMP=$$DELTRAN^VAQFILE(TRANPTR) S ERR="-1^Unable to mark transaction as a transmission that is being received" Q
 ;DONE IF ACK
 Q:(TYPE="ACK")
 ;FILE REMOTE VERSION NUMBER
 S ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,.07,VERSION)
 I (ERR) S:(NEWTRAN) TMP=$$DELTRAN^VAQFILE(TRANPTR) S ERR="-1^Unable to file remote version number ("_VERSION_")" Q
 ;DONE IF RETRANSMIT
 Q:(TYPE="RET")
 ;FILE DATE & TIME OF TRANSMISSION
 S TMP=$S((TYPE="REQ"):20,1:50)
 S ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,TMP,DATETIME)
 I (ERR) S:(NEWTRAN) TMP=$$DELTRAN^VAQFILE(TRANPTR) S ERR="-1^Unable to file date & time ("_DATETIME_")" Q
 ;FILE DATE & TIME UNSOLICITED RECEIVED
 I (STATUS="VAQ-UNSOL") D  Q:(ERR)
 .S ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,20,"NOW")
 .I (ERR) S:(NEWTRAN) TMP=$$DELTRAN^VAQFILE(TRANPTR) S ERR="-1^Unable to file date & time Unsolicited was received"
 ;FILE REMOTE TRANSACTION NUMBER
 S:(TYPE'="RES") ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,.06,TRANSNUM)
 I (ERR) S:(NEWTRAN) TMP=$$DELTRAN^VAQFILE(TRANPTR) S ERR="-1^Unable to file remote transaction number ("_TRANSNUM_")" Q
 ;FILE ENCRYPTION FLAG
 S TMP=$S((ENCMTHD=""):"NO",1:"YES")
 S ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,40,TMP)
 I (ERR) S:(NEWTRAN) TMP=$$DELTRAN^VAQFILE(TRANPTR) S ERR="-1^Unable to file encryption flag ("_$S((ENCMTHD=""):"NO",1:"YES")_")" Q
 ;FILE ENCRYPTION METHOD
 S:(ENCMTHD'="") ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,41,ENCMTHD)
 I (ERR) S:(NEWTRAN) TMP=$$DELTRAN^VAQFILE(TRANPTR) S ERR="-1^Unable to file encryption method ("_ENCMTHD_")" Q
 S ERR=0
 Q
 ;
STATYPE(MESSNUM,PARSARR) ;RETURN STATUS & TYPE FOR A PARSED MESSAGE
 ;INPUT  : MESSNUM - Message number in transmission (not XMZ)
 ;                   (defaults to 1)
 ;         PARSARR - Parsing array (full global reference)
 ;OUTPUT : Status^Type - Success
 ;         -1^Error_Text - Error
 ;
 ;CHECK INPUT
 S:($G(MESSNUM)="") MESSNUM=1
 Q:($G(PARSARR)="") "-1^Did not pass reference to parsing array"
 Q:('$D(@PARSARR@(MESSNUM))) "-1^Did not pass valid message number"
 Q:('$D(@PARSARR@(MESSNUM,"HEADER",1))) "-1^Message did not contain a header block"
 ;DECLARE VARIABLES
 N STATUS,TYPE
 S TYPE=$G(@PARSARR@(MESSNUM,"HEADER",1,2))
 S:(TYPE=" ") TYPE=""
 Q:(TYPE="") "-1^Could not determine message type"
 S STATUS=$G(@PARSARR@(MESSNUM,"HEADER",1,3))
 S:(STATUS=" ") STATUS=""
 Q:(STATUS="") "-1^Could not determine message status"
 Q STATUS_"^"_TYPE
 ;
DECMTHD(MESSNUM,PARSARR,RET) ;RETURN DECRYPTION METHOD FOR A PARSED MESSAGE
 ;INPUT  : MESSNUM - Message number in transmission (not XMZ)
 ;                   (defaults to 1)
 ;         PARSARR - Parsing array (full global reference)
 ;         RET - Flag indicating what to return
 ;           1 = Return pointer to VAQ - ENCRYPTION file (default)
 ;               Return 0 if no encryption listed
 ;           2 = Return decryption method
 ;               Return "" if no encryption listed
 ;           3 = Return type of encryption used
 ;               Return "" if no encryption listed
 ;OUTPUT : See definition of RET
 ;
 ;CHECK INPUT
 S:($G(MESSNUM)="") MESSNUM=1
 Q:($G(PARSARR)="") ""
 Q:('$D(@PARSARR@(MESSNUM))) ""
 Q:('$D(@PARSARR@(MESSNUM,"HEADER",1))) ""
 S RET=+$G(RET)
 S:('RET) RET=1
 ;DECLARE VARIABLES
 N PTR,TYPE
 ;GET TYPE OF ENCRYPTION USED
 S TYPE=$G(@PARSARR@(MESSNUM,"HEADER",1,8))
 S:(TYPE=" ") TYPE=""
 ;NONE LISTED
 Q:(TYPE="") $S((RET=1):0,1:"")
 ;RETURN TYPE
 Q:(RET=3) TYPE
 ;GET POINTER
 S PTR=+$O(^VAT(394.72,"B",TYPE,""))
 Q:(RET=1) PTR
 Q:('PTR) ""
 ;GET METHOD
 Q $G(^VAT(394.72,PTR,"DCR"))
