SCMCMU11 ;ALB/MJK - PCMM Mass Team/Position Unassignment ; 10-JUL-1998
 ;;5.3;Scheduling;**148**;AUG 13, 1993
 ;
 ;
PTTPLST(SCTEAM,SCDATE,SCPTTP) ; -- create list of patients assigned to team positions
 ; -- sort list by dfn and position ien
 N SCPOS,SCDTE,SCPR,SCPRX
 ;
 ; -- check for patient-position assignments
 D DATE^SCMCMU1(SCDATE,.SCDTE)
 S SCPOS=$NA(^TMP("SCMU",$J,"POSITION"))
 ;
 ; -- get list of positions for team
 K @SCPOS
 IF '$$TPTM^SCAPMC24(SCTEAM,SCDTE,"","",SCPOS) S Y=-1 G PTTPLSTQ
 S SCPR=0
 F  S SCPR=$O(@SCPOS@(SCPR)) Q:'SCPR  D
 . S SCPRX=@SCPOS@(SCPR)
 . ; -- create sorted list of dfn by position ien
 . D PTTP(+SCPRX,SCDATE,SCPTTP)
 . Q
PTTPLSTQ K @SCPOS
 Q
 ;
PTTP(SCPOS,SCDATE,SCPTTP) ; -- create list of pats assigned to position sort by dfn, position
 N SCPAT,SCPATX,SCPATS,SCDTE
 D DATE^SCMCMU1(SCDATE,.SCDTE)
 S SCPATS=$NA(^TMP("SCMU",$J,"PATIENT"))
 K @SCPATS
 IF '$$PTTP^SCAPMC(SCPOS,SCDTE,SCPATS) S SCOK=0 G PTTPQ
 S SCPAT=0
 F  S SCPAT=$O(@SCPATS@(SCPAT)) Q:'SCPAT  D
 . S SCPATX=@SCPATS@(SCPAT)
 . ; -- store by dfn / pos data
 . S @SCPTTP@(+SCPATX,SCPOS)=SCPATX
 . Q
PTTPQ K @SCPATS
 Q
 ;
UNASSIGN ; -- unassign selected
 ;    protocol: SCMC MU UNASSIGN PATIENTS
 N DIR,Y
 IF 'SCSELCNT D  G UNQ
 . W !!,"No patients have been selected.",!
 . D PAUSE^SCMCMU1
 . D BACK^SCMCMU1("")
 . Q
 ELSE  D
 . D FULL^VALM1
 . W @IOF
 . S DIR(0)="YA"
 . D SET("----------------------------------------------------------------------------")
 . D SET("                      Team"_$S(SCMUTYPE="P":" Position",1:"")_" Unassignment Definition")
 . D SET("----------------------------------------------------------------------------")
 . D SET("    Team             : "_$P($G(^SCTM(404.51,SCTEAM,0),"Unknown"),U))
 . IF SCMUTYPE="P" D SET("    Position         : "_$P($G(^SCTM(404.57,SCPOS,0),"Unknown"),U))
 . D SET("    Effective Date   : "_$$FMTE^XLFDT($E(SCDATE,1,7),"5Z"))
 . D SET("    # of Patients    : "_SCSELCNT)
 . D CLINIC
 . D SET(" ")
 . S DIR("A")="Are you sure you want to continue? "
 . S DIR("B")="No"
 . D ^DIR
 . IF Y=1 D
 . . N DIR,SCTSK
 . . S SCTSK=$$QUE^SCMCMU2()
 . . IF SCTSK="" D
 . . . D BACK^SCMCMU1("R")
 . . ELSE  D
 . . . W !!,"Task#: ",SCTSK,!
 . . D PAUSE^SCMCMU1
 . . Q
 . ELSE  D
 . . D BACK^SCMCMU1("R")
 . . Q
 . Q
UNQ Q
 ;
CLINIC ; -- display clinic to be discharged from
 N SCPOS,SCX,Y
 D SET(" ")
 IF '$O(SCTPDIS(0)) D  G CLINICQ
 . D SET("    Clinic Discharges:  None")
 ;
 S Y=""
 S Y=$$SETSTR^VALM1("Clinic Discharges:",Y,5,20)
 S Y=$$SETSTR^VALM1("Position",Y,25,25)
 S Y=$$SETSTR^VALM1("Associated Clinic",Y,55,25)
 D SET(Y)
 S Y=""
 S Y=$$SETSTR^VALM1("--------",Y,25,25)
 S Y=$$SETSTR^VALM1("-----------------",Y,55,25)
 D SET(Y)
 ;
 S SCPOS=0
 F  S SCPOS=$O(SCTPDIS(SCPOS)) Q:'SCPOS  D
 . S SCX=$G(^SCTM(404.57,SCPOS,0),"Unknown")
 . S Y=""
 . S Y=$$SETSTR^VALM1($E($P(SCX,U),1,25),Y,25,25)
 . S Y=$$SETSTR^VALM1($E($P($G(^SC(+$P(SCX,U,9),0),"Unknown"),U),1,25),Y,55,25)
 . D SET(Y)
 . Q
 ;
CLINICQ Q
 ;
SET(X) ; -- set DIR text
 S DIR("A",$O(DIR("A",""),-1)+1)=X
 Q
 ;
QUIT ; -- quit logic
 ;    protocol: SCMC MU QUIT
 N DIR,Y
 S Y=0
 IF SCSELCNT D
 . W !
 . S DIR(0)="YA"
 . S DIR("A",1)="You have "_SCSELCNT_" patient"_$S(SCSELCNT=1:"",1:"s")_" selected."
 . S DIR("A",2)=" "
 . S DIR("A")="Are you sure you want to quit? "
 . S DIR("B")="No"
 . D ^DIR
 . IF Y'=1 D BACK^SCMCMU1("")
 . Q
 Q
 ;
