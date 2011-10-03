SCMCMU1 ;ALB/MJK - PCMM Mass Team/Position List Manager ; 10-JUL-1998
 ;;5.3;Scheduling;**148**;AUG 13, 1993
 ;
EN(SCTEAM,SCPOS,SCTPDIS,SCMUTYPE,SCDATE) ; -- main entry point for SCMC MU MASS TEAM UNASSIGNMENT
 D EN^VALM("SCMC MU MASS TEAM UNASSIGNMENT")
 Q
 ;
HDR ; -- header code
 N X,SCTEAM0
 S SCTEAM0=$G(^SCTM(404.51,+SCTEAM,0),"Unknown")
 S X=$E("    Team: "_$P(SCTEAM0,U),1,40)
 S X=$$SETSTR^VALM1(" Total: "_+$G(SCALLCNT)_"  Selected: "_+$G(SCSELCNT),X,45,35)
 S VALMHDR(1)=X
 ;
 S X=""
 IF SCMUTYPE="P" D
 . S SCPOS0=$G(^SCTM(404.57,+SCPOS,0),"Unknown")
 . S X=$E("Position: "_$P(SCPOS0,U),1,40)
 . IF '$G(SCTPDIS(+SCPOS)) Q
 . S X=$$SETSTR^VALM1("Clinic: "_$P($G(^SC(+$P(SCPOS0,U,9),0),"Unknown"),U),X,45,35)
 .Q
 ;
 S VALMHDR(2)=X
 S X="Proposed Effective Date: "_$$FMTE^XLFDT($E(SCDATE,1,7),"5Z")
 S X=$$SETSTR^VALM1("  View: "_SCVIEW_$S(SCVIEW="ALL":"",1:"ED"),X,45,35)
 S VALMHDR(3)=X
 Q
 ;
INIT ; -- init variables and list array
 N SCPATS,SCI,SCALPHA,SCX,SCDTE
 S SCPATS=$NA(^TMP("SCMU",$J,"PATIENTS"))
 S SCALPHA=$NA(^TMP("SCMU",$J,"PATS ALPHA"))
 K @SCPATS,@SCALPHA
 ;
 ; -- set up persistent structures
 S SCPTINFO=$NA(^TMP("SCMU",$J,"PATIENT INFO"))    ; useful patient data
 S SCPTSEL=$NA(^TMP("SCMU",$J,"SELECTED"))         ; patients selected
 S SCPTALL=$NA(^TMP("SCMU",$J,"PATIENT ALL"))      ; listman data
 ;
 K @SCPTINFO,@SCPTSEL,@SCPTALL
 S (SCALLCNT,SCSELCNT,SCMSG)=0
 S SCVIEW="ALL"
 ;
 W ! D WAIT^DICD
 ;
 ; -- change title is appropriate
 IF SCMUTYPE="P" S VALM("TITLE")="Mass Position Unassignment"
 ;
 ; -- get patients
 D DATE(SCDATE,.SCDTE)
 IF SCMUTYPE="T",'$$PTTM^SCAPMC(SCTEAM,SCDTE,SCPATS) G INITQ
 IF SCMUTYPE="P",'$$PTTP^SCAPMC(SCPOS,SCDTE,SCPATS) G INITQ
 ;
 ; -- build list for display
 S SCI=0
 F  S SCI=$O(@SCPATS@(SCI)) Q:'SCI  D
 . S SCX=@SCPATS@(SCI)
 . S @SCALPHA@($P(SCX,U,2)_SCI)=SCI
 . Q
 ;
 S SCNT=0
 S SCI=""
 F  S SCI=$O(@SCALPHA@(SCI)) Q:SCI=""  D
 . S SCX=$G(@SCPATS@(+@SCALPHA@(SCI)))
 . IF '$$FILTER(SCX,SCDATE) Q
 . S SCNT=SCNT+1
 . S Y=$$SETSTR^VALM1(SCNT,"",1,4)                          ; number
 . S Y=$$SETSTR^VALM1($P(SCX,U,2),Y,15,25)                    ; pt name
 . S Y=$$SETSTR^VALM1($P(SCX,U,6),Y,42,12)                    ; pt id
 . S Y=$$SETSTR^VALM1($$FMTE^XLFDT($P(SCX,U,4),"5Z"),Y,56,10) ; assigned
 . S Y=$$SETSTR^VALM1($$FMTE^XLFDT($P(SCX,U,5),"5Z"),Y,69,10) ; unassigned
 . ;
 . ; -- flag if this is a future assignment
 . IF $P(SCX,U,4)>DT D
 . . S Y=$$SETSTR^VALM1("*",Y,55,1)
 . . IF 'SCMSG S SCMSG=1 D MSG
 . ;
 . ; -- flag if this is a future unassignment
 . IF $P(SCX,U,5)>DT D
 . . S Y=$$SETSTR^VALM1("*",Y,68,1)
 . . IF 'SCMSG S SCMSG=1 D MSG
 . ;
 . S @SCPTALL@(SCNT,0)=Y
 . S @SCPTALL@("IDX",SCNT,SCNT)=SCNT
 . S @SCPTINFO@(SCNT)=SCX
 . Q
 K @SCPATS,@SCALPHA
 S SCALLCNT=SCNT
 ;
 ; -- set up lm array
 D BLD
 ;
INITQ Q
 ;
