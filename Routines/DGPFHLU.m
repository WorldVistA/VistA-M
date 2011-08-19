DGPFHLU ;ALB/RPM - PRF HL7 ORU/ACK PROCESSING ; 6/21/06 10:27am
 ;;5.3;Registration;**425,718,650**;Aug 13, 1993;Build 3
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
 N DGSTR     ;field string
 N DGTROOT   ;text root
 ;
 S DGHIEN=0
 S DGSEG=0
 ;
 I $D(DGPFA),$D(DGHARR),$G(DGROOT)]"" D
 . ;
 . ;build PID
 . S DGSTR="1,2,3,5,7,8,19"
 . S DGSEGSTR=$$EN^VAFHLPID(+DGPFA("DFN"),DGSTR,1,1)
 . Q:(DGSEGSTR="")
 . S DGSEG=DGSEG+1,@DGROOT@(DGSEG)=DGSEGSTR
 . ;
 . ;build OBR
 . S DGLDT=+$O(DGHARR(""),-1)  ;get last assignment date
 . Q:'$$GETHIST^DGPFAAH(DGHARR(DGLDT),.DGPFAH)  ;load asgn hx array
 . S DGSET=1
 . S DGSTR="1,4,7,20,21"
 . S DGSEGSTR=$$OBR^DGPFHLU1(DGSET,.DGPFA,.DGPFAH,DGSTR,.DGHL)
 . Q:(DGSEGSTR="")
 . S DGSEG=DGSEG+1,@DGROOT@(DGSEG)=DGSEGSTR
 . ;
 . ;start OBX segments
 . S DGSET=0
 . ;
 . ;build narrative OBX segments
 . S DGTROOT="DGPFA(""NARR"")"
 . Q:'$$BLDOBXTX^DGPFHLU2(DGROOT,DGTROOT,"N",.DGPFAH,.DGHL,.DGSEG,.DGSET)
 . ;
 . ;for each history build status & comment OBX segments
 . S DGADT=0
 . F  S DGADT=$O(DGHARR(DGADT)) Q:'DGADT  D  Q:'DGHIEN
 . . N DGPFAH
 . . S DGHIEN=0
 . . Q:'$$GETHIST^DGPFAAH(DGHARR(DGADT),.DGPFAH)
 . . ;
 . . ;build status OBX segment
 . . S DGSTR="1,2,3,5,11,14"
 . . S DGSET=DGSET+1
 . . S DGSEGSTR=$$OBX^DGPFHLU2(DGSET,"S","",$P($G(DGPFAH("ACTION")),U,2),.DGPFAH,DGSTR,.DGHL)
 . . Q:(DGSEGSTR="")
 . . S DGSEG=DGSEG+1,@DGROOT@(DGSEG)=DGSEGSTR
 . . ;
 . . ;build review comment OBX segments
 . . S DGTROOT="DGPFAH(""COMMENT"")"
 . . Q:'$$BLDOBXTX^DGPFHLU2(DGROOT,DGTROOT,"C",.DGPFAH,.DGHL,.DGSEG,.DGSET)
 . . ;
 . . ;success
 . . S DGHIEN=DGHARR(DGADT)
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
 ;
 S DGARR("FLAG")=$P($G(DGSEG(4)),DGCS,1)_";DGPF(26.15,"
 I '$$TESTVAL^DGPFUT(26.13,.02,DGARR("FLAG")) D
 . S DGERR("OBR",DGSEG(1),4)=261111   ;invalid flag
 ;
 S DGARR("OWNER")=$$IEN^XUAF4(DGSEG(20))
 I (DGARR("OWNER")="")!('$$TESTVAL^DGPFUT(26.13,.04,DGARR("OWNER"))) D 
 . S DGERR("OBR",DGSEG(1),20)=261126  ;invalid owner site
 ;
 S DGARR("ORIGSITE")=$$IEN^XUAF4($G(DGSEG(21)))
 I DGARR("ORIGSITE")="" S DGARR("ORIGSITE")=@DGORU@("SNDFAC")
 I (DGARR("ORIGSITE")="")!('$$TESTVAL^DGPFUT(26.13,.05,DGARR("ORIGSITE"))) D
 . S DGERR("OBR",DGSEG(1),21)=261125  ;invalid originating site
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
 N DGRSLT
 ;
 ; Narrative Observation Identifier
 I $P(DGSEG(3),DGCS,1)="N" D
 . S DGLINE=$O(@DGORU@("NARR",""),-1)
 . F DGI=1:1:$L(DGSEG(5),DGRS) D
 . . S @DGORU@("NARR",DGLINE+DGI,0)=$P(DGSEG(5),DGRS,DGI)
 ;
 ; Status Observation Identifier
 I $P(DGSEG(3),DGCS,1)="S" D
 . S DGADT=$$HL7TFM^XLFDT(DGSEG(14),"L")
 . Q:+DGADT'>0
 . D CHK^DIE(26.14,.03,,DGSEG(5),.DGRSLT)
 . S @DGORU@(DGADT,"ACTION")=+DGRSLT
 ;
 ; Comment Observation Identifier
 I $P(DGSEG(3),DGCS,1)="C" D
 . S DGADT=$$HL7TFM^XLFDT(DGSEG(14),"L")
 . Q:+DGADT'>0
 . S DGLINE=$O(@DGORU@(DGADT,"COMMENT",""),-1)
 . F DGI=1:1:$L(DGSEG(5),DGRS) D
 . . S @DGORU@(DGADT,"COMMENT",DGLINE+DGI,0)=$P(DGSEG(5),DGRS,DGI)
 Q
