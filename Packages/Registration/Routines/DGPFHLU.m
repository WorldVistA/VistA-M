DGPFHLU ;ALB/RPM - PRF HL7 ORU/ACK PROCESSING ; 6/21/06 10:27am
 ;;5.3;Registration;**425,718,650,951,1063**;Aug 13, 1993;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
BLDORU(DGPFA,DGHARR,DGHL,DGROOT) ;Build ORU~R01 Message/Segments
 ;
 ;  Input:
 ;      DGPFA - (required) Assignment data array
 ;     DGHARR - (required) Assignment history IENs array
 ;       DGHL - (required) HL7 Kernel array passed by reference
 ;     DGROOT - (required) Closed root segment storage array name
 ;
 ;  Output:
 ;   Function Value - IEN of last assignment history included in
 ;                    message segments, 0 on failure
 ;           DGROOT - array of HL7 segments
 ;
 N DGADT     ;assignment date
 N DGHIEN    ;function value
 N DGLDT     ;last assignment date
 N DGPFAH    ;assignment history data array
 N DGSEG     ;segment counter
 N DGSEGSTR  ;formatted segment string
 N DGSET     ;set id
 N DGTROOT   ;text root
 N LASTH     ;last assignment history entry
 N DBRSSTR,Z
 ;
 S DGHIEN=0
 S DGSEG=0
 ;
 I $D(DGPFA),$D(DGHARR),$G(DGROOT)]"" D
 .; build PID
 .I $D(HL) N HL MERGE HL=DGHL ; Checking if HL array exists and merging with DGHL if it does to prevent discrepancies in the PID segments
 .S DGSEGSTR=$$EN^VAFHLPID(+DGPFA("DFN"),"1,2,3,5,7,8,19",1,1) Q:DGSEGSTR=""
 .S DGSEG=DGSEG+1,@DGROOT@(DGSEG)=DGSEGSTR
 .; build OBR
 .S DGLDT=+$O(DGHARR(""),-1)  ; get last assignment date
 .Q:'$$GETHIST^DGPFAAH(DGHARR(DGLDT),.DGPFAH,1)  ; load asgn hx array
 .M LASTH=DGPFAH
 .S DGSEGSTR=$$OBR^DGPFHLU1(1,.DGPFA,.DGPFAH,"1,4,7,20,21",.DGHL) Q:DGSEGSTR=""
 .S DGSEG=DGSEG+1,@DGROOT@(DGSEG)=DGSEGSTR
 .; start OBX segments
 .S DGSET=0
 .; build narrative OBX segments
 .S DGTROOT="DGPFA(""NARR"")"
 .Q:'$$BLDOBXTX^DGPFHLU2(DGROOT,DGTROOT,"N",.DGPFAH,.DGHL,.DGSEG,.DGSET)
 .; for each history build status & comment OBX segments
 .S DGADT=0 F  S DGADT=$O(DGHARR(DGADT)) Q:'DGADT  D  Q:'DGHIEN
 ..N DGPFAH
 ..S DGHIEN=0
 ..Q:'$$GETHIST^DGPFAAH(DGHARR(DGADT),.DGPFAH)
 ..; build status OBX segment
 ..S DGSET=DGSET+1
 ..S DGSEGSTR=$$OBX^DGPFHLU2(DGSET,"S","",$P($G(DGPFAH("ACTION")),U,2),.DGPFAH,"1,2,3,5,11,14",.DGHL)
 ..Q:DGSEGSTR=""
 ..S DGSEG=DGSEG+1,@DGROOT@(DGSEG)=DGSEGSTR
 ..; build review comment OBX segments
 ..S DGTROOT="DGPFAH(""COMMENT"")"
 ..Q:'$$BLDOBXTX^DGPFHLU2(DGROOT,DGTROOT,"C",.DGPFAH,.DGHL,.DGSEG,.DGSET)
 ..; success
 ..S DGHIEN=DGHARR(DGADT)
 ..Q
 .; build DBRS OBX segments
 .; build only if action is not "INACTIVATE"
 .I +LASTH("ACTION")'=3 S Z="" F  S Z=$O(LASTH("DBRS",Z)) Q:Z=""  D  Q:'DGHIEN
 ..S DBRSSTR=$G(LASTH("DBRS",Z))
 ..; don't send unchanged DBRS entries if action is "DBRS#/OTHER FIELD UPDATE"
 ..I $P($P(DBRSSTR,U,4),";")="N",+LASTH("ACTION")=6 Q
 ..S DGSET=DGSET+1
 ..S DGSEGSTR=$$OBX^DGPFHLU2(DGSET,"D","",DBRSSTR,.LASTH,"1,2,3,5,11,14,23",.DGHL)
 ..I DGSEGSTR="" S DGHIEN=0 Q
 ..S DGSEG=DGSEG+1,@DGROOT@(DGSEG)=DGSEGSTR
 ..Q
 .Q
 ;
 Q DGHIEN
 ;
