SCMCMU2 ;ALBOI/MJK - PCMM Mass Team/Position Unassignment Processing;07/10/98
 ;;5.3;Scheduling;**148,177,524**;AUG 13, 1993;Build 29
 ;
QUE() ; -- queue mass unassignment
 ;D START Q 99999 ; -- for interactive testing
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK
 S ZTRTN="START^SCMCMU2"
 S ZTDESC=VALM("TITLE")
 S ZTDTH=$H
 S ZTIO=""
 F X="SCTEAM","SCPOS","SCTPDIS(","SCMUTYPE","SCDATE","SCSELCNT" S ZTSAVE(X)=""
 F X="^TMP(""SCMU"",$J,""SELECTED"",","^TMP(""SCMU"",$J,""PATIENT INFO""," S ZTSAVE(X)=""
 D ^%ZTLOAD
 Q $G(ZTSK)
 ;
START ; -- entry point for task
 ; -- defined from task SCTEAM,SCPOS,SCTPDIS,SCMUTYPE,SCDATE,SCSELCNT
 ;
 N SCTOP,SCUNCNT,SCASCNT,SCOK
 S SCUNCNT=0
 S SCASCNT=SCSELCNT
 ;
 ; -- lock top node
 IF SCMUTYPE="T" D
 . S SCTOP=$NA(^SCTM(404.51,+SCTEAM,0))
 ELSE  IF SCMUTYPE="P" D
 . S SCTOP=$NA(^SCTM(404.57,+SCPOS,0))
 D LOCK(SCTOP)
 ;
 ; -- use tmp data brought in by TaskMan
 N SCPTSEL,SCPTINFO
 S SCPTSEL=$NA(^TMP("SCMU",$J,"SELECTED"))
 S SCPTINFO=$NA(^TMP("SCMU",$J,"PATIENT INFO"))
 ;
 N SCOKAR,SCBADAR,SCERRAR,SCPTTP
 S SCOKAR=$NA(^TMP("SCMU",$J,"OK"))
 S SCBADAR=$NA(^TMP("SCMU",$J,"BAD"))
 S SCERRAR=$NA(^TMP("SCMU",$J,"ERROR"))
 S SCPTTP=$NA(^TMP("SCMU",$J,"PATIENT-POSITION"))
 K @SCOKAR,@SCBADAR,@SCERRAR,@SCPTTP
 ;
 N SCNT,SCNODE,SCPTX
 ;
 ; -- create patient-position array for team processing
 IF SCMUTYPE="T" D PTTPLST^SCMCMU11(SCTEAM,SCDATE,SCPTTP)
 ;
 S SCNT=0
 F  S SCNT=$O(@SCPTSEL@(SCNT)) Q:'SCNT  D
 . ;N SCDATE S SCDATE=2700101 ; -- use to force error/testing 
 . S SCPTX=$G(@SCPTINFO@(SCNT))
 . IF SCPTX="" Q
 . IF SCMUTYPE="T" S SCOK=$$TMDIS(SCDATE,SCTEAM,SCNT,SCPTX)
 . ;
 . IF SCMUTYPE="P" S SCOK=$$TPDIS(SCDATE,SCPOS,SCNT,SCPTX)
 . ;
 . ; -- if successful
 . IF SCOK D
 . . S @SCOKAR@(SCNT)=""
 . . S SCUNCNT=SCUNCNT+1
 . . S SCASCNT=SCASCNT-1
 . ;
 . ; -- if not sucessful
 . ELSE  D
 . . S @SCBADAR@(SCNT)=""
 ;
 ; -- unlock top node
 D UNLOCK(SCTOP)
 ;
 ; -- send results
 D BULL^SCMCMU4
 ;
 K @SCOKAR,@SCBADAR,@SCERRAR,@SCPTTP
 K @SCPTSEL,@SCPTINFO
 Q
 ;
 ; **** May want to eventually combine TMDIS & TPDIS tags ****
 ;
