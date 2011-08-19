SCMCCV1 ;ALB/JLU;PC Attending conversion;5/6/99
 ;;5.3;Scheduling;**195**;AUG 13, 1993
 ;
MAIN I $$XTMP() D XTMPW G MAINQ ;is there another conversion job?
 ;
 N SCMCTM,SCMCPOS,SCMCSTOP,SCMCFIX,SCMCTYPE
 S SCMCSTOP=0
 ;
 S SCMCFIX=$$CNTFIX ;fix or check mode?
 I SCMCFIX=0 G MAINQ ;uparrowed out
 ;
 S SCMCSTOP=$$ASKQUEST ;how to sort for conversion? SETS SCMCTM, SCMCPOS
 I SCMCSTOP G MAIN Q
 ;
 D SUMARIZE ; display what was selected
 S SCMCSTOP=$$ASKCONT ;ask user if they wish to continue.
 I SCMCSTOP G MAINQ
 ;
 D QOFF ;queue off the conversion job
 ;
MAINQ Q
 ;
XTMPW ;writes to the user.
 ;
 N VAR
 S VAR=$O(^XTMP("SCMCATTCONV",0))
 ;
 W *7,!!,"A conversion job (#"_VAR_") has already been started."
 W !,"You will not be able to start another conversion job until this one finishes.",!!
 D PAUSE^SCMCMU1
 Q
 ;
XTMP() ;checks to see if another job is running.
 ;
 Q $S($D(^XTMP("SCMCATTCONV")):1,1:0)
 ;
CNTFIX() ;ask the user if they want to FIX(Convert) or CHECK
 ;Output  F for FIX mode
 ;        C for Check mode
 ;
 N DIR
 S DIR(0)="SM^C:CHECK;F:FIX"
 S DIR("?")="Check mode will only count the entries that could or could not be converted."
 S DIR("?",1)="Fix mode will actually convert these entries."
 S DIR("A")="In which mode would you like to run the conversion?"
 D ^DIR
 Q $S($D(DIRUT):0,1:Y)
 ;
ASKQUEST() ;askes the user how they wish to sort or break up the conversion.
 ;Outputs
 ;sets up the SCMCTM and SCMCPOS arrays
 ;returns a 1 if to stop
 ;returns a zero to not stop
 ;
 N STOP
 S STOP=0
 S SCMCTYPE=$$TYPE() ;gets the type of selection (team, position or all)
 I SCMCTYPE=0 S STOP=1 G ASKQSTQ
 ;
 I SCMCTYPE="T" D TMLP S:'$D(SCMCTM) STOP=1 ;team selection
 ;
 I SCMCTYPE="P" D POS S:'$D(SCMCTM)!('$D(SCMCPOS)) STOP=1 ;position selection
 ;
 I SCMCTYPE="A" K SCMCTM,SCMCPOS
 ;
ASKQSTQ Q STOP
 ;
 ;
TYPE() ;askes the user how they wish to sort or select the conversion.
 ;A for All teams and positions
 ;T for by selecting teams.  All positions for each team.
 ;P for by selection positions.  Only one team and specific positions.
 ;
 ;returns a zero to quit
 ;returns a one to continue
 ;
 N DIR
 S DIR(0)="SM^A:All teams and positions;T:Specific teams;P:One team, specifc positions"
 S DIR("?",1)="Select A for a conversion of all teams and all positions on those teams."
 S DIR("?",2)="Select T to select specific teams.  All positions for each team are reviewed."
 S DIR("?",3)="Select P to be able to select specific positions from a single team."
 S DIR("?")=" "
 ;
 D ^DIR
 Q $S($D(DIRUT):0,1:Y)
 ;
 ;
TMLP ;allows the user to select which teams.  Allows the selection of
 ;multiple teams.
 ;sets up the SCMCTM array with the teams
 ;sets stop=1 if need to stop
 ;
 N SCSTOP
 S SCSTOP=0
 F  D  I SCSTOP Q
 .N TM
 .S TM=$$TEAM^SCMCMU(DT)
 .I TM>0 S SCMCTM(TM)=""
 .E  S SCSTOP=1
 .Q
 Q
 ;
POSLP(TM) ;allows the user to select one team and multiple positions from that
 ;team.
 ;the SCMCTM and SCMCPOS arrays will be populated.
 ;
 N SCSTOP
 S SCSTOP=0
 K SCMCPOS
 F  DO  I SCSTOP Q
 .N POS
 .S POS=$$POS^SCMCMU(TM,DT) ; get positions using today.
 .I POS>0 S SCMCPOS(POS)=""
 .E  S SCSTOP=1
 .Q
 Q
 ;
