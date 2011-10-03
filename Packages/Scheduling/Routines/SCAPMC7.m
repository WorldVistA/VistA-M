SCAPMC7 ;ALB/REW - Team APIs:INPTTM ; 5 Jul 1995
 ;;5.3;Scheduling;**41,148**;AUG 13, 1993
 ;;1.0
INPTTM(DFN,SCPTTM,SCINACT,SCERR) ;inactivate patient from a team (pt tm assgn - #404.42
 ; input:
 ;  DFN     = pointer to PATIENT file (#2)
 ;  SCPTTM  = pointer to pt team assign file (#404.42)
 ;  SCINACT = date to inactivate [default=DT]
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  SCOK    = 1 if inactivation entry made to file 404.42, 0 ow
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;             Foramt:
 ;  @SCERR@(0)=Number of erros, undefined if none
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 N SCTM,SC,SCPARM,SCESEQ,SCLSEQ,SCOK
 S SCOK=0
 G:'$$OKDATA APTTMQ ;setup/check variables
 S SCTM=+$P($G(^SCPT(404.42,SCPTTM,0)),U,3)
 IF '$$PTTMACT(DFN,SCTM,SCINACT,.SCERR) D  G APTTMQ
 .S SCOK=0
 .S SCPARM("INACTIVE DATE")=SCINACT
 .D ERR^SCAPMCU1(SCESEQ,4044201,.SCPARM,"",.SCERR)
 ELSE  D
 .S SCOK=1
 .S SC($J,404.42,SCPTTM_",",.09)=SCINACT
 .S SC($J,404.42,SCPTTM_",",.13)=$G(DUZ,.5)
 .D NOW^%DTC
 .S SC($J,404.42,SCPTTM_",",.14)=%
 .D UPDATE^DIE("","SC($J)","SCIEN",.SCERR)
 .I $D(@SCERR@("DIERR")) S SCOK=0
APTTMQ Q SCOK
 ;
PTTMACT(DFN,SCTM,SCDT,SCERR) ;is patient assigned to a team on a given date-time?
 N SCTMDTS,SCTMLST,SCOK
 S SCOK=0
 S (SCTMDTS("BEGIN"),SCTMDTS("END"))=SCDT
 IF $$TMPT^SCAPMC3(DFN,"SCTMDTS","","SCTMLST",.SCERR) S:$D(SCTMLST("SCTM",SCTM)) SCOK=1
 Q SCOK
OKDATA() ;check/setup variables - return 1 if ok/0 if error
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK)
 IF '$D(^DPT(DFN,0))!('$D(^SCPT(404.42,SCPTTM,0))) D  S SCOK=0
 . S SCPARM("PATIENT")=$G(DFN,"Undefined")
 . S SCPARM("Pt TEAM Asnt")=$G(SCPTTM,"Undefined")
 . D ERR^SCAPMCU1(SCESEQ,4045101,.SCPARM,"",.SCERR)
 S:'$G(SCACT) SCACT=DT
 S:'$G(SCINACT) SCINACT=DT
 Q SCOK
 ;
INPTATM(DFNA,SCTM,SCFIELDA,SCACT,SCERR,SCNEWTM,SCOLDTM,SCBADTM) ;list of patients assigned to a team (404.42)
 ; input: as per ACPTTM (above with the following change:)
 ;    DFNA    = is the literal value of a patient array (e.g. "scpt"
 ;              there is at least one scpt(dfn)="" defined
 ;    SCNEWTM = Subset of DFNA that was NEWLY assigned to Team [returned]
 ;    SCOLDTM = Subset of DFNA that was already assigned -Team [returned]
 ;    SCBADTP = Subset of DFNA that was NOT assigned to Team  [returned]
 ;    Note: The above three arrays return data in a user determined array
 ; output: Count of Patients: 
 ;           1             2            3               4
 ;    total assigned^newly assigned^assigned prior^not assigned
 N DFN,SCNEWCNT,SCOLDCNT,SCBADCNT,SCX
 S (SCNEWCNT,SCOLDCNT,SCBADCNT)=0
 S DFN=0 F  S DFN=$O(@DFNA@(DFN)) Q:'DFN  D
 .S SCPTTM=$$HISTPTTM^SCAPMCU2(DFN,.SCTM,.SCACT)
 .S SCX=$S(SCPTTM:$$INPTTM(.DFN,.SCPTTM,.SCFIELDA,.SCACT,.SCERR),1:0)
 .;  SCX = ien of 404.42^new?
 .IF $P(SCX,U,2) D  ;newly assigned
 ..S SCNEWCNT=SCNEWCNT+1
 ..S @SCNEWTM@(DFN)=+SCX   ;scnewtm
 .IF $P(SCX,U,1)&('$P($G(SCX),U,2)) D  ;old
 ..S SCOLDCNT=SCOLDCNT+1
 ..S @SCOLDTM@(DFN)=+SCX
 .IF 'SCX D
 ..S @SCBADTM@(DFN)=""
 ..S SCBADCNT=SCBADCNT+1
 Q (SCNEWCNT+SCOLDCNT)_U_SCNEWCNT_U_SCOLDCNT_U_SCBADCNT
 ;
INPTSCTM(DFN,SCTM,SCINACT,SCERR) ;inactivate patient from a team - using last pt team assignment - Note: This uses pointer to 404.51 (team) not 404.42 as input
 ; input:
 ;  DFN     = pointer to PATIENT file (#2)
 ;  SCTM    = pointer to TEAM file (#404.51)
 ;  SCINACT = date to inactivate [default=DT]
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  SCOK    = 1 if inactivation entry made to file 404.42, 0 ow
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;             Foramt:
 ;  @SCERR@(0)=Number of erros, undefined if none
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;
 N SCACT
 S SCACT=+$O(^SCPT(404.42,"AIDT",DFN,SCTM,""))
 S SCPTTM=+$O(^SCPT(404.42,"AIDT",DFN,SCTM,SCACT,0))
 Q $$INPTTM(.DFN,.SCPTTM,.SCINACT,.SCERR)
