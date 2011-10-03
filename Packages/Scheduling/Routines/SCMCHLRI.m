SCMCHLRI ;BP/DJB - PCMM HL7 Rejects - Identify & Store Msg ; 2/28/00 12:10pm
 ;;5.3;Scheduling;**210**;AUG 13, 1993
 ;
ACK ;Identify an acknowledgment message
 ;
 ;HL7 Message:
 ;   ACK Code..........: Segment MSA, fld 1
 ;   Msg ID............: Segment MSA, fld 2
 ;   Segment code......: Segment ERR, fld 2, component 1
 ;   Sequence..........: Segment ERR, fld 2, component 2
 ;   Field Position....: Segment ERR, fld 2, component 3
 ;   Error code........: Segment ERR, fld 2, component 4
 ;
 NEW ARRAY,CS,FS,RS
 ;
 S CS=$E(HL("ECH"),1) ;..Component separator
 S RS=$E(HL("ECH"),2) ;..Repetition separator
 S FS=HL("FS") ;.........Field separator
 ;
 D PARSE ;Build array
 Q:'$D(ARRAY)
 D UPDATE ;Update PCMM HL7 TRANSISSION LOG file
 Q
 ;
PARSE ;Parse ACK message.
 ;Build array:
 ;   ARRAY("MSA","MSGID")........= Message ID
 ;   ARRAY("MSA","ACKCODE")......= ACK code
 ;   ARRAY("ERR",counter,"SEG")..= Segment ID
 ;   ARRAY("ERR",counter,"SEQ")..= Sequence #
 ;   ARRAY("ERR",counter,"FLD")..= Field Position
 ;   ARRAY("ERR",counter,"CODE").= Error code
 ;
 NEW CNTERR,MSGID,SEG,TXTFLD,TXTREP
 ;
 F  X HLNEXT Q:(HLQUIT'>0)  D  ;
 . S SEG=$P(HLNODE,FS,1) ;..Segment name
 . ;
 . ;-> MSA segment
 . I SEG="MSA" D  Q
 .. S ARRAY("MSA","ACKCODE")=$P(HLNODE,FS,2)
 .. S ARRAY("MSA","MSGID")=$P(HLNODE,FS,3)
 . ;
 . ;-> ERR segment
 . I SEG="ERR" D  Q
 .. S TXTFLD=$P(HLNODE,FS,2) ;..Repeating field
 .. F CNTERR=1:1 S TXTREP=$P(TXTFLD,RS,CNTERR) Q:TXTREP=""  D  ;
 ... S ARRAY("ERR",CNTERR,"SEG")=$P(TXTREP,CS,1)
 ... ;Get Sequence # and strip off any leading zeros
 ... S SEQ=$P(TXTREP,CS,2)
 ... F  Q:($E(SEQ,1)'=0)  S SEQ=$E(SEQ,2,$L(SEQ))
 ... S ARRAY("ERR",CNTERR,"SEQ")=SEQ
 ... S ARRAY("ERR",CNTERR,"FLD")=$P(TXTREP,CS,3)
 ... S ARRAY("ERR",CNTERR,"CODE")=$P(TXTREP,CS,4)
 Q
 ;
UPDATE ;Update entry in PCMM HL7 TRANSMISSION LOG file
 NEW ACKCODE,ERRORI,MSGID,TRANI
 S MSGID=ARRAY("MSA","MSGID")
 S TRANI=$O(^SCPT(404.471,"B",MSGID,""))
 Q:'$G(TRANI)
 Q:'$D(^SCPT(404.471,TRANI))
 S ACKCODE=ARRAY("MSA","ACKCODE")
 ;
 ;Message processed.
 I ACKCODE="AA" D STATUS(TRANI,"A") Q  ;Msg accepted
 ;
 ;Rejected for reasons unrelated to content.
 I ACKCODE="AR" D STATUS(TRANI,"M") Q  ;Msg marked for re-transmit
 ;
 ;Rejected - error information provided.
 I ACKCODE="AE" D  Q
 . D STATUS(TRANI,"RJ") ;Msg rejected
 . D STORE(TRANI)
 Q
 ;
STATUS(TRANI,STATUS) ;Update STATUS field in PCMM HL7 TRANSMISSION LOG file.
 ; Input: TRANI - IEN of PCM HL7 TRANSMISSION LOG file
 ;       STATUS - A=Accepted, M=Marked for re-transmit, RJ=Rejected
 ;
 NEW SCERR,SCFDA,SCIENS
 Q:'$G(TRANI)
 Q:",A,M,RJ,"'[(","_$G(STATUS)_",")
 S SCIENS=TRANI_","
 S SCFDA(404.471,SCIENS,.04)=STATUS ;.........Status
 S SCFDA(404.471,SCIENS,.05)=$$NOW^XLFDT() ;..ACK received date
 D FILE^DIE("I","SCFDA","SCERR")
 Q
 ;
STORE(TRANI) ;Store data from "ERR" and "ZER" arrays
 ;
 ; Input: TRANI - IEN of PCMM HL7 TRANSMISSION LOG file
 ;Output: None
 ;
 NEW SCERR,SCIEN,SCIENS,SCIENS1,SCFDA
 NEW CNT,ERRORI,FLD,SEG,SEQ,ZPCID
 ;
 S CNT=0
 F  S CNT=$O(ARRAY("ERR",CNT)) Q:'CNT  D  ;
 . ;
 . ;Create entry in ERROR CODE multiple field
 . S ERRORI=$$CREATE(ARRAY("ERR",CNT,"CODE"),CNT,TRANI)
 . Q:+ERRORI<0
 . ;
 . S SEG=$G(ARRAY("ERR",CNT,"SEG")) ;..Segment
 . S SEQ=$G(ARRAY("ERR",CNT,"SEQ")) ;..Sequence number
 . S FLD=$G(ARRAY("ERR",CNT,"FLD")) ;..Field Position
 . S ZPCID=""
 . I SEG="ZPC" D  ;..ZPC ID
 .. Q:'SEQ
 .. S SEQI=$O(^SCPT(404.471,TRANI,"ZPC","B",SEQ,""))
 .. Q:'SEQI
 .. S ZPCID=$P($G(^SCPT(404.471,TRANI,"ZPC",SEQI,0)),"^",2)
 . ;
 . S SCIENS=ERRORI_","_TRANI_","
 . S SCFDA(404.47142,SCIENS,.02)=SEG
 . S SCFDA(404.47142,SCIENS,.03)=SEQ
 . S SCFDA(404.47142,SCIENS,.04)=FLD
 . S SCFDA(404.47142,SCIENS,.05)=ZPCID
 . S SCFDA(404.47142,SCIENS,.06)=1
 . D FILE^DIE("I","SCFDA","SCERR")
 . KILL SCFDA,SCERR
 Q
 ;
CREATE(ERRORCD,CNT,TRANI) ;Create an entry in the ERROR CODE multiiple field
 ; Input: ERRORCD - Error code
 ;        CNT     - Counter for multiple entries
 ;Output: IEN to entry created
 ;        -1^Error - Unable to create entry
 ;
 NEW IENS,SCERR,SCFDA,SCIEN
 S:'$G(CNT) CNT=1
 S IENS="+"_CNT_","_TRANI_","
 S SCFDA(404.47142,IENS,.01)=ERRORCD
 D UPDATE^DIE("E","SCFDA","SCIEN","SCERR")
 I $D(SCERR) Q "-1^Unable to create entry in ERROR CODE field"
 Q SCIEN(CNT)
 ;
CONVERT(ID) ;If ID is from an integrated site, convert it to local ID.
 ;Input: ID="Site#-404.49 IEN"  (Example: 642-3456)
 ;
 I $D(^SCPT(404.49,"C",ID)) D   ;....See if ID is an Integration ID
 . S ID=$O(^SCPT(404.49,"C",ID,"")) ;..If so, convert it to local ID
 E  S ID=$P(ID,"-",2)
 Q ID
 ;
 ;==================================================================
 ;
HL7SAMP ;Sample code to view HL7 message
 NEW I,J
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D  ;
 . S ^TMP("DJB",$J,I)=HLNODE
 . S J=0
 . ;Get segments greater than 245 characters
 . F  S J=$O(HLNODE(J)) Q:'J  S ^TMP("DJB",$J,I,J)=HLNODE(J)
 Q
