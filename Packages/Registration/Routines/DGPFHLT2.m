DGPFHLT2 ;SHRPE/YMG - PRF HL7 QBP/RSP PROCESSING ; 05/02/18
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This is the main driver for sending RSP^K11 (response to PRF flag transfer request) messages.
 ;
 Q
 ;
SEND(DGMERR,DATA) ; entry point
 ; DATA - Array of values to file (see tag EN^DGPFHLT1)
 ; DGMERR - error message to include in MSA segment
 ;
 N DGERR,DGFDA,DGHLRSLT,ERTXT,IENS,SEGCNT
 N HL,HLCMP,HLECH,HLFS,HLL,HLREP,HLSCMP
 K ^TMP("HLS",$J)
 ; get logical link
 S HLL("LINKS",1)="DGPF PRF RSP/K11 SUBSC"_U_$$GETLINK^DGPFHLUT(DATA("SENDTO"))
 ; Initialize the HL7
 D INIT^HLFNC2("DGPF PRF RSP/K11 EVENT",.HL)
 S HLFS=HL("FS"),HLECH=HL("ECH"),HLCMP=$E(HLECH),HLREP=$E(HL("ECH"),2),HLSCMP=$E(HL("ECH"),4)
 ; Create HL7 message
 S SEGCNT=0
 S SEGCNT=$$SAVESEG^DGPFHLT(SEGCNT,$$QAK()) ; QAK segment
 S SEGCNT=$$SAVESEG^DGPFHLT(SEGCNT,$$QPD()) ; QPD segment
 S SEGCNT=$$SAVESEG^DGPFHLT(SEGCNT,$$NTE()) ; NTE segment
 ; Send HL7 message
 D GENERATE^HLMA("DGPF PRF RSP/K11 EVENT","GM",1,.DGHLRSLT)
 I $P(DGHLRSLT,U,2)'="" D
 .; There was an error while sending RSP^K11 message
 .; Update log entry in file 26.22 accordingly
 .S IENS=$O(^DGPF(26.22,"B",$G(DATA("REQDTM")),""))_","
 .S DGFDA(26.22,IENS,.05)=5
 .S DGFDA(26.22,IENS,1)=$E($P(DGHLRSLT,U,3),1,80)
 .D FILE^DIE(,"DGFDA","DGERR")
 .; Send Mailman notification
 .S ERTXT(1)="Error while sending RSP^K11 HL7 message in response to QBP^Q11 HL7"
 .S ERTXT(2)="message with message Id "_$G(DATA("MSGID"))_"."
 .S ERTXT(3)="Error code: "_$P(DGHLRSLT,U,2)
 .S ERTXT(4)="Error description: "_$P(DGHLRSLT,U,3)
 .I $D(DGERR) D
 ..S ERTXT(5)=""
 ..S ERTXT(6)="Error while updating log entry in file 26.22."
 ..S ERTXT(7)="Error code: "_$G(DGERR("DIERR",1))
 ..S ERTXT(8)="Error description: "_$G(DGERR("DIERR",1,"TEXT",1))
 ..Q
 .D TERRMSG^DGPFHLTM($P(DGHLRSLT,U),.ERTXT)
 .Q
 ; update "NO RESPONSE" entries with new review date/time
 D NORESPDT^DGPFHLT3($G(DATA("DFN")),$G(DATA("FLAG")),$G(DATA("REVDTM")))
 K ^TMP("HLS",$J)
 Q
 ;
QAK() ; create QAK segment
 N SEG
 S $P(SEG,HLFS)=$G(DATA("REQID"))                                   ; field 1
 S $P(SEG,HLFS,2)=$S($G(DATA("QOK"))=1:"OK",1:"AR")                 ; field 2
 S $P(SEG,HLFS,3)="PRFREQ01"_HLCMP_"PRF Ownership Transfer Request" ; field 3
 S SEG="QAK"_HLFS_SEG
 Q SEG
 ;
QPD() ; create QPD segment
 N IENS,SEG
 S $P(SEG,HLFS)="PRFREQ01"_HLCMP_"PRF Ownership Transfer Request"   ; field 1
 S $P(SEG,HLFS,2)=$G(DATA("REQID"))                                 ; field 2
 S $P(SEG,HLFS,3)=$G(DATA("ICN"))                                   ; field 3
 S IENS=$G(DATA("FLAG"))_","
 S $P(SEG,HLFS,4)=$$ENCHL7^DGPFHLUT($$GET1^DIQ(26.15,IENS,.01))     ; field 4
 S $P(SEG,HLFS,5)=$$ENCHL7^DGPFHLUT($G(DATA("REVBY")))              ; field 5
 S $P(SEG,HLFS,6)=$$HLDATE^HLFNC($G(DATA("REVDTM")))                ; field 6
 S SEG="QPD"_HLFS_SEG
 Q SEG
 ;
NTE() ; create NTE segment
 N NAME,SEG,Z
 S $P(SEG,HLFS)="1"                                 ; field 1
 S Z=$G(DATA("REVRES"))_HLREP_$$ENCHL7^DGPFHLUT($G(DATA("REVCMT")))
 S $P(SEG,HLFS,3)=Z                                 ; field 3
 S $P(SEG,HLFS,4)="RE"                              ; field 4
 S Z="",$P(Z,HLCMP,14)=HLSCMP_$G(DATA("ORIGOWN"))
 S $P(SEG,HLFS,5)=Z                                 ; field 5
 S SEG="NTE"_HLFS_SEG
 Q SEG
