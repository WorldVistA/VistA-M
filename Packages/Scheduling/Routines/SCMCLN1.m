SCMCLN1 ;swo/iofobp cleanup utilities ;2.12.2007
 ;;5.3;Scheduling;**498**;8.13.1993;Build 23
 Q
INST ;check each teams institution and make sure it contains at least the
 ;stations base numeric identifier
 N SCMCSTA,SCMCL1,SCMCZN,SCMCV1,SCMCNT
 S SCMCSTA=$$NS^XUAF4(DUZ(2))
 I $G(DUZ(2))="" W !,"Institution is undefined...exiting",!! Q
 W !,"Your Station Name:  "_$P(SCMCSTA,U)
 W !,"           Number:  "_$P(SCMCSTA,U,2)
 W !,"This option will output a list of TEAMS whose Station Number association"
 W !,"does not match the number listed above.",!!
 S (SCMCL1,SCMCNT)=0
 F  S SCMCL1=$O(^SCTM(404.51,SCMCL1)) Q:'SCMCL1  D
 . S SCMCZN=$G(^SCTM(404.51,SCMCL1,0)) Q:SCMCZN=""
 . S SCMCV1=$E($P($G(^DIC(4,+$P(SCMCZN,U,7),99)),U),1,3) Q:SCMCV1=""
 . I $P(SCMCSTA,U,2)'=SCMCV1 D LOG
 . Q
 D SHOW,CLEAN
 Q
SHOW ;see what we got
 S DIOEND="D FOOT^SCMCLN1"
 S DIC="^SCTM(404.51,",L=0,BY="@.01",(FR,TO)="",FLDS=".01,.07,.07:99;""STATION #"""
 S BY(0)="^TMP(""SCMCLN1"",$J,"
 S L(0)=1 D EN1^DIP
 Q
LOG ;collect the entries with possible incorrect institution
 S ^TMP("SCMCLN1",$J,SCMCL1)=""
 S SCMCNT=SCMCNT+1
 Q
CLEAN ;clean up
 K ^TMP("SCMCLN1",$J)
 Q
FOOT ;summary footer
 I SCMCNT<1 W !!,"No problems found.",!! Q
 W !!,"The listed entries from the TEAM file need to be reviewed for Institution."
 W !,"PCMM GUI clients prior to SD*5.3*297 allowed Team association to any entry"
 W !,"in the Institution File."
 Q