TMDIS(SCDATE,SCTEAM,SCNT,SCPTX) ; -- team unassignment for patient
 ; input:   SCDATE := effective date
 ;          SCTEAM := ien of TEAM entry (404.51)
 ;          SCNT   := entry in @SCPTINFO@ & @SCPTALL@ arrays
 ;          SCPTX  := format defined by output of $$PTTM^SCAPMC2
 ;
 N SCNODE,SCPOS,SCPOSI,SCOK,SCERRS,DFN,SCIEN,SCASDT,SCUNDT
 ;
 S SCOK=1
 S SCERRS="SCERRLST"
 ;
 S DFN=+SCPTX
 S SCIEN=+$P(SCPTX,U,3)
 S SCNODE=$NA(^SCPT(404.42,SCIEN,0))
 S SCASDT=+$P(SCPTX,U,4)
 S SCUNDT=+$P(SCPTX,U,5)
 ;
 ; -- unassign from positions first
 S SCPOS=0
 F  S SCPOS=$O(@SCPTTP@(DFN,SCPOS)) Q:'SCPOS  D  Q:'SCOK
 . S SCOK=$$TPDIS(SCDATE,SCPOS,SCNT,$G(@SCPTTP@(DFN,SCPOS)))
 ;
 IF 'SCOK D
 . S @SCERRAR@(SCNT,"TEAM",SCTEAM,1)="Team still assigned to patient."
 . S @SCERRAR@(SCNT,"TEAM",SCTEAM,2)="Not able to unassign at least one position."
 ;
 IF SCOK D
 . ; -- if assignment date is in future then delete
 . IF SCASDT>DT,SCASDT>SCDATE D  Q
 . . N DA,DIK
 . . S DA=SCIEN,DIK="^SCPT(404.42,"
 . . D LOCK(SCNODE)
 . . D ^DIK
 . . D UNLOCK(SCNODE)
 . . S @SCOKAR@(SCNT,"TEAM",SCTEAM,1)=">>> Future team assignment deleted."
 . . S @SCOKAR@(SCNT,"TEAM",SCTEAM,2)="    Assignment Date: "_$$FMTE^XLFDT(SCASDT,"5Z")_"   Entry#: "_SCIEN
 . . Q
 . ;
 . ; -- if assignment date is after effective date but before today
 . IF SCASDT>SCDATE,SCASDT<DT D  Q
 . . S SCOK=0
 . . S @SCERRAR@(SCNT,"TEAM",SCTEAM,1)="Patient is still assigned to team."
 . . S @SCERRAR@(SCNT,"TEAM",SCTEAM,2)="Assignment date is after effective date but before today."
 . . S @SCERRAR@(SCNT,"TEAM",SCTEAM,3)="Assignment Date: "_$$FMTE^XLFDT(SCASDT,"5Z")_"   Entry#: "_SCIEN
 . . Q
 . ;
 . ; -- if unassignment date is after effective date but before today
 . IF SCUNDT>SCDATE,SCUNDT<DT D  Q
 . . S SCOK=0
 . . S @SCERRAR@(SCNT,"TEAM",SCTEAM,1)="Patient is still assigned to team."
 . . S @SCERRAR@(SCNT,"TEAM",SCTEAM,2)="Unassignment date is after effective date but before today."
 . . S @SCERRAR@(SCNT,"TEAM",SCTEAM,3)="Unassignment Date: "_$$FMTE^XLFDT(SCUNDT,"5Z")_"   Entry#: "_SCIEN
 . . Q
 . ;
 . ; -- make change
 . K @SCERRS
 . S SCOK=$$INPTTM^SCAPMC(DFN,SCIEN,SCDATE,.SCERRS)
 . D UNLOCK(SCNODE)
 . M @SCERRAR@(SCNT,"TEAM",SCTEAM)=SCERRLST
 . K @SCERRS
 . IF SCOK D
 . . S @SCOKAR@(SCNT,"TEAM",SCTEAM,1)=""
 . ;
 . ; -- set message if unassigned date changed
 . IF SCOK,SCUNDT>SCDATE D
 . . S @SCOKAR@(SCNT,"TEAM",SCTEAM,1)=">>> Future team unassignment date was changed."
 . . S @SCOKAR@(SCNT,"TEAM",SCTEAM,2)="    Old Date: "_$$FMTE^XLFDT(SCUNDT,"5Z")_"   New Date: "_$$FMTE^XLFDT(SCDATE,"5Z")_"   Entry#: "_SCIEN_")"
 ;
 Q SCOK
 ;
