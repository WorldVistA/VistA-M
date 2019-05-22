DGPFHLT4 ;SHRPE/YMG - PRF HL7 QBP/RSP PROCESSING ; 05/02/18
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This is the main driver for sending ACK (general acknowledgement) messages.
 ;
 Q
 ;
SEND(MSGID,DGMERR) ; entry point
 ; MSGID - HL7 message id to send ACK for
 ; DGMERR - error message to include in MSA segment
 ;
 N DGHLRSLT,SEGCNT
 K ^TMP("HLA",$J)
 ; Create HL7 message
 S SEGCNT=0
 S SEGCNT=$$SAVESEG(SEGCNT,$$MSA()) ; MSA segment
 ; Send HL7 message
 D GENACK^HLMA1(HL("EID"),$G(HLMTIENS),HL("EIDS"),"GM",1,.DGHLRSLT)
 K ^TMP("HLA",$J)
 Q
 ;
MSA() ; create MSA segment
 N SEG
 S $P(SEG,HLFS)=$S($G(DGMERR)="":"AA",1:"AE")                ; field 1
 S $P(SEG,HLFS,2)=$G(MSGID)                                  ; field 2
 I $G(DGMERR)'="" S $P(SEG,HLFS,3)=$$ENCHL7^DGPFHLUT(DGMERR) ; field 3
 S SEG="MSA"_HLFS_SEG
 Q SEG
 ;
SAVESEG(SEGCNT,SEG) ; save created segment in ^TMP global
 ; SEGCNT - current segment count
 ; SEG - segment to save
 ;
 S SEGCNT=SEGCNT+1
 S ^TMP("HLA",$J,SEGCNT)=SEG
 Q SEGCNT
