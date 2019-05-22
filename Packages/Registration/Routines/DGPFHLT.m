DGPFHLT ;SHRPE/YMG - PRF HL7 QBP/RSP PROCESSING ; 05/02/18
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This is the main driver for sending QBP^Q11 (PRF flag transfer request) messages.
 ;
 Q
 ;
SEND(DFN,FLAG,FCLTY,REASON) ; entry point
 ; DFN - Patient's DFN
 ; FLAG - PRF flag to transfer (ien in file 26.15)
 ; FCLTY - Facility to send the message to (ien in file 4)
 ; REASON - request reason
 ;
 ; Returns status^HL7 message id^error code^error description^error source
 ;  status is the following set of codes:
 ;    0 = failure
 ;    1 = success
 ;  error source is the following set of codes:
 ;    1 = HL7
 ;    2 = Filer (UPDATE^DIE)
 ;
 N HL,HLCMP,HLECH,HLFS,HLL,HLSCMP ; HL7 variables
 N DGDTM,DGFAC,DGFDA,DGERR,DGICN,DGHLLNK,DGHLRSLT,REQBY,REQID,SEGCNT
 ;
 I +$G(DFN)'>0 Q "0^0^^Invalid DFN"
 ; ICN must be national
 I '$$MPIOK^DGPFUT(DFN,.DGICN) Q "0^0^^Invalid ICN"
 ; Retrieve treating facility HL Logical Link
 S DGHLLNK=$$GETLINK^DGPFHLUT(FCLTY)
 I DGHLLNK=0 Q "0^0^^Unable to get HL7 logical link for facility "_$$STA^XUAF4(FCLTY)_". Please contact the National Help Desk to rectify the issue. As a workaround, please utilize the existing 'CO - Change Ownership' functionality."
 ;
 S REQBY=$$GET1^DIQ(200,DUZ_",",.01) ; Requester's name
 S DGDTM=$$NOW^XLFDT()
 S REQID=$$GENQID(DGDTM) ; Next available query ID
 S HLL("LINKS",1)="DGPF PRF QBP/Q11 SUBSC"_U_DGHLLNK
 ; Initialize the HL7
 D INIT^HLFNC2("DGPF PRF QBP/Q11 EVENT",.HL)
 S HLFS=HL("FS"),HLECH=HL("ECH"),HLCMP=$E(HLECH),HLSCMP=$E(HL("ECH"),4)
 K ^TMP("HLS",$J)
 ; Create HL7 message
 S SEGCNT=0
 S SEGCNT=$$SAVESEG(SEGCNT,$$QPD()) ; QPD segment
 S SEGCNT=$$SAVESEG(SEGCNT,$$NTE()) ; NTE segment
 S SEGCNT=$$SAVESEG(SEGCNT,$$RCP()) ; RCP segment
 ; Send HL7 message
 D GENERATE^HLMA("DGPF PRF QBP/Q11 EVENT","GM",1,.DGHLRSLT)
 ; DHLRSLT = message ID^error code^error description
 I $P(DGHLRSLT,U)>0,$P(DGHLRSLT,U,2)="" D
 .; File new entry into log file 26.22
 .S DGFDA(26.22,"+1,",.01)=DGDTM
 .S DGFDA(26.22,"+1,",.02)=REQBY
 .S DGFDA(26.22,"+1,",.03)=DFN
 .S DGFDA(26.22,"+1,",.04)=FLAG
 .S DGFDA(26.22,"+1,",.05)=1
 .S DGFDA(26.22,"+1,",.08)=REQID
 .S DGFDA(26.22,"+1,",.09)=$P(DGHLRSLT,U)
 .S DGFDA(26.22,"+1,",.1)=DUZ(2)
 .S DGFDA(26.22,"+1,",2.01)=REASON
 .D UPDATE^DIE(,"DGFDA",,"DGERR")
 .Q
 K ^TMP("HLS",$J)
 I $D(DGERR) Q "0^0^"_$G(DGERR("DIERR",1))_U_$G(DGERR("DIERR",1,"TEXT",1))_"^2"
 ; change status of previous requests with "SENT" status to "NO RESPONSE"
 D NORESP^DGPFHLT1(DFN,FLAG,1)
 ;
 Q $S($P(DGHLRSLT,U,2)'="":0,1:1)_U_DGHLRSLT_"^1"
 ;
QPD() ; create QPD segment
 N SEG
 S $P(SEG,HLFS)="PRFREQ01"_HLCMP_"PRF Ownership Transfer Request"   ; field 1
 S $P(SEG,HLFS,2)=REQID                                             ; field 2
 S $P(SEG,HLFS,3)=DGICN                                             ; field 3
 S $P(SEG,HLFS,4)=$$ENCHL7^DGPFHLUT($$GET1^DIQ(26.15,FLAG_",",.01)) ; field 4
 S SEG="QPD"_HLFS_SEG
 Q SEG
 ;
NTE() ; create NTE segment
 N NAME,SEG,Z
 S $P(SEG,HLFS)="1"                             ; field 1
 S $P(SEG,HLFS,3)=$$ENCHL7^DGPFHLUT(REASON)     ; field 3
 S $P(SEG,HLFS,4)="RE"                          ; field 4
 S NAME=$$ENCHL7^DGPFHLUT(REQBY)
 S Z=$$HLNAME^HLFNC(NAME,HLECH)
 S $P(Z,HLCMP,14)=HLSCMP_$$STA^XUAF4(DUZ(2))
 S $P(SEG,HLFS,5)=Z                             ; field 5
 S $P(SEG,HLFS,6)=$$HLDATE^HLFNC(DGDTM)         ; field 6
 S SEG="NTE"_HLFS_SEG
 Q SEG
 ;
RCP() ; create RCP segment
 N SEG
 S $P(SEG,HLFS)="D"                             ; field 1
 S $P(SEG,HLFS,2)="1"_HLCMP_"LI"                ; field 2
 S $P(SEG,HLFS,3)="T"                           ; field 3
 S SEG="RCP"_HLFS_SEG
 Q SEG
 ;
SAVESEG(SEGCNT,SEG) ; save created segment in ^TMP global
 ; SEGCNT - current segment count
 ; SEG - segment to save
 ;
 S SEGCNT=SEGCNT+1
 S ^TMP("HLS",$J,SEGCNT)=SEG
 Q SEGCNT
 ;
GENQID(DGDTM) ; generate new query ID
 ;
 ; DGDTM - timestamp to use in ID generation
 ;
 ; returns next available query ID
 ;
 N QID,SEQ,STOP
 S QID=$$STA^XUAF4(DUZ(2))_$TR($G(DGDTM),".","")
 S STOP=0 F SEQ=1:1:99999 S:'$O(^DGPF(26.22,"C",QID_SEQ,"")) STOP=1 Q:STOP
 Q QID_SEQ