TPDIS(SCDATE,SCPOS,SCNT,SCPTX) ; -- position unassignment for patient
 ; input:   SCDATE := effective date
 ;          SCTEAM := ien of TEAM POSITION entry (404.57)
 ;          SCNT   := entry in @SCPTINFO@ & @SCPTALL@ arrays
 ;          SCPTX  := format defined by output of $$PTTP^SCAPMC2
 ;
 N SCNODE,SCOK,SCERRS,DFN,SCIEN,SCASDT,SCUNDT
 S SCASDT=+$P(SCPTX,U,4)
 S SCUNDT=+$P(SCPTX,U,5)
 ;
 S SCOK=1
 S SCERRS="SCERRLST"
 ;
 S DFN=+SCPTX
 S SCIEN=+$P(SCPTX,U,3)
 S SCNODE=$NA(^SCPT(404.43,SCIEN,0))
 S SCASDT=+$P(SCPTX,U,4)
 S SCUNDT=+$P(SCPTX,U,5)
 ;
 ; if assignment date is in future then delete
 IF SCOK D
 . ; -- if assignment date is in future then delete
 . IF SCASDT>DT,SCASDT>SCDATE D  Q
 . . N DA,DIE,DIK,DR
 . . S DA=SCIEN,(DIE,DIK)="^SCPT(404.43,",DR=".04///"_DT D ^DIE  ; og/sd/524
 . . D LOCK(SCNODE)
 . . D ^DIK
 . . D UNLOCK(SCNODE)
 . . S @SCOKAR@(SCNT,"POS",SCPOS,1)="    >>> Future position assignment deleted."
 . . S @SCOKAR@(SCNT,"POS",SCPOS,2)="        Assignment Date: "_$$FMTE^XLFDT(SCASDT,"5Z")_"   Entry#: "_SCIEN
 . . Q
 . ;
 . ; -- if assignment date is after effective date but before today
 . IF SCASDT>SCDATE,SCASDT<DT D  Q
 . . S SCOK=0
 . . S @SCERRAR@(SCNT,"POS",SCPOS,1)="Patient is still assigned to position."
 . . S @SCERRAR@(SCNT,"POS",SCPOS,2)="Assignment date is after effective date but before today."
 . . S @SCERRAR@(SCNT,"POS",SCPOS,3)="Assignment Date: "_$$FMTE^XLFDT(SCASDT,"5Z")_"   Entry#: "_SCIEN
 . . Q
 . ;
 . ; -- if unassignment date is after effective date but before today
 . IF SCUNDT>SCDATE,SCUNDT<DT D  Q
 . . S SCOK=0
 . . S @SCERRAR@(SCNT,"POS",SCPOS,1)="Patient is still assigned to position."
 . . S @SCERRAR@(SCNT,"POS",SCPOS,2)="Unassignment date is after effective date but before today."
 . . S @SCERRAR@(SCNT,"POS",SCPOS,3)="Unassignment Date: "_$$FMTE^XLFDT(SCUNDT,"5Z")_" ("_SCIEN_")"
 . . Q
 . ;
 . K @SCERRS
 . D LOCK(SCNODE)
 . S SCOK=$$INPTTP^SCAPMC(DFN,SCIEN,SCDATE,.SCERRS)
 . D UNLOCK(SCNODE)
 . M @SCERRAR@(SCNT,"POS",SCPOS)=SCERRLST
 . K @SCERRS
 . IF SCOK D
 . . S @SCOKAR@(SCNT,"POS",SCPOS,1)=""
 . ;
 . ; -- set message if unassigned date changed
 . IF SCOK,SCUNDT>SCDATE D
 . . S @SCOKAR@(SCNT,"POS",SCPOS,1)="    >>> Future position unassignment date was changed."
 . . S @SCOKAR@(SCNT,"POS",SCPOS,2)="        Old Date: "_$$FMTE^XLFDT(SCUNDT,"5Z")_"   New Date: "_$$FMTE^XLFDT(SCDATE,"5Z")_"   Entry#: "_SCIEN_")"
 . . Q
 ;
 IF SCOK D
 . S @SCOKAR@(SCNT,"CLINIC",SCPOS,1)=$$CLDIS(SCPOS)
 . Q
 ;
TPDISQ Q SCOK
 ;
CLDIS(SCPOS) ; -- discharge from clinic
 N SCPOS0,SCCLN,SCREA,SCRET
 S SCRET=""
 ;
 ; -- if user did not request clinic discharge, quit
 IF '$G(SCTPDIS(+SCPOS)) G CLDISQ
 ;
 S SCPOS0=$G(^SCTM(404.57,SCPOS,0))
 S SCCLN=$P(SCPOS0,U,9)
 IF SCCLN D
 . S SCREA="Team position mass discharge"
 . S SCRET=$$EN^SCMCMU3(DFN,SCCLN,SCDATE,SCREA)
 . Q
 ELSE  D
 . S SCRET="0^No clinic assignment to position"
 . Q
 ;
CLDISQ Q SCRET
 ;
LOCK(NODE) ; -- lock node
 F  L +@NODE:5 IF $T Q
 Q
 ;
UNLOCK(NODE) ; -- unlock node
 L -@NODE
 Q
 ;