PARSORU(DGWRK,DGHL,DGROOT,DGPFERR) ;Parse ORU~R01 Message/Segments
 ;
 ;  Input:
 ;     DGWRK - Closed root work global reference
 ;      DGHL - HL7 environment array
 ;    DGROOT - Closed root ORU results array name
 ;
 ;  Output:
 ;    DGROOT - ORU results array
 ;     Subscript                Field name            Fld# File#
 ;     -----------------------  --------------------  ---- -----
 ;     "SNDFAC"                 N/A                   N/A  N/A
 ;     "DFN"                    PATIENT NAME          .01  26.13
 ;     "FLAG"                   FLAG NAME             .02  26.13
 ;     "OWNER"                  OWNER SITE            .04  26.13
 ;     "ORIGSITE"               ORIGINATING SITE      .05  26.13 
 ;     "NARR",line              ASSIGNMENT NARRATIVE   1   26.13
 ;     assigndt,"ACTION"        ACTION                .03  26.13
 ;     assigndt,"COMMENT",line  HISTORY COMMENTS       1   26.14
 ;   DGPFERR - Undefined on success, ERR segment data array on failure
 ;             Format:  DGPFERR(seg_id,sequence,fld_pos)=error_code
 ;
 N DGFS      ;field separator
 N DGCS      ;component separator
 N DGRS      ;repetition separator
 N DGCURLIN  ;current segment line
 N DGSEG     ;segment field data array
 N DGERR     ;error processing array
 ;
 S DGFS=DGHL("FS")
 S DGCS=$E(DGHL("ECH"),1)
 S DGRS=$E(DGHL("ECH"),2)
 S HLECH=DGHL("ECH"),HLFS=DGHL("FS")
 S DGCURLIN=0
 ;
 ;loop through message segments and retrieve field data
 F  D  Q:'DGCURLIN
 . N DGSEG
 . S DGCURLIN=$$NXTSEG^DGPFHLUT(DGWRK,DGCURLIN,DGFS,.DGSEG)
 . Q:'DGCURLIN
 . D @(DGSEG("TYPE")_"(.DGSEG,DGCS,DGRS,DGROOT,.DGPFERR)")
 ;