POS ;gets the team first then calls POSLP to get the positions
 ;populates the SCMCTM array
 ;
 N TTM
 K SCMCTM
 S TTM=$$TEAM^SCMCMU(DT)
 I TTM>0 DO
 .S SCMCTM(TTM)=""
 .D POSLP(TTM)
 .Q
 Q
 ;
 ;
SUMARIZE ;presents the selections to the user.
 ;
 W !!!,"You have made the following selections."
 W !,"Please verify they are what you want:",!
 ;
 I SCMCTYPE="A" D TYPEA
 I SCMCTYPE="T" D TYPET
 I SCMCTYPE="P" D TYPEP
 ;
 W !!,*7,"** This job will be run in a ",$S(SCMCFIX="F":"FIX",1:"CHECK")," mode. **",!
 Q
 ;
 ;
TYPEA ;
 W !,"You have selected to convert assignments in all teams and positions."
 Q
 ;
 ;
TYPET ;
 N VAR
 W !,"You have selected to convert PC Attending assignments in the following teams:"
 ;
 S VAR=0
 F  S VAR=$O(SCMCTM(VAR)) Q:VAR=""  W !,$P(^SCTM(404.51,VAR,0),U,1)
 ;
 W !!,"All position assignments for each team will be reviewed."
 Q
 ;
 ;
TYPEP ;
 N LP,VAR
 S VAR=$O(SCMCTM(0)) Q:VAR=""
 ;
 W !,"You have selected to convert PC Attending assignments for team:"
 W !,$P(^SCTM(404.51,VAR,0),U,1)
 W !!,"The positions that were selected are:"
 ;
 S VAR=0
 F  S VAR=$O(SCMCPOS(VAR)) Q:VAR=""  W !,$P(^SCTM(404.57,VAR,0),U,1)
 Q
 ;
 ;
ASKCONT() ;ask the user if they wish to continue.
 ;
 N Y,DIR
 S DIR(0)="Y^"
 S DIR("A")="Are these selections correct?  Do you wish to continue"
 D ^DIR
 Q $S(Y=1:0,1:1) ; CHANGING TO MATCH STOP FORMAT.
 ;
 ;
SETLOCK ; sets the global to lock out other attempted jobs
 ;
 S ^XTMP("SCMCATTCONV",0)=DT+1_"^"_DT
 Q
 ;
 ;
QOFF ;queue the task off to be processed in the background.
 ;
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="STRTQJOB^SCMCCV2"
 S ZTDESC="PCMM conversion of PC Attending assignments."
 S ZTDTH=$H
 S ZTIO=""
 S ZTSAVE("SCMCTM(")=""
 S ZTSAVE("SCMCPOS(")=""
 S ZTSAVE("SCMCFIX")=""
 S ZTSAVE("SCMCTYPE")=""
 D ^%ZTLOAD
 I $D(ZTSK) W !!,"Task queued. ",ZTSK D SETLOCK ;LOCKS FOR NEXT ATTEMPT
 E  W !!,"Task NOT queued."
 K ZTSK
 Q
 ;
 ;
FUTURE ;checks if can make an assignment for today.
 ;
 N VARTWO
 K ERR
 S VARTWO=$$YSPTTPPC^SCMCTPU2(DFN,DT,1)
 I 'VARTWO S ERR="-"_$P(VARTWO,U,2) D SETERR^SCMCCV2(ERR) Q
 S REASSIGN=1
 Q
 ;
 ;
REOPEN ;reactivate old assignment.
 ;
 N DA,DR,DIE
 S DIE="^SCPT(404.43,"
 S DA=POSASGN
 D NOW^%DTC
 S DR=".04///@;.08///"_$G(DUZ,.5)_";.09///"_%
 K X
 D ^DIE
 Q
 ;
 ;
CHANGE(AIEN) ;the actual FM call to convert.
 N DIE,DA,DR
 S DIE="^SCPT(404.43,"
 S DA=AIEN
 S DR=".05///1"
 D ^DIE
 Q
 ;
 ;
INIT ;set up variables
 ;
 S XMDUZ=.5
 S XMY($S($G(DUZ):DUZ,1:XMDUZ))=""
 S XMSUB="PC Attending conversion"
 S XMTEXT="^TMP(""SCMC"",$J,""MSG"","
 S CNTR=0
 Q
