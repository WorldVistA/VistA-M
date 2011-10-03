SCMCMU ;ALB/MJK - PCMM Mass Team/Position Unassignment Utility ; 10 Jul 98
 ;;5.3;Scheduling;**148**;AUG 13, 1993
 ;
EN ; -- entry point for mass unassignment (mu)
 ;
 N SCMUTYPE,SCTEAM,SCPOS,SCABORT,SCDATE,SCDIS,SCTPDIS
 ;
 S (SCTEAM,SCPOS,SCDIS)=0
 S SCABORT=-1
 ;
 ; -- get type of md (team or position)
 S SCMUTYPE=$$TYPE()
 IF SCMUTYPE=SCABORT G ENQ
 ;
 ; -- get effective date
 S SCDATE=$$DATE()
 IF SCDATE=SCABORT G ENQ
 ;
 ; -- get team
 S SCTEAM=$$TEAM(SCDATE)
 IF SCTEAM=SCABORT G ENQ
 ;
 ; -- get position if position md
 IF SCMUTYPE="T" D  IF SCDIS=SCABORT G ENQ
 . S SCDIS=$$TMDIS(SCTEAM,SCDATE,.SCTPDIS)
 ;
 ; -- get position if position md
 IF SCMUTYPE="P" D  IF SCPOS=SCABORT!(SCDIS=SCABORT) G ENQ
 . S SCPOS=$$POS(SCTEAM,SCDATE)
 . S SCDIS=$$TPDIS(SCPOS,.SCTPDIS)
 ;
 ; -- call lm routine
 D EN^SCMCMU1(SCTEAM,SCPOS,.SCTPDIS,SCMUTYPE,SCDATE)
 ;
ENQ Q
 ;
TYPE() ; -- get type of mu
 N DIR,DIRUT,Y
 S DIR(0)="SABM^T:Team;P:Position"
 S DIR("A")="Select Type of Mass Unassignment: "
 S DIR("B")="Team"
 D ^DIR
 Q $S($D(DIRUT):-1,1:Y)
 ;
DATE() ; -- get effective date
 N DIR,DIRUT,Y
 S DIR(0)="DA^::EX"
 S DIR("A")="Effective Date: "
 S DIR("B")="T-1"
 D ^DIR
 Q $S($D(DIRUT):-1,1:Y)
 ;
TEAM(SCDATE) ; -- get team
 N DIC,Y,SCDTE
 D DATE^SCMCMU1(SCDATE,.SCDTE)
 S DIC("S")="IF +$$ACTHIST^SCAPMCU2(404.58,+Y,SCDTE)=1"
 S DIC="^SCTM(404.51,",DIC(0)="AEQM"
 D ^DIC
 Q +Y
 ;
POS(SCTEAM,SCDATE) ; -- get position for team
 N DIC,Y,SCDTE,SCPOS,SCPOSI,I
 D DATE^SCMCMU1(SCDATE,.SCDTE)
 S SCPOS=$NA(^TMP("SCMU",$J,"POSITION"))
 K @SCPOS
 IF '$$TPTM^SCAPMC24(SCTEAM,SCDTE,"","",SCPOS) S Y=-1 G POSQ
 S I=0 F  S I=$O(@SCPOS@(I)) Q:'I  S SCPOSI(+@SCPOS@(I))=""
 S DIC="^SCTM(404.57,"
 S DIC(0)="AEQM"
 S DIC("S")="IF $D(SCPOSI(+Y)),$P(^(0),U,2)=+SCTEAM,+$$ACTHIST^SCAPMCU2(404.59,+Y,SCDTE)=1"
 D ^DIC
POSQ K @SCPOS
 Q +Y
 ;
TMDIS(SCTEAM,SCDATE,SCTPDIS) ; -- discharge patient from clinics
 N DIR,Y,SCDTE,SCPOS,SCPOSI,I,SCOK,SCCL,SCCLNM,SCPOS0,SCTEAMNM
 S SCOK=1
 D DATE^SCMCMU1(SCDATE,.SCDTE)
 W !!,">>> Checking to see if any team positions are associated with clinics..."
 S SCPOS=$NA(^TMP("SCMU",$J,"POSITION"))
 K @SCPOS
 IF '$$TPTM^SCAPMC24(SCTEAM,SCDTE,"","",SCPOS) S Y=-1 G TMDISQ
 S I=0 F  S I=$O(@SCPOS@(I)) Q:'I  S SCPOSI(+@SCPOS@(I))=""
 K @SCPOS
 S SCPOS=0
 F  S SCPOS=$O(SCPOSI(SCPOS)) Q:'SCPOS  D  Q:SCOK=SCABORT
 . S SCPOS0=$G(^SCTM(404.57,+SCPOS,0))
 . S SCCL=+$P(SCPOS0,U,9)
 . IF 'SCCL Q
 . S SCCLNM=$P($G(^SC(SCCL,0)),U)
 . S SCTEAMNM=$P($G(^SCTM(404.51,SCTEAM,0),"Unknown"),U)
 . S DIR(0)="YA"
 . S DIR("A",1)="----------------------------------------------------------------------------"
 . S DIR("A",2)="             Team             : "_SCTEAMNM
 . S DIR("A",3)="             Position         : "_$P(SCPOS0,U)
 . S DIR("A",4)="             Associated Clinic: "_SCCLNM
 . S DIR("A",5)=" "
 . S DIR("A")=">>> Do you want to discharge patients from this clinic? (Yes/No) "
 . D ^DIR
 . IF $D(DIRUT) S SCOK=SCABORT Q
 . IF Y=1 S SCTPDIS(SCPOS)=1
 . Q
TMDISQ Q SCOK
 ;
TPDIS(SCPOS,SCTPDIS) ; -- discharge patient from clinic
 N SCPOS0,SCCL,SCCL0,DIR,DIRUT,Y,SCOK
 S SCOK=1
 S SCPOS0=$G(^SCTM(404.57,+SCPOS,0))
 S SCCL=+$P(SCPOS0,U,9)
 IF 'SCCL S Y=0 G TPDISQ
 S SCCLNM=$P($G(^SC(SCCL,0)),U)
 S DIR(0)="YA"
 S DIR("A",1)=" "
 S DIR("A")="Also discharge patients from the '"_SCCLNM_"' clinic? (Yes/No) "
 D ^DIR
 IF $D(DIRUT) S SCOK=SCABORT
 IF Y=1 S SCTPDIS(+SCPOS)=1
TPDISQ Q SCOK
 ;
