SCAPMR6 ;ALB/REW/PDR - Team Reassignment APIs:APPTTM ; 5 Jul 1995
 ;;5.3;Scheduling;**148,157**;AUG 13, 1993
 ;
 ; --------------------------- MAIN -------------------------------------
ACPTRATM(DFNA,SCTMTO,SCTMFRM,SCOTH,SCFIELDA,SCACT,SCERR,SCNEWTM,SCOLDTM,SCBADTM) ; list of patients RE-assigned to a team (404.42)
 ; input: as per ACPTTM (above with the following change:)
 ;     DFNA    = is the name of a patient array (e.g. $N(^TMP(SCJOB,"SC PATIENT LIST")))
 ;              there is at least one scpt(dfn)="" defined
 ;     SCTMTO   = pointer to "TO" team file
 ;     SCTMFRM  = pointer to "FROM" team file - PDR 7/98
 ;     SCOTH    = array of other parameters e.g. SCOTH("SIZELIM")
 ;     SCFIELDA = List of array of fields and values in 404.42
 ;     SCACT  = Date filed (NOW)
 ;     SCERR  = Name of error message var
 ;     SCNEWTM = Subset of DFNA that was NEWLY assigned to Team [returned]
 ;     SCOLDTM = Subset of DFNA that was already assigned -Team [returned]
 ;     SCBADTP = Subset of DFNA that was NOT assigned to Team  [returned]
 ;    Note: The above three arrays return data in a user determined array
 ; output: Count of Patients: 
 ;           1             2            3               4
 ;    total assigned^newly assigned^assigned prior^not assigned
 N DFN,SCNEWCNT,SCOLDCNT,SCBADCNT,SCX,SCNOMAIL,SCERR,FASIEN
 S SCNOMAIL=1
 S (SCNEWCNT,SCOLDCNT,SCBADCNT)=0
 S DFN=0
 F  S DFN=$O(@DFNA@(DFN)) Q:'DFN  D
 . S FASIEN=@DFNA@(DFN) ; get the "FROM" team assignment
 . S SCX=$$ACPTTM^SCRPMTA(DFN,SCTMTO,.SCFIELDA,.SCACT,FASIEN,.SCERR)
 . ;  SCX = ien of 404.42^new?
 . IF $P(SCX,U,2) D  ;newly assigned to TO Team
 .. ;S ^TMP("PDR",$J,"NEW",DFN)=""
 .. S SCNEWCNT=SCNEWCNT+1
 .. S @SCNEWTM@(DFN)=+SCX   ;scnewtm
 . IF $P(SCX,U,1)&('$P(SCX,U,2)) D  ;already assigned to TO team
 .. ;S ^TMP("PDR",$J,"OLD",DFN)=""
 .. S SCOLDCNT=SCOLDCNT+1
 .. S @SCOLDTM@(DFN)=+SCX
 . IF 'SCX D  ; Unable to reassign to new team, so don't discharge from old team
 .. ;S ^TMP("PDR",$J,"BAD",DFN)=""
 .. S @SCBADTM@(DFN)=$P(SCX,U,3)
 .. S SCBADCNT=SCBADCNT+1
 K SCNOMAIL
 ; Send out mail notices only if there are failures to reassign
 I SCBADCNT D MAILLST^SCMRTMM(SCTMTO,.SCADDFLD,DT,.SCBADTM) ; report only on unable to assign
 Q (SCNEWCNT+SCOLDCNT)_U_SCBADCNT
 ;
