DGPFHLQ4 ;ALB/RPM - PRF HL7 ORF PROCESSING ; 12/13/04
 ;;5.3;Registration;**425,650,951**;Aug 13, 1993;Build 135
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PARSORF(DGWRK,DGHL,DGROOT,DGMSG) ;Parse ORF~R04 Message/Segments
 ;
 ;  Input:
 ;     DGWRK - Closed root work global reference
 ;      DGHL - HL7 environment array
 ;    DGROOT - Closed root ORF results array
 ;
 ;  Output:
 ;    DGROOT - array of ORF results
 ;             OBRsetID,assigndt,"ACTION"
 ;             OBRsetID,assigndt,"COMMENT",line#
 ;             OBRsetID,"FLAG"
 ;             OBRsetID,"NARR",line#
 ;             OBRsetID,"OWNER"
 ;             "ACKCODE" - acknowledgment code ("AA","AE","AR")
 ;             "ICN"     - patient's Integrated Control Number
 ;             "MSGDTM"  - message creation date/time in FileMan format
 ;             "MSGID"   -
 ;             "QID"     - query ID (DFN)
 ;             "RCVFAC"  - receiving facility
 ;             "SNDFAC"  - sending facility
 ;
 ;     DGMSG - undefined on success, array of MailMan text on failure
 ;
 N DGFS      ;field separator
 N DGCS      ;component separator
 N DGRS      ;repetition separator
 N DGSS      ;sub-component separator
 N DGCURLIN  ;current line
 ;
 S DGFS=DGHL("FS")
 S DGCS=$E(DGHL("ECH"),1)
 S DGRS=$E(DGHL("ECH"),2)
 S DGSS=$E(DGHL("ECH"),4)
 S HLECH=DGHL("ECH"),HLFS=DGHL("FS")
 S DGCURLIN=0
 ;
 ;loop through the message segments and retrieve the field data
 F  D  Q:'DGCURLIN
 . N DGSEG
 . S DGCURLIN=$$NXTSEG^DGPFHLUT(DGWRK,DGCURLIN,DGFS,.DGSEG)
 . Q:'DGCURLIN
 . D @(DGSEG("TYPE")_"(.DGSEG,DGCS,DGRS,DGSS,DGROOT,.DGMSG)")
 Q
 ;
