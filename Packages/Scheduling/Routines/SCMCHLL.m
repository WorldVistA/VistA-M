SCMCHLL ;BP/DJB - PCMM HL7 Log Transmission ; 3/2/00 12:59pm
 ;;5.3;Scheduling;**210,272**;AUG 13, 1993
 ;
LOG ;Record HL7 messages in PCMM HL7 TRANSMISSION LOG file.
 ;Parse the HL7 array and build an array in ^TMP("PCMM","LOG",$J) and
 ;use to record transmissions.
 ;
 NEW FS,MSGID,TDATE
 ;
 ;Initialize variables
 KILL ^TMP("PCMM","LOG",$J)
 S FS=HL("FS") ;........................Field separator
 S MSGID=$P(HLRESLT,"^",1) Q:'MSGID  ;..Message ID
 S TDATE=$$NOW^XLFDT ;..................Transmission date
 S ^TMP("PCMM","LOG",$J,"MSGID")=MSGID
 S ^TMP("PCMM","LOG",$J,"DT")=TDATE
 ;
 D GETDATA ;..Get data from HL7 message array
 D ADD ;......Create entry in Transmission Log and stuff data
 ;
 KILL ^TMP("PCMM","LOG",$J)
 Q
 ;
GETDATA ;Go thru HL7 array and build array of data in ^TMP("PCMM","LOG",$J).
 NEW CNT,DATA,DFN,SEG,SEQ,ZPCID
 S CNT=""
 F  S CNT=$O(^TMP("HLS",$J,CNT)) Q:'CNT  D  ;
 . S DATA=$G(^(CNT)) Q:DATA=""
 . S SEG=$P(DATA,FS,1)
 . ;
 . ;PID segment - Get patient DFN
 . I SEG="PID" D  Q
 . . S DFN=+$P(DATA,U,4)
 . . S ^TMP("PCMM","LOG",$J,"DFN")=DFN
 . ;
 . ;ZPC segment - Get sequence # and ZPC ID.
 . I SEG="ZPC" D  Q
 . . S SEQ=$P(DATA,U,8)
 . . S ZPCID=$P(DATA,U,2)
 . . S ^TMP("PCMM","LOG",$J,"ZPC",SEQ)=ZPCID
 Q
 ;
ADD ;Process data array built in GETDATA
 NEW TRANI
 S TRANI=$$CREATE(^TMP("PCMM","LOG",$J,"MSGID")) ;..Create new entry
 Q:+TRANI<0
 D STORE(TRANI) ;..Store transmission info
 Q
 ;
CREATE(MSGID) ;Create new entry
 ; Input: Message Control ID
 ;Output: Pointer to entry in PCMM HL7 TRANSMISSION LOG (#404.471)
 ;        -1^Error - Unable to create entry
 ;
 NEW SCERR,SCFDA,SCIEN
 S SCFDA(404.471,"+1,",.01)=MSGID
 D UPDATE^DIE("E","SCFDA","SCIEN","SCERR")
 I $D(SCERR) Q "-1^Unable to create entry in file #404.471"
 Q SCIEN(1)
 ;
STORE(TRANI) ;Store data
 ;
 ; Input: TRANI - Pointer PCMM HL7 TRANSMISSION LOG file (#404.471)
 ;Output: None
 ;
 NEW CNT,SCERR,SCIEN,SCIENS,SCIENS1,SCFDA,SEQ,ZPCID
 ;
 ;Check input
 Q:'+$G(TRANI)
 Q:'$D(^SCPT(404.471,TRANI))
 ;
 S SCIENS=TRANI_","
 S SCFDA(404.471,SCIENS,.02)=$G(^TMP("PCMM","LOG",$J,"DFN")) ;Patient
 S SCFDA(404.471,SCIENS,.03)=$G(^TMP("PCMM","LOG",$J,"DT")) ;.Date
 S SCFDA(404.471,SCIENS,.04)="T" ;........................Status
 I $G(WORK),'SCFDA(404.471,SCIENS,.02) D
 .S SCFDA(404.471,SCIENS,.07)=$G(VARPTR)
 .I $G(VARPTR)[404.52 S SCFDA(404.471,SCIENS,.08)=$P($G(^SCTM(404.52,+VARPTR,0)),U,3)
 D FILE^DIE("I","SCFDA","SCERR")
 KILL SCFDA,SCERR
 ;
 ;Fill in ZPC multiple
 S (CNT,SEQ)=0
 F  S SEQ=$O(^TMP("PCMM","LOG",$J,"ZPC",SEQ))  Q:'SEQ  D  ;
 . S ZPCID=$$CONVERT^SCMCHLRI($G(^(SEQ)))
 . S CNT=CNT+1
 . S SCIENS1="+"_CNT_","_SCIENS
 . S SCFDA(404.47141,SCIENS1,.01)=SEQ
 . S SCFDA(404.47141,SCIENS1,.02)=ZPCID
 . D UPDATE^DIE("","SCFDA","SCIEN","SCERR")
 . ;I $D(SCERR) ZW SCERR
 Q
