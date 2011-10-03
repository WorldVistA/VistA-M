SCAPMC6 ;ALB/REW - Team APIs:APPTTM ; 5 Jul 1995
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1.0
ACPTTM(DFN,SCTM,SCFIELDA,SCACT,SCERR) ;add a patient to a team (pt tm assgn - #404.42
 ; input:
 ;  DFN     = pointer to PATIENT file (#2)
 ;  SCTM    = pointer to TEAM file (#404.51)
 ;  SCFIELDA= array of additional fields to be added
 ;  SCACT   = date to activate [default=DT]
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  Returned = ien of 404.42 - 0 if none after^new?^Message
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 N SCPTTM,SCESEQ,SCPARM,SCIEN,SC,SCFLD,SCNEWTM
 G:'$$OKDATA APTTMQ ;check/setup variables
 IF $S('$D(SCFIELDA):0,('($D(@SCFIELDA@(.08))#2)):0,($G(@SCFIELDA@(.08))=1):1,1:0) IF '$$OKPTTMPC^SCMCTMU2(DFN,SCTM,SCACT) D  G APTTMQ
 .S SCMESS=4044200.001
 S SCPTTM=$$PTTMACT(DFN,SCTM,SCACT,.SCERR)
 IF SCPTTM G APTTMQ
 ELSE  D
 .IF $D(SCFIELDA) D
 ..S SCFLD=0
 ..F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 ...S SC($J,404.42,"+1,",SCFLD)=@SCFIELDA@(SCFLD)
 .S SC($J,404.42,"+1,",.01)=DFN
 .S SC($J,404.42,"+1,",.02)=SCACT
 .S SC($J,404.42,"+1,",.03)=SCTM
 .D UPDATE^DIE("","SC($J)","SCIEN","SCERR")
 .IF $D(@SCERR) K SCIEN
 .ELSE  D
 ..S SCPTTM=$G(SCIEN(1))
 ..S SCNEWTM=1
 ..D AFTERTM^SCMCDD1(SCPTTM)
APTTMQ Q +$G(SCPTTM)_U_+$G(SCNEWTM)
 ;
PTTMACT(DFN,SCTM,SCDT,SCERR) ;what is patient/team assignment on a given date-time into the future? Return 404.42 ien or 0
 N SCTMLST,SCOK,SCPTTMDT
 S SCOK=0
 S SCPTTMDT("BEGIN")=SCDT,SCPTTMDT("END")=3990101,SCPTTMDT("INCL")=0
 IF $$TMPT^SCAPMC3(DFN,"SCPTTMDT","","SCTMLST",.SCERR) S:$D(SCTMLST("SCTM",SCTM)) SCOK=$O(SCTMLST("SCTM",SCTM,0))
 Q SCOK
 ;
ACPTATM(DFNA,SCTM,SCFIELDA,SCACT,SCERR,SCNEWTM,SCOLDTM,SCBADTM) ;list of patients assigned to a team (404.42)
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
 N DFN,SCNEWCNT,SCOLDCNT,SCBADCNT,SCX,SCNOMAIL
 S SCNOMAIL=1
 S (SCNEWCNT,SCOLDCNT,SCBADCNT)=0
 S DFN=0 F  S DFN=$O(@DFNA@(DFN)) Q:'DFN  D
 .S SCX=$$ACPTTM(.DFN,.SCTM,.SCFIELDA,.SCACT,.SCERR)
 .;  SCX = ien of 404.42^new?
 .IF $P(SCX,U,2) D  ;newly assigned
 ..S SCNEWCNT=SCNEWCNT+1
 ..S @SCNEWTM@(DFN)=+SCX   ;scnewtm
 .IF $P(SCX,U,1)&('$P(SCX,U,2)) D  ;old
 ..S SCOLDCNT=SCOLDCNT+1
 ..S @SCOLDTM@(DFN)=+SCX
 .IF 'SCX D
 ..S @SCBADTM@(DFN)=$P(SCX,U,3)
 ..S SCBADCNT=SCBADCNT+1
 K SCNOMAIL
 D MAILLST^SCMCTMM(SCTM,.SCADDFLD,DT,.SCNEWTM,.SCOLDTM,.SCBADTM)
 Q (SCNEWCNT+SCOLDCNT)_U_SCNEWCNT_U_SCOLDCNT_U_SCBADCNT
 ;
OKDATA() ;setup/check variables
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK)
 IF '$D(^DPT(DFN,0))!('$D(^SCTM(404.51,SCTM,0))) D  S SCOK=0
 . S SCPARM("PATIENT")=DFN
 . S SCPARM("TEAM")=SCTM
 . D ERR^SCAPMCU1(SCESEQ,4045101,.SCPARM,"",.SCERR)
 S:'$G(SCACT) SCACT=DT
 Q SCOK