MSH(DGSEG,DGCS,DGRS,DGORU,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;    DGORU - Closed root ORU results array name
 ;
 ;  Output:
 ;    DGORU - ORU results array
 ;            Subscript
 ;            ---------
 ;            "SNDFAC"
 ;    DGERR - undefined on success, error array on failure
 ;            format: DGERR(seg_id,sequence,fld_pos)=error code
 ;
 S @DGORU@("SNDFAC")=$$IEN^XUAF4($P(DGSEG(4),DGCS,1))
 Q
 ;
PID(DGSEG,DGCS,DGRS,DGORU,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - PID segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;    DGORU - Closed root ORU results array name
 ;
 ;  Output:
 ;    DGORU - ORU results array
 ;            Subscript
 ;            ---------
 ;            "DFN"
 ;    DGERR - undefined on success, error array on failure
 ;            format: DGERR(seg_id,sequence,fld_pos)=error code
 ;
 N DGARR
 N DGDFNERR
 N DGICN
 ;
 S DGICN=+$P(DGSEG(3),DGCS,1)
 S DGARR("DFN")=$$GETDFN^DGPFUT2(DGICN,"DGDFNERR")
 I 'DGARR("DFN"),$G(DGDFNERR("DIERR",1))]"" D
 . S DGERR("PID",DGSEG(1),3)=DGDFNERR("DIERR",1)  ;no match
 ;
 ;load results array
 S @DGORU@("DFN")=DGARR("DFN")
 Q
 ;
OBR(DGSEG,DGCS,DGRS,DGORU,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - OBR segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;    DGORU - Closed root ORU results array name
 ;
 ;  Output:
 ;    DGORU - ORU results array
 ;            Subscript
 ;            ----------------
 ;            "FLAG"
 ;            "OWNER"
 ;            "ORIGSITE"
 ;    DGERR - undefined on success, error array on failure
 ;            format: DGERR(seg_id,sequence,fld_pos)=error code
 ;
 N DGARR
 N PRFFLG   ; ien of received PRF flag in file 26.15
 ;
 S PRFFLG=+$$FIND1^DIC(26.15,,"X",$$DECHL7^DGPFHLUT($P($G(DGSEG(4)),DGCS,2)))
 S DGARR("FLAG")=PRFFLG_";DGPF(26.15,"
 I '$$TESTVAL^DGPFUT(26.13,.02,DGARR("FLAG")) D
 .S DGERR("OBR",DGSEG(1),4)=261111   ;invalid flag
 .Q
 ;
 S DGARR("OWNER")=$$IEN^XUAF4(DGSEG(20))
 I (DGARR("OWNER")="")!('$$TESTVAL^DGPFUT(26.13,.04,DGARR("OWNER"))) D 
 .S DGERR("OBR",DGSEG(1),20)=261126  ;invalid owner site
 .Q
 ;
 S DGARR("ORIGSITE")=$$IEN^XUAF4($G(DGSEG(21)))
 I DGARR("ORIGSITE")="" S DGARR("ORIGSITE")=@DGORU@("SNDFAC")
 I (DGARR("ORIGSITE")="")!('$$TESTVAL^DGPFUT(26.13,.05,DGARR("ORIGSITE"))) D
 .S DGERR("OBR",DGSEG(1),21)=261125  ;invalid originating site
 .Q
 ;
 ;load results array
 M @DGORU=DGARR
 Q
 ;
OBX(DGSEG,DGCS,DGRS,DGORU,DGERR) ;
 ;
 ;  Input:
 ;    DGSEG - OBX segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;    DGORU - Closed root ORU results array name
 ;
 ;  Output:
 ;    DGORU - ORU results array
 ;            Subscript
 ;            -----------------------
 ;            "NARR",line
 ;            assigndt,"ACTION"
 ;            assigndt,"COMMENT",line
 ;   DGERR - undefined on success, error array on failure
 ;           format: DGERR(seg_id,sequence,fld_pos)=error code
 ;
 N DGADT    ;assignment date
 N DGI
 N DGLINE   ;word processing line count
 N DGRSLT,DBRSACT,DBRSDT,DBRSNUM,DBRSOTH,DBRSSITE
 ;
 ; Narrative Observation Identifier
 I $P(DGSEG(3),DGCS,1)="N" D
 .S DGLINE=$O(@DGORU@("NARR",""),-1)
 .F DGI=1:1:$L(DGSEG(5),DGRS) S @DGORU@("NARR",DGLINE+DGI,0)=$$DECHL7^DGPFHLUT($P(DGSEG(5),DGRS,DGI))
 .Q
 ; Status Observation Identifier
 I $P(DGSEG(3),DGCS,1)="S" D
 .S DGADT=$$HL7TFM^XLFDT(DGSEG(14),"L") Q:+DGADT'>0
 .D CHK^DIE(26.14,.03,,$$DECHL7^DGPFHLUT(DGSEG(5)),.DGRSLT)
 .S @DGORU@(DGADT,"ACTION")=+DGRSLT
 .Q
 ; Comment Observation Identifier
 I $P(DGSEG(3),DGCS,1)="C" D
 .S DGADT=$$HL7TFM^XLFDT(DGSEG(14),"L") Q:+DGADT'>0
 .S DGLINE=$O(@DGORU@(DGADT,"COMMENT",""),-1)
 .F DGI=1:1:$L(DGSEG(5),DGRS) S @DGORU@(DGADT,"COMMENT",DGLINE+DGI,0)=$$DECHL7^DGPFHLUT($P(DGSEG(5),DGRS,DGI))
 .S @DGORU@(DGADT,"ORIGFAC")=$$IEN^XUAF4($P($G(DGSEG(23)),DGCS,3))
 .Q
 ; DBRS Observation Identifier
 I $P(DGSEG(3),DGCS,1)="D" D
 .S DBRSACT=$S($P(DGSEG(3),DGCS,2)="DBRS-Delete":"D",1:"U")      ; "U" = add/update, "D" = delete
 .S DBRSNUM=$$DECHL7^DGPFHLUT($P(DGSEG(5),DGRS,1)) Q:DBRSNUM=""  ; DBRS #
 .S DBRSOTH=$$DECHL7^DGPFHLUT($P(DGSEG(5),DGRS,2))               ; DBRS OTHER
 .S DBRSDT=+$$HL7TFM^XLFDT(DGSEG(14),"L")                        ; DBRS date
 .S DBRSSITE=$$IEN^XUAF4($P($G(DGSEG(23)),DGCS,3))              ; DBRS creating site
 .S @DGORU@("DBRS",DBRSNUM,"ACTION")=DBRSACT
 .S @DGORU@("DBRS",DBRSNUM,"OTHER")=DBRSOTH
 .S @DGORU@("DBRS",DBRSNUM,"DATE")=DBRSDT
 .S @DGORU@("DBRS",DBRSNUM,"SITE")=$S(DBRSSITE>0:DBRSSITE,1:"")
 .Q
 Q