FILTER(SCX,SCDATE) ; -- apply filter criteria
 N SCOK
 S SCOK=1
 ; -- if inactivation date is =< effective then don't use
 IF $P(SCX,U,5),$P(SCX,U,5)'>SCDATE S SCOK=0
 Q SCOK
 ;
BLD ; -- build VALMAR
 K @VALMAR
 ;
 IF SCVIEW="ALL" D
 . M @VALMAR=@SCPTALL
 . S VALMCNT=SCALLCNT
 . Q
 ;
 ELSE  D
 . N SCNT
 . S (SCNT,VALMCNT)=0
 . F  S SCNT=$O(@SCPTALL@(SCNT)) Q:'SCNT  D
 . . ; -- if in select view and patient not selected then don't use
 . . IF SCVIEW="SELECT",'$D(@SCPTSEL@(SCNT)) Q
 . . ; -- if in de-select view and patient selected then don't use
 . . IF SCVIEW="DE-SELECT",$D(@SCPTSEL@(SCNT)) Q
 . . ;
 . . S VALMCNT=VALMCNT+1
 . . S Y=@SCPTALL@(SCNT,0)
 . . S @VALMAR@(VALMCNT,0)=$$SETSTR^VALM1(VALMCNT,Y,1,4)
 . . ;
 . . ; -- set idx to pointer back to SCPTALL (this is key!)
 . . S @VALMAR@("IDX",VALMCNT,VALMCNT)=SCNT
 . . Q
 . Q
 ;
 IF '$O(@VALMAR@(0)) D
 . S @VALMAR@(1,0)=" "
 . S @VALMAR@(2,0)=" "
 . S @VALMAR@(3,0)="         No patients to list."
 . Q
 IF $G(VALMBG),'$D(@VALMAR@(VALMBG,0)) S VALMBG=1
 K VALMHDR
 D BACK("R")
 Q
 ;
SETSEL(FLAG,SCNT) ; -- set selected flag indicator
 N Y,SCPTCNT
 ;
 ; -- get pointer back to SCPTALL
 S SCPTCNT=+$G(@VALMAR@("IDX",SCNT,SCNT))
 IF FLAG="DE-SELECT",$D(@SCPTSEL@(SCPTCNT)) D
 . K @SCPTSEL@(SCPTCNT)
 . S SCSELCNT=$S(SCSELCNT=0:0,1:SCSELCNT-1)
 ;
 IF FLAG="SELECT",'$D(@SCPTSEL@(SCPTCNT)) D
 . S @SCPTSEL@(SCPTCNT)=""
 . S SCSELCNT=$S(SCSELCNT=SCALLCNT:SCALLCNT,1:SCSELCNT+1)
 ;
 S Y=$G(@VALMAR@(SCNT,0))
 S Y=$$SETSTR^VALM1($S(FLAG="SELECT":"Yes",1:""),Y,8,3)
 S @VALMAR@(SCNT,0)=Y
 ;
 ; -- need to do SCPTALL separately because of potential for differnt #'s
 S Y=$G(@SCPTALL@(SCPTCNT,0))
 S Y=$$SETSTR^VALM1($S(FLAG="SELECT":"Yes",1:""),Y,8,3)
 S @SCPTALL@(SCPTCNT,0)=Y
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAR^VALM1
 K @VALMAR,SCSELCNT,SCVIEW,SCALLCNT,SCMSG
 K @SCPTALL,@SCPTSEL,@SCPTINFO
 K SCPTALL,SCPTSEL,SCPTINFO
 Q
 ;
EXPND ; -- expand code
 Q
 ;
ALL(SCACT) ;  -- entry point for SCMC SELECT ALL & SCMC DESELECT ALL protocols
 IF SCVIEW=SCACT D  Q
 . W !!,"All patients in current view are already '"_SCACT_"ED'."
 . D PAUSE
 . D BACK("")
 . Q
 D ACT(SCACT,SCPTALL)
 Q
 ;
SOME(SCACT) ; -- entry point for SCMC SELECT SOME & SCMC DESELECT SOME protocols
 IF SCVIEW=SCACT D  Q
 . W !!,"All patients in current view are already '"_SCACT_"ED'."
 . D PAUSE
 . D BACK("")
 . Q
 D EN^VALM2(XQORNOD(0),"O")
 D ACT(SCACT,"VALMY")
 Q
 ;
ACT(SCACT,SCLIST) ; -- change select flag
 N SCNT
 S SCNT=0
 F  S SCNT=$O(@SCLIST@(SCNT)) Q:'SCNT  D SETSEL(SCACT,SCNT)
 W !
 D WAIT^DICD,BLD
 Q
 ;
VIEW(SCVW) ; -- change view
 S SCVIEW=SCVW
 W !
 D WAIT^DICD,BLD
 Q
 ;
BACK(ACTION) ; -- return to lm processing
 IF $G(SCMSG) D MSG
 S VALMBCK=ACTION
 Q
 ;
MSG ; -- set message var
 S VALMSG="* Future date"
 Q
 ;
DATE(SCDATE,SCDTE) ; -- setup date array
 S SCDTE="SCDTE"
 S SCDTE("BEGIN")=SCDATE
 S SCDTE("END")=9999999
 S SCDTE("INCL")=0
 Q
 ;
PAUSE ; -- pause
 N DIR,Y
 S DIR(0)="EA"
 S DIR("A")="Enter RETURN to continue:"
 D ^DIR
 Q
