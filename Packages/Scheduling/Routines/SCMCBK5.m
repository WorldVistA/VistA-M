SCMCBK5 ;bp/cmf - multiple patient assignments mail queue - RPCVersion = 1 ;;Aug 7, 1998
 ;;5.3;Scheduling;**148,177**;AUG 13, 1993
 Q
 ;
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
 ;
 N SCPTTM,SCESEQ,SCPARM,SCIEN,SC,SCFLD,SCNEWTM,SCMESS,SCX
 ;
 ;check/setup variables
 I '$$OKDATA^SCAPMC6() S SCMESS=$$S(9) G APTTMQ
 ; 
 ;is patient deceased?
 I $$DP^SCMCBK6(DFN) S SCMESS=$$S(1) G APTTMQ
 ;
 ;can PC assignment be made?
 I $$T1() D  I 'SCX S SCMESS=$P(SCX,U,2) G APTTMQ
 .S SCX=$$OKPTTMPC^SCMCBK6(DFN,SCTM,SCACT)
 .;      ;like $$OKPTTMPC^SCMCTMU2(...
 .Q
 ;
 ;is pt already assignmed to team?
 S SCPTTM=$$PTTMACT^SCAPMC6(DFN,SCTM,SCACT,.SCERR)
 I SCPTTM S SCMESS=$$S(10) G APTTMQ
 ;
 I $D(SCFIELDA) D
 .S SCFLD=0
 .F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 ..S SC($J,404.42,"+1,",SCFLD)=@SCFIELDA@(SCFLD)
 ..Q
 .Q
 ;
 S SC($J,404.42,"+1,",.01)=DFN
 S SC($J,404.42,"+1,",.02)=SCACT
 S SC($J,404.42,"+1,",.03)=SCTM
 N SCTMERR
 D UPDATE^DIE("","SC($J)","SCIEN","SCTMERR")
 ;
 I $D(SCTMERR) S SCMESS=$$S(11) K SCIEN
 E  D
 .S SCPTTM=$G(SCIEN(1))
 .S SCNEWTM=1
 .D AFTERTM^SCMCDD1(SCPTTM)
 .Q
 ;
APTTMQ Q +$G(SCPTTM)_U_+$G(SCNEWTM)_U_$G(SCMESS)
 ;
T1() Q $S('$D(SCFIELDA):0,('($D(@SCFIELDA@(.08))#2)):0,($G(@SCFIELDA@(.08))=1):1,1:0)
 ;
S(SCX) Q $$S^SCMCBK6(SCX)
 ;
ACPTATM(DFNA,SCTM,SCFIELDA,SCACT,SCERR,SCNEWTM,SCOLDTM,SCBADTM) ;list of patients assigned to a team (404.42)
 ; input: as per ACPTTM (above with the following change:)
 ;    DFNA    = is the literal value of a patient array (e.g. "scpt"
 ;              there is at least one scpt(dfn)="" defined
 ;    SCNEWTM = Subset of DFNA that was NEWLY assigned to Team [returned]
 ;    SCOLDTM = Subset of DFNA that was already assigned -Team [returned]
 ;    SCBADTP = Subset of DFNA that was NOT assigned to Team  [returned]
 ;    Note: The above three arrays return data in a user determined array
 ;
 ; output: Count of Patients: 
 ;           1             2            3               4
 ;    total assigned^newly assigned^assigned prior^not assigned
 ;
 N DFN,SCNEWCNT,SCOLDCNT,SCBADCNT,SCTOTCNT,SCX,SCNOMAIL
 S SCNOMAIL=1
 S (SCNEWCNT,SCOLDCNT,SCBADCNT)=0
 S SCTOTCNT=$$PASSCNT(DFNA)
 I SCTOTCNT=0 G MAIL
 ;
 S DFN=0
 F  S DFN=$O(@DFNA@(DFN)) Q:'DFN  D
 .S SCX=$$ACPTTM(.DFN,.SCTM,.SCFIELDA,.SCACT,.SCERR)
 .;
 .;newly assigned
 .I $P(SCX,U,2)=1 D  Q
 ..S SCNEWCNT=SCNEWCNT+1
 ..S @SCNEWTM@(DFN)=+SCX
 ..Q
 .;
 .;already assigned
 .I +SCX D  Q
 ..;;;I $P(SCX,U,1)&('$P(SCX,U,2)) D  Q
 ..S SCOLDCNT=SCOLDCNT+1
 ..S @SCOLDTM@(DFN)=+SCX
 ..Q
 .;
 .;not assigned ;;;I 'SCX D
 .S @SCBADTM@(DFN)=$P(SCX,U,3)
 .S SCBADCNT=SCBADCNT+1
 .Q
 ;
MAIL K SCNOMAIL
 D MAILLST^SCMCBK7(SCTM,.SCADDFLD,DT,.SCNEWTM,.SCOLDTM,.SCBADTM,SCTOTCNT)
 Q (SCNEWCNT+SCOLDCNT)_U_SCNEWCNT_U_SCOLDCNT_U_SCBADCNT
 ;
PASSCNT(DFNA) ;count total patients passed to queue
 ;input:  DFNA=tmp array location
 ;output: count
 ;
 N SCX,DFN
 S (SCX,DFN)=0
 F  S DFN=$O(@DFNA@(DFN)) Q:'DFN  S SCX=SCX+1
 Q SCX
 ;