MSH(DGSEG,DGCS,DGRS,DGSS,DGORF,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGORF - array of ORF results
 ;            "SNDFAC" - sending facility
 ;            "RCVFAC" - receiving facility
 ;            "MSGDTM" - message creation date/time in FileMan format
 ;    DGERR - undefined on success, error array on failure
 ;
 N DGARR
 D MSH^DGPFHLU4(.DGSEG,DGCS,DGRS,DGSS,.DGARR,.DGERR)
 I $D(DGARR) M @DGORF=DGARR
 Q
 ;
MSA(DGSEG,DGCS,DGRS,DGSS,DGORF,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGORF - array of ORF results
 ;            "ACKCODE" - Acknowledgment code
 ;            "MSGID" - Message Control ID of the message being ACK'ed
 ;    DGERR - undefined on success, error array on failure
 ;
 N DGARR
 D MSA^DGPFHLU4(.DGSEG,DGCS,DGRS,DGSS,.DGARR,.DGERR)
 I $D(DGARR) M @DGORF=DGARR
 Q
 ;
ERR(DGSEG,DGCS,DGRS,DGSS,DGORF,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGORF - array of ORF results
 ;    DGERR - undefined on success, error array on failure
 ;
 N DGARR
 D ERR^DGPFHLU4(.DGSEG,DGCS,DGRS,DGSS,.DGARR,.DGERR)
 I $D(DGARR) M @DGORF=DGARR
 Q
 ;
QRD(DGSEG,DGCS,DGRS,DGSS,DGQRY,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGQRY("ICN") - Patient's Integrated Control Number
 ;    DGQRY("QID") - Query ID
 ;           DGERR - undefined on success, error array on failure
 ;                      format: DGERR(seg_id,sequence,fld_pos)=error code
 ;
 S @DGQRY@("QID")=$G(DGSEG(4))
 S @DGQRY@("ICN")=+$P($G(DGSEG(8)),DGCS,1)
 Q
 ;
OBR(DGSEG,DGCS,DGRS,DGSS,DGORF,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - OBR segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;     DGORF(setid,"FLAG") - FLAG NAME  (.02) field, file #26.13
 ;    DGORF(setid,"OWNER") - OWNER SITE (.04) field, file #26.13
 ; DGORF(setid,"ORIGSITE") - ORIGINATING SITE (.05) field, file #26.13
 ;          DGORF("SETID") - OBR segment Set ID
 ;                   DGERR - undefined on success, error array on failure
 ;                    format: DGERR(seg_id,sequence,fld_pos)=error code
 N DGSETID  ;OBR segment Set ID
 N PRFFLG   ; ien of received PRF flag in file 26.15
 ;
 S (@DGORF@("SETID"),DGSETID)=+$G(DGSEG(1))
 I DGSETID>0 D
 .S PRFFLG=+$$FIND1^DIC(26.15,,"X",$$DECHL7^DGPFHLUT($P($G(DGSEG(4)),DGCS,2)))
 .I 'PRFFLG S DGSTAT="RJ",DGERR($O(DGERR(""),-1)+1)=261120 Q  ; bail out with "Unable to file" error
 .S @DGORF@(DGSETID,"FLAG")=PRFFLG_";DGPF(26.15,"
 .S @DGORF@(DGSETID,"OWNER")=$$IEN^XUAF4($G(DGSEG(20)))
 .S @DGORF@(DGSETID,"ORIGSITE")=$$IEN^XUAF4($G(DGSEG(21)))
 .Q
 Q
 ;
OBX(DGSEG,DGCS,DGRS,DGSS,DGORF,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - OBX segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;             DGORF(setid,"NARR",line) - ASSIGNMENT NARRATIVE (1) field,
 ;                                        file #26.13
 ;       DGORF(setid,assigndt,"ACTION") - ACTION             (.03) field,
 ;                                        file #26.14
 ; DGORF(setid,assigndt,"COMMENT",line) - HISTORY COMMENTS     (1) field,
 ;                                        file #26.14
 ;              DGERR - undefined on success, error array on failure
 ;                      format: DGERR(seg_id,sequence,fld_pos)=error code
 ;
 N DGADT     ;assignment date
 N DGI
 N DGLINE    ;text line counter
 N DGRSLT
 N DGSETID   ;OBR segment Set ID
 N DGRSLT,DBRSACT,DBRSDT,DBRSNUM,DBRSOTH,DBRSSITE
 ;
 S DGSETID=+$G(@DGORF@("SETID"))
 Q:(DGSETID'>0)
 ; Narrative Observation Identifier
 I $P(DGSEG(3),DGCS,1)="N" D
 .S DGLINE=$O(@DGORF@(DGSETID,"NARR",""),-1)
 .F DGI=1:1:$L(DGSEG(5),DGRS) S @DGORF@(DGSETID,"NARR",DGLINE+DGI,0)=$$DECHL7^DGPFHLUT($P(DGSEG(5),DGRS,DGI))
 .Q
 ; Status Observation Identifier
 I $P(DGSEG(3),DGCS,1)="S" D
 .S DGADT=$$HL7TFM^XLFDT(DGSEG(14),"L")
 .Q:(+DGADT'>0)
 .D CHK^DIE(26.14,.03,,$$DECHL7^DGPFHLUT(DGSEG(5)),.DGRSLT) S @DGORF@(DGSETID,DGADT,"ACTION")=+DGRSLT
 .Q
 ; Comment Observation Identifier
 I $P(DGSEG(3),DGCS,1)="C" D
 .S DGADT=$$HL7TFM^XLFDT(DGSEG(14),"L")
 .Q:(+DGADT'>0)
 .S DGLINE=$O(@DGORF@(DGSETID,DGADT,"COMMENT",""),-1)
 .F DGI=1:1:$L(DGSEG(5),DGRS) D
 ..S @DGORF@(DGSETID,DGADT,"COMMENT",DGLINE+DGI,0)=$$DECHL7^DGPFHLUT($P(DGSEG(5),DGRS,DGI))
 ..Q
 .S @DGORF@(DGSETID,DGADT,"ORIGFAC")=$$IEN^XUAF4($P($G(DGSEG(23)),DGCS,3))
 .Q
 ; DBRS Observation Identifier
 I $P(DGSEG(3),DGCS,1)="D" D
 .S DBRSACT=$S($P(DGSEG(3),DGCS,2)="DBRS-Delete":"D",1:"U")      ; "U" = add/update, "D" = delete
 .S DBRSNUM=$$DECHL7^DGPFHLUT($P(DGSEG(5),DGRS,1)) Q:DBRSNUM=""  ; DBRS #
 .S DBRSOTH=$$DECHL7^DGPFHLUT($P(DGSEG(5),DGRS,2))               ; DBRS OTHER
 .S DBRSDT=+$$HL7TFM^XLFDT(DGSEG(14),"L")                        ; DBRS date
 .S DBRSSITE=$$IEN^XUAF4($P($G(DGSEG(23)),DGCS,3))              ; DBRS creating site
 .S @DGORF@(DGSETID,"DBRS",DBRSNUM,"ACTION")=DBRSACT
 .S @DGORF@(DGSETID,"DBRS",DBRSNUM,"OTHER")=DBRSOTH
 .S @DGORF@(DGSETID,"DBRS",DBRSNUM,"DATE")=DBRSDT
 .S @DGORF@(DGSETID,"DBRS",DBRSNUM,"SITE")=$S(DBRSSITE>0:DBRSSITE,1:"")
 .Q
 Q
